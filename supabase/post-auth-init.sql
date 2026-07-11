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
alter table auth.users alter column role set default 'authenticated';

-- Falls schon Nutzer ohne Rolle angelegt wurden (z.B. beim ersten Ausprobieren):
update auth.users set role = 'authenticated' where role is null or role = '';
