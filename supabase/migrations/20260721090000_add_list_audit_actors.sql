-- Verlauf-UI (T13): Akteure des Änderungsprotokolls auflösen
--
-- process_step_audit.changed_by ist eine rohe auth.users.id (uuid) ohne
-- Möglichkeit für PostgREST, sie automatisch zur E-Mail-Adresse aufzulösen
-- (kein FK, und auth.users liegt ohnehin außerhalb von PGRST_DB_SCHEMA).
-- list_workgroup_members() (Migration 20260719100000) käme dem nahe, ist
-- aber aus zwei Gründen ungeeignet: (1) sie ist admin-gated — das
-- Änderungsprotokoll selbst ist laut RLS-Policy "Mitglieder lesen
-- Änderungsprotokoll" aber ab der Rolle viewer lesbar, eine Verlaufs-Ansicht,
-- die heimlich admin voraussetzt, wäre falsch; (2) sie geht von aktuellen
-- memberships aus, das Protokoll überlebt aber bewusst das Entfernen eines
-- Mitglieds (process_step_id ohne FK, Migration 20260719110000) — ein
-- Akteur, der zwischenzeitlich aus der Arbeitsgruppe entfernt wurde, muss
-- trotzdem noch auflösbar bleiben.
--
-- list_audit_actors() liefert deshalb gezielt nur die E-Mail-Adressen der
-- Nutzer, die tatsächlich mindestens eine Zeile in process_step_audit dieser
-- Arbeitsgruppe hinterlassen haben (kein SELECT über ganz auth.users) —
-- minimale Angriffsfläche, analog zur Begründung bei lookup_user_by_email.
-- Gate ist has_workgroup_role(..., 'viewer'), nicht 'admin', damit sie zur
-- SELECT-Policy des Protokolls selbst passt.
create or replace function public.list_audit_actors(p_workgroup_id uuid)
returns table (user_id uuid, email text)
language plpgsql
security definer
stable
as $$
begin
  if not has_workgroup_role(p_workgroup_id, 'viewer') then
    raise exception 'insufficient_privilege' using errcode = '42501';
  end if;
  return query
    select distinct a.changed_by, u.email::text
    from process_step_audit a
    join auth.users u on u.id = a.changed_by
    where a.workgroup_id = p_workgroup_id
      and a.changed_by is not null;
end;
$$;

comment on function public.list_audit_actors is
  'Für jedes Workgroup-Mitglied (ab viewer): E-Mail-Adressen der Nutzer, die in process_step_audit dieser Arbeitsgruppe als changed_by auftauchen — auch falls sie die Arbeitsgruppe zwischenzeitlich verlassen haben. Grundlage für die Verlauf-Anzeige im Editor (T13).';

grant execute on function public.list_audit_actors(uuid) to authenticated;
