#!/usr/bin/env bash
# Schema "auth" vorab anlegen (GoTrue legt beim Start seine eigenen Tabellen
# UND die Hilfsfunktionen auth.uid()/auth.role() darin an – das ist Teil von
# GoTrues eigener Migration "00_init_auth_schema", nicht des vollen
# supabase/postgres-Images). Wir legen hier nur das Schema und eine eigene
# Rolle für GoTrue an; die Funktionen selbst NICHT vordefinieren, sonst
# schlägt GoTrues Migration mit "must be owner of function uid" fehl.
set -euo pipefail

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  create schema if not exists auth;

  -- GoTrue verbindet sich als eigene Rolle mit search_path=auth, damit seine
  -- (unqualifizierten) Migrationen Typen/Tabellen/Funktionen in auth statt
  -- public anlegen.
  create role supabase_auth_admin noinherit login password '${AUTH_ADMIN_PASSWORD}';
  alter role supabase_auth_admin set search_path = auth, public;
  alter schema auth owner to supabase_auth_admin;

  grant usage on schema auth to anon, authenticated, service_role;
EOSQL
