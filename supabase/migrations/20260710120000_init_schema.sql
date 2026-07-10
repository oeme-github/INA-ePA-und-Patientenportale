-- Initiales Schema: generische mehrdimensionale Prozesskatalog-Engine
--
-- Hintergrund: Die Prozesslandkarte soll auch von anderen Arbeitsgruppen genutzt
-- werden können, die eigene Phasen, Datenräume, Domänen oder ganz neue Kategorien
-- brauchen. Deshalb sind Phasen und Datenräume hier keine Sonderfälle mehr,
-- sondern nur Instanzen desselben generischen "dimensions"-Mechanismus wie
-- Domänen, Akteure oder Rechtsgrundlagen. Siehe KONTEXT.md, Abschnitt
-- "Architekturentscheidung: Multi-User-Web-Tool" für die Begründung.
--
-- Status: Erster Entwurf (Skizze) — vor Anwendung gegen ein echtes Supabase-
-- Projekt prüfen, insbesondere die RLS-Policies und Rollen-Hierarchie.

create extension if not exists "pgcrypto";

-- ── Arbeitsgruppen (Mandanten) ─────────────────────────────────────────────

create table workgroups (
  id          uuid primary key default gen_random_uuid(),
  key         text not null unique,        -- url-/code-freundlicher Kurzname, z.B. 'ak-patientenportale'
  name        text not null,               -- Anzeigename, z.B. 'AK Patientenportale'
  created_at  timestamptz not null default now()
);

comment on table workgroups is 'Eine Zeile pro Arbeitsgruppe/Mandant. Jede Arbeitsgruppe hat ihre eigenen Dimensionen und Prozessschritte.';

-- ── Dimensionen (Kategorien/Achsen, u.a. Phase und Datenraum) ──────────────

create table dimensions (
  id                    uuid primary key default gen_random_uuid(),
  workgroup_id          uuid not null references workgroups(id) on delete cascade,
  key                   text not null,      -- z.B. 'phase', 'datenraum', 'domaene', 'akteur', 'rechtsgrundlage'
  label                 text not null,      -- Anzeigename, z.B. 'Phase'
  typ                   text not null check (typ in ('single_select', 'multi_select', 'text')),
  ist_navigationsachse  boolean not null default false,  -- true = wird wie heute "vor/im/nach" als Tab-Leiste gerendert
  reihenfolge           int not null default 0,
  farbe                 text,               -- optionale Hex-Farbe für die UI
  created_at            timestamptz not null default now(),
  unique (workgroup_id, key)
);

comment on table dimensions is 'Kategorien/Achsen einer Arbeitsgruppe. "Phase" und "Datenraum" sind hier nur zwei Zeilen unter vielen, keine hart codierten Sonderfälle.';

-- ── Werte innerhalb einer Dimension (z.B. die Domänen-Liste, die Phasen-Liste) ─

create table dimension_values (
  id            uuid primary key default gen_random_uuid(),
  dimension_id  uuid not null references dimensions(id) on delete cascade,
  key           text not null,      -- z.B. 'vor', 'im', 'nach' innerhalb der Dimension 'phase'
  label         text not null,
  reihenfolge   int not null default 0,
  farbe         text,
  created_at    timestamptz not null default now(),
  unique (dimension_id, key)
);

comment on table dimension_values is 'Pflegbare Auswahllisten-Einträge einer Dimension (ersetzt das heutige meta-Objekt in patientenpfad_data.js).';

-- ── Prozessschritte ─────────────────────────────────────────────────────────
-- Bewusst minimal: nur das, was universell für jeden Prozessschritt gilt.
-- Alles fachlich Spezifische (Akteur, Objekt, Operation, Domäne, Gesetze,
-- Standards, Struktur, Ist/Lücke/Forderungen, ...) hängt über
-- process_step_values an Dimensionen und ist damit pro Arbeitsgruppe frei
-- erweiterbar, ohne dass diese Tabelle geändert werden muss.

create table process_steps (
  id            uuid primary key default gen_random_uuid(),
  workgroup_id  uuid not null references workgroups(id) on delete cascade,
  nr            int not null,       -- laufende Nummer/Sortierung innerhalb der Arbeitsgruppe
  titel         text not null,
  created_at    timestamptz not null default now(),
  updated_at    timestamptz not null default now(),
  updated_by    uuid references auth.users(id),
  unique (workgroup_id, nr)
);

comment on table process_steps is 'Ein Prozessschritt. Fachliche Felder liegen nicht hier, sondern in process_step_values (siehe dort).';

-- ── Zuordnung Prozessschritt × Dimension × Wert(e) ─────────────────────────
-- Für single_select/multi_select-Dimensionen ist dimension_value_id gesetzt
-- (bei multi_select mehrere Zeilen pro Prozessschritt+Dimension möglich).
-- Für text-Dimensionen (z.B. "ist", "luecke", "forderungen", "detail") ist
-- stattdessen text_value gesetzt und dimension_value_id bleibt leer.

create table process_step_values (
  id                  uuid primary key default gen_random_uuid(),
  process_step_id     uuid not null references process_steps(id) on delete cascade,
  dimension_id        uuid not null references dimensions(id) on delete cascade,
  dimension_value_id  uuid references dimension_values(id) on delete cascade,
  text_value          text,
  check (
    (dimension_value_id is not null and text_value is null)
    or (dimension_value_id is null and text_value is not null)
  )
);

