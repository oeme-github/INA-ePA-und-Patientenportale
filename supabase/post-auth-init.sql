-- Einmalig ausführen, NACHDEM der auth-Service zum ersten Mal gestartet ist
-- (GoTrue muss auth.users bereits angelegt haben).
--
-- Im vollen supabase/postgres-Image bekommt auth.users.role einen Spalten-
-- Default 'authenticated', damit neu registrierte Nutzer automatisch die
-- Rolle "authenticated" im JWT bekommen. Da wir dieses Image bewusst nicht
-- nutzen (siehe KONTEXT.md), fehlt dieser Default hier – ohne ihn liefert
-- GoTrue ein JWT mit role:"" (leer), und PostgREST kann per SET ROLE nicht
-- auf "anon"/"authenticated" wechseln. GOTRUE_JWT_DEFAULT_GROUP_NAME ist in
-- dieser GoTrue-Version ein reines No-op (Deprecation-Hinweis im Log) und
-- ersetzt diesen Default NICHT.
--
-- Ein reiner Spalten-Default reicht NICHT: GoTrue schreibt bei jedem Signup
-- explizit role='' (leerer String, nicht NULL, nicht weggelassen) – ein
-- Default greift nur, wenn die Spalte in der INSERT-Anweisung fehlt, nicht
-- wenn sie explizit auf '' gesetzt wird.
--
-- Ein BEFORE-INSERT-Trigger allein reicht AUCH NICHT (gefunden beim T09-Test):
-- GoTrue scheint den User-Datensatz nach dem initialen Insert im selben
-- Signup/Verify-Ablauf noch mindestens einmal per UPDATE zu überschreiben,
-- offenbar mit einem in Go noch leeren Role-Feld aus dem Moment der
-- Objekterzeugung (nicht dem per Trigger korrigierten DB-Wert). Ein frisch
-- angelegter Nutzer hatte direkt nach /signup (vor jedem /verify) bereits
-- wieder role='' in der DB, obwohl der Trigger beim Insert nachweislich
-- feuert (manuell getestet). Deshalb muss der Trigger auch bei UPDATE
-- greifen, nicht nur bei INSERT.
alter table auth.users alter column role set default 'authenticated';

create or replace function auth.set_default_role() returns trigger
  language plpgsql
as $$
begin
  if new.role is null or new.role = '' then
    new.role := 'authenticated';
  end if;
  return new;
end;
$$;

drop trigger if exists set_default_role on auth.users;
create trigger set_default_role before insert or update on auth.users
  for each row execute function auth.set_default_role();

-- Falls schon Nutzer ohne Rolle angelegt wurden (z.B. beim ersten Ausprobieren):
update auth.users set role = 'authenticated' where role is null or role = '';
