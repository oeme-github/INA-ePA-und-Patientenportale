#!/usr/bin/env bash
# Rollen für PostgREST, wie sie im vollen supabase/postgres-Image bereits
# vorkonfiguriert wären. Da wir bewusst nur Postgres + PostgREST + GoTrue
# selbst hosten (siehe KONTEXT.md, "Architekturentscheidung Multi-User-Web-Tool"),
# legen wir sie hier explizit an. Läuft einmalig beim ersten Start des
# Datenbank-Volumes (docker-entrypoint-initdb.d).
set -euo pipefail

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  create role anon nologin noinherit;
  create role authenticated nologin noinherit;
  create role service_role nologin noinherit bypassrls;

  -- authenticator: die Rolle, mit der sich PostgREST verbindet und die per
  -- SET ROLE auf anon/authenticated/service_role wechselt, je nach JWT.
  create role authenticator noinherit login password '${AUTHENTICATOR_PASSWORD}';
  grant anon to authenticator;
  grant authenticated to authenticator;
  grant service_role to authenticator;

  grant usage on schema public to anon, authenticated, service_role;
  alter default privileges in schema public grant select, insert, update, delete on tables to authenticated;
  alter default privileges in schema public grant select on tables to anon;
  alter default privileges in schema public grant usage, select on sequences to authenticated;
  alter default privileges in schema public grant all on tables to service_role;
  alter default privileges in schema public grant all on sequences to service_role;
  grant all on all tables in schema public to service_role;
  grant all on all sequences in schema public to service_role;
EOSQL