create index on process_step_values (process_step_id);
create index on process_step_values (dimension_id);
create index on process_step_values (dimension_value_id);

comment on table process_step_values is 'Generische Zuordnungstabelle: welcher Prozessschritt hat welchen Wert in welcher Dimension. Ersetzt die heutigen festen Felder wie domäne/gesetze/akteur/op/struktur/ist/luecke/forderungen.';

-- ── Mitgliedschaften / Rollen ───────────────────────────────────────────────

create table memberships (
  id            uuid primary key default gen_random_uuid(),
  user_id       uuid not null references auth.users(id) on delete cascade,
  workgroup_id  uuid not null references workgroups(id) on delete cascade,
  rolle         text not null check (rolle in ('viewer', 'editor', 'admin')),
  created_at    timestamptz not null default now(),
  unique (user_id, workgroup_id)
);

comment on table memberships is 'Wer darf in welcher Arbeitsgruppe was: viewer (nur lesen), editor (lesen+schreiben), admin (zusätzlich Dimensionen/Mitgliedschaften verwalten).';

-- ── Änderungsprotokoll (Ersatz für den heutigen Git-Commit-Audit-Trail) ─────
-- Einfacher Ansatz als Ausgangspunkt; ob das als hartes Anforderungskriterium
-- gilt, ist laut KONTEXT.md noch offen zu klären.

create table process_step_audit (
  id                uuid primary key default gen_random_uuid(),
  process_step_id   uuid not null references process_steps(id) on delete cascade,
  changed_by        uuid references auth.users(id),
  changed_at        timestamptz not null default now(),
  change_type       text not null check (change_type in ('insert', 'update', 'delete')),
  old_data          jsonb,
  new_data          jsonb
);

comment on table process_step_audit is 'Protokoll von Änderungen an Prozessschritten, als Ersatz für den bisherigen Git-Commit-Verlauf.';

-- ── Row-Level-Security ──────────────────────────────────────────────────────
-- Grundprinzip: Zugriff nur auf Arbeitsgruppen, in denen man Mitglied ist;
-- Schreibzugriff nur mit Rolle editor/admin.

create or replace function has_workgroup_role(wg_id uuid, min_role text)
returns boolean
language sql
security definer
stable
as $$
  select exists (
    select 1
    from memberships m
    where m.workgroup_id = wg_id
      and m.user_id = auth.uid()
      and (
        min_role = 'viewer'
        or (min_role = 'editor' and m.rolle in ('editor', 'admin'))
        or (min_role = 'admin' and m.rolle = 'admin')
      )
  );
$$;

comment on function has_workgroup_role is 'Hilfsfunktion für RLS-Policies: prüft, ob der aktuelle Nutzer mindestens die angegebene Rolle in der Arbeitsgruppe hat (viewer < editor < admin).';

alter table workgroups enable row level security;
alter table dimensions enable row level security;
alter table dimension_values enable row level security;
alter table process_steps enable row level security;
alter table process_step_values enable row level security;
alter table memberships enable row level security;
alter table process_step_audit enable row level security;

create policy "Mitglieder sehen ihre Arbeitsgruppe" on workgroups
  for select using (has_workgroup_role(id, 'viewer'));

create policy "Mitglieder lesen Dimensionen" on dimensions
  for select using (has_workgroup_role(workgroup_id, 'viewer'));
create policy "Admins verwalten Dimensionen" on dimensions
  for all using (has_workgroup_role(workgroup_id, 'admin'));

create policy "Mitglieder lesen Dimension-Werte" on dimension_values
  for select using (
    exists (select 1 from dimensions d where d.id = dimension_id and has_workgroup_role(d.workgroup_id, 'viewer'))
  );
create policy "Editoren pflegen Dimension-Werte" on dimension_values
  for all using (
    exists (select 1 from dimensions d where d.id = dimension_id and has_workgroup_role(d.workgroup_id, 'editor'))
  );

create policy "Mitglieder lesen Prozessschritte" on process_steps
  for select using (has_workgroup_role(workgroup_id, 'viewer'));
create policy "Editoren pflegen Prozessschritte" on process_steps
  for all using (has_workgroup_role(workgroup_id, 'editor'));

create policy "Mitglieder lesen Prozessschritt-Werte" on process_step_values
  for select using (
    exists (
      select 1 from process_steps p
      where p.id = process_step_id and has_workgroup_role(p.workgroup_id, 'viewer')
    )
  );
create policy "Editoren pflegen Prozessschritt-Werte" on process_step_values
  for all using (
    exists (
      select 1 from process_steps p
      where p.id = process_step_id and has_workgroup_role(p.workgroup_id, 'editor')
    )
  );

create policy "Nutzer sehen eigene Mitgliedschaften" on memberships
  for select using (user_id = auth.uid() or has_workgroup_role(workgroup_id, 'admin'));
create policy "Admins verwalten Mitgliedschaften" on memberships
  for all using (has_workgroup_role(workgroup_id, 'admin'));

create policy "Mitglieder lesen Änderungsprotokoll" on process_step_audit
  for select using (
    exists (
      select 1 from process_steps p
      where p.id = process_step_id and has_workgroup_role(p.workgroup_id, 'viewer')
    )
  );
