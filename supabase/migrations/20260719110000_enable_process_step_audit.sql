-- Cutover-Checkliste: Audit-/Versionsprotokoll aktivieren
--
-- process_step_audit wurde in 20260710120000_init_schema.sql als reine
-- Struktur angelegt, aber nie befüllt ("Ersatz für den bisherigen
-- Git-Commit-Verlauf"). Diese Migration macht sie tatsächlich nutzbar.
--
-- Schema-Korrektur zuerst nötig: process_step_id hatte einen
-- `references process_steps(id) on delete cascade`-Fremdschlüssel. Für ein
-- Audit-Log ist das falsch — es würde beim Löschen eines Prozessschritts
-- die eigene Löschprotokoll-Zeile gleich wieder mitlöschen (Cascade), und
-- ein neuer Eintrag für genau dieses Löschereignis könnte gar nicht erst
-- eingefügt werden (Fremdschlüssel-Verletzung, da die referenzierte Zeile
-- zu diesem Zeitpunkt bereits weg ist). Historische Protokoll-Zeilen dürfen
-- die Existenz der protokollierten Zeile nicht voraussetzen.
alter table process_step_audit drop constraint process_step_audit_process_step_id_fkey;
comment on column process_step_audit.process_step_id is
  'Historische Referenz auf process_steps.id — bewusst OHNE Fremdschlüssel, damit das Protokoll auch nach dem Löschen eines Prozessschritts erhalten bleibt.';

-- workgroup_id wird denormalisiert direkt mitgeführt (nicht per Join auf
-- process_steps ermittelt), aus zwei Gründen: (1) die RLS-Select-Policy
-- muss auch nach dem Löschen des Prozessschritts noch funktionieren, (2)
-- beim Cascade-Löschen der zugehörigen process_step_values ist der
-- Eltern-Prozessschritt zum Zeitpunkt des Kind-Triggers bereits gelöscht,
-- ein Join würde dort nichts mehr finden.
alter table process_step_audit add column workgroup_id uuid references workgroups(id) on delete cascade;
-- Tabelle ist bislang leer (nie befüllt) — direkt NOT NULL setzen, kein Backfill nötig.
alter table process_step_audit alter column workgroup_id set not null;

drop policy "Mitglieder lesen Änderungsprotokoll" on process_step_audit;
create policy "Mitglieder lesen Änderungsprotokoll" on process_step_audit
  for select using (has_workgroup_role(workgroup_id, 'viewer'));

-- ── Rauschunterdrückung für das Seed-Skript ─────────────────────────────
-- seed_ak_patientenportale.py löscht/schreibt bei jedem (auch wiederholten,
-- bewusst idempotenten) Lauf alle process_step_values komplett neu, egal
-- ob sich inhaltlich etwas geändert hat. Ohne diese Bremse würde jeder
-- Reseed-Lauf hunderte Protokoll-Zeilen erzeugen und den "Ersatz für den
-- Git-Commit-Verlauf" binnen kurzem unbrauchbar machen. Das Skript setzt
-- vor seinen eigenen Schreibzugriffen `set local app.skip_audit = 'on'`
-- (nur für die laufende Transaktion, keine globale Einstellung).
create or replace function public.audit_should_skip()
returns boolean
language sql
stable
as $$
  select coalesce(current_setting('app.skip_audit', true), '') = 'on';
$$;

comment on function public.audit_should_skip is
  'Prüfschalter für die Audit-Trigger: true, wenn die laufende Transaktion sich per set local app.skip_audit=on selbst als nicht-protokollierungswürdig markiert hat (z.B. seed_ak_patientenportale.py beim erneuten Einspielen unveränderter Daten).';

-- ── Trigger: process_steps (nr, titel) ──────────────────────────────────
-- security definer: process_step_audit hat bewusst keine Schreib-Policy
-- (siehe init_schema.sql) — der Trigger, als Tabelleneigentümer ausgeführt,
-- umgeht RLS gezielt nur für diesen einen Zweck.
create or replace function public.audit_process_steps_changes()
returns trigger
language plpgsql
security definer
as $$
begin
  if audit_should_skip() then
    return coalesce(new, old);
  end if;
  if tg_op = 'INSERT' then
    insert into process_step_audit (process_step_id, workgroup_id, changed_by, change_type, new_data)
    values (new.id, new.workgroup_id, auth.uid(), 'insert', to_jsonb(new));
    return new;
  elsif tg_op = 'UPDATE' then
    insert into process_step_audit (process_step_id, workgroup_id, changed_by, change_type, old_data, new_data)
    values (new.id, new.workgroup_id, auth.uid(), 'update', to_jsonb(old), to_jsonb(new));
    return new;
  else -- DELETE
    insert into process_step_audit (process_step_id, workgroup_id, changed_by, change_type, old_data)
    values (old.id, old.workgroup_id, auth.uid(), 'delete', to_jsonb(old));
    return old;
  end if;
end;
$$;

create trigger process_steps_audit
  after insert or update or delete on process_steps
  for each row execute function public.audit_process_steps_changes();

-- ── Trigger: process_step_values (Akteure, Objekte, Rechtsgrundlagen, ...) ──
-- Die eigentlichen fachlichen Inhalte eines Prozessschritts liegen nicht in
-- process_steps, sondern hier (generisches Datenmodell) — ohne diesen
-- Trigger würde das Protokoll fast alle inhaltlichen Änderungen verpassen.
create or replace function public.audit_process_step_values_changes()
returns trigger
language plpgsql
security definer
as $$
declare
  v_step_id uuid := coalesce(new.process_step_id, old.process_step_id);
  v_workgroup_id uuid;
begin
  if audit_should_skip() then
    return coalesce(new, old);
  end if;

  select workgroup_id into v_workgroup_id from process_steps where id = v_step_id;
  if v_workgroup_id is null then
    -- Der übergeordnete Prozessschritt existiert nicht mehr — Cascade-Delete
    -- durch das Löschen des ganzen Schritts, dessen Löschung der
    -- process_steps-Trigger bereits protokolliert hat. Keine zusätzliche
    -- Zeile pro betroffenem Wert nötig (und ohne workgroup_id ohnehin nicht
    -- sinnvoll lesbar über die RLS-Policy).
    return coalesce(new, old);
  end if;

  if tg_op = 'INSERT' then
    insert into process_step_audit (process_step_id, workgroup_id, changed_by, change_type, new_data)
    values (new.process_step_id, v_workgroup_id, auth.uid(), 'insert', to_jsonb(new));
    return new;
  elsif tg_op = 'UPDATE' then
    insert into process_step_audit (process_step_id, workgroup_id, changed_by, change_type, old_data, new_data)
    values (new.process_step_id, v_workgroup_id, auth.uid(), 'update', to_jsonb(old), to_jsonb(new));
    return new;
  else -- DELETE
    insert into process_step_audit (process_step_id, workgroup_id, changed_by, change_type, old_data)
    values (old.process_step_id, v_workgroup_id, auth.uid(), 'delete', to_jsonb(old));
    return old;
  end if;
end;
$$;

create trigger process_step_values_audit
  after insert or update or delete on process_step_values
  for each row execute function public.audit_process_step_values_changes();
