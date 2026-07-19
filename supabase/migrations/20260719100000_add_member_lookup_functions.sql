-- Mitglieder-Verwaltungs-UI: E-Mail -> user_id-Lookup + Mitgliederliste
--
-- Hintergrund: Ein admin soll neue Mitglieder per E-Mail-Adresse zu
-- memberships hinzufügen können, statt wie bisher per manuellem
-- `docker compose exec ... psql ... insert into memberships ...`
-- (siehe supabase/README.md). auth.users liegt im auth-Schema und ist über
-- PostgREST nicht erreichbar (PGRST_DB_SCHEMA=public), daher zwei neue
-- security-definer-Funktionen im public-Schema, analog zum bestehenden
-- Muster von has_workgroup_role().
--
-- Sicherheit: security definer umgeht RLS. Beide Funktionen prüfen den
-- admin-Status deshalb selbst (nicht nur über eine RLS-Policy) — ohne diese
-- Prüfung könnte jeder eingeloggte Nutzer beliebige E-Mail->user_id-
-- Zuordnungen abfragen oder die Mitgliederliste jeder beliebigen Workgroup
-- lesen. errcode 42501 ('insufficient_privilege') liefert über PostgREST
-- HTTP 403, passt zum bestehenden httpErrorHint()-Muster im Editor.
-- Bekanntes, akzeptiertes Restrisiko: Ein admin kann per Ausprobieren
-- verschiedener E-Mail-Adressen herausfinden, ob ein Account existiert
-- (Email-Enumeration) — unkritisch, da nur wenige vertrauenswürdige Admins
-- Zugriff auf diese Funktion haben.
--
-- lookup_user_by_email gibt bewusst nur eine einzelne uuid zurück, keine
-- weiteren auth.users-Spalten (kein Passwort-Hash o.ä.) — minimale
-- Angriffsfläche.

create or replace function public.lookup_user_by_email(p_email text, p_workgroup_id uuid)
returns uuid
language plpgsql
security definer
stable
as $$
declare v_id uuid;
begin
  if not has_workgroup_role(p_workgroup_id, 'admin') then
    raise exception 'insufficient_privilege' using errcode = '42501';
  end if;
  select id into v_id from auth.users where lower(email) = lower(p_email);
  return v_id;
end;
$$;

comment on function public.lookup_user_by_email is
  'Für admin: löst eine E-Mail-Adresse zur user_id auf (null, falls kein Account existiert). Voraussetzung für das Hinzufügen eines neuen Mitglieds in der Editor-UI.';

create or replace function public.list_workgroup_members(p_workgroup_id uuid)
returns table (id uuid, user_id uuid, email text, rolle text, created_at timestamptz)
language plpgsql
security definer
stable
as $$
begin
  if not has_workgroup_role(p_workgroup_id, 'admin') then
    raise exception 'insufficient_privilege' using errcode = '42501';
  end if;
  return query
    select m.id, m.user_id, u.email::text, m.rolle, m.created_at
    from memberships m join auth.users u on u.id = m.user_id
    where m.workgroup_id = p_workgroup_id
    order by u.email;
end;
$$;

comment on function public.list_workgroup_members is
  'Für admin: Mitgliederliste einer Workgroup inkl. E-Mail-Adresse (memberships selbst hat keine E-Mail-Spalte, nur user_id).';

grant execute on function public.lookup_user_by_email(text, uuid) to authenticated;
grant execute on function public.list_workgroup_members(uuid) to authenticated;
