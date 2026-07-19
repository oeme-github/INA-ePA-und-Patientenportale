-- Einladungs-gesteuerte Selbstregistrierung
--
-- Hintergrund: shared/auth.js rief GoTrue /otp bisher mit create_user:false
-- auf — Magic-Link funktionierte damit nur für bereits bestehende Accounts,
-- nie zur Erstregistrierung (Fehler "Signups not allowed for otp" bei
-- unbekannter E-Mail). Es gab überhaupt keinen Weg, wie ein neues
-- AG-Mitglied sich selbst ein Konto anlegen konnte — die drei Testnutzer
-- wurden bislang ausschließlich manuell per `curl POST /signup` erzeugt.
--
-- Fix: create_user wird auf true gestellt (siehe separate Änderung an
-- shared/auth.js), aber nicht unkontrolliert — nur E-Mail-Adressen, die ein
-- admin vorher in `pending_invites` eingetragen hat, dürfen sich per
-- Magic-Link tatsächlich ein Konto anlegen. Bei erfolgreicher Registrierung
-- wird die vorgesehene Mitgliedschaft automatisch angelegt, die Einladung
-- verbraucht sich selbst.

create table pending_invites (
  id            uuid primary key default gen_random_uuid(),
  workgroup_id  uuid not null references workgroups(id) on delete cascade,
  email         text not null,
  rolle         text not null check (rolle in ('viewer', 'editor', 'admin')),
  invited_by    uuid references auth.users(id),
  invited_at    timestamptz not null default now(),
  unique (workgroup_id, email)
);

comment on table pending_invites is
  'Von einem admin vorab freigegebene E-Mail-Adressen für eine Workgroup. Gate für die Selbstregistrierung per Magic-Link (siehe gate_new_user_signup()) — wird bei erfolgreicher Registrierung automatisch verbraucht (siehe provision_membership_from_invite()).';

alter table pending_invites enable row level security;

create policy "Admins verwalten Einladungen" on pending_invites
  for all using (has_workgroup_role(workgroup_id, 'admin'));

-- ── Gate: neue auth.users-Zeile nur bei bestehender Einladung ───────────
-- security definer, damit die Prüfung unabhängig davon greift, welche
-- DB-Rolle den INSERT ausführt (GoTrue schreibt als eigene, privilegierte
-- Rolle, nicht als "authenticated" — RLS auf pending_invites würde hier
-- ohnehin nicht greifen, die Prüfung erfolgt bewusst explizit).
create or replace function public.gate_new_user_signup()
returns trigger
language plpgsql
security definer
as $$
begin
  if not exists (
    select 1 from pending_invites where lower(email) = lower(new.email)
  ) then
    raise exception 'Keine Einladung für diese E-Mail-Adresse gefunden — bitte einen Admin der Arbeitsgruppe bitten, die Adresse freizuschalten.'
      using errcode = '42501';
  end if;
  return new;
end;
$$;

comment on function public.gate_new_user_signup is
  'Blockiert die Anlage neuer auth.users-Zeilen, wenn keine passende pending_invites-Zeile existiert. Betrifft nur echte Neuanmeldungen (create_user:true) — bestehende Nutzer lösen beim erneuten Magic-Link-Anfordern keinen INSERT aus, GoTrue aktualisiert dort nur die vorhandene Zeile.';

create trigger gate_new_user_signup_trigger
  before insert on auth.users
  for each row execute function public.gate_new_user_signup();

-- ── Auto-Provisionierung: Mitgliedschaft(en) aus verbrauchter Einladung ──
create or replace function public.provision_membership_from_invite()
returns trigger
language plpgsql
security definer
as $$
declare
  v_invite record;
begin
  for v_invite in
    select * from pending_invites where lower(email) = lower(new.email)
  loop
    insert into memberships (user_id, workgroup_id, rolle)
    values (new.id, v_invite.workgroup_id, v_invite.rolle)
    on conflict (user_id, workgroup_id) do update set rolle = excluded.rolle;
  end loop;

  delete from pending_invites where lower(email) = lower(new.email);
  return new;
end;
$$;

comment on function public.provision_membership_from_invite is
  'Legt nach erfolgreicher Registrierung automatisch die vorgesehene(n) memberships-Zeile(n) an (eine Person kann für mehrere Workgroups gleichzeitig eingeladen sein) und löscht die verbrauchte(n) Einladung(en). AFTER INSERT statt BEFORE, weil new.id erst nach dem eigentlichen Insert existiert.';

create trigger provision_membership_from_invite_trigger
  after insert on auth.users
  for each row execute function public.provision_membership_from_invite();
