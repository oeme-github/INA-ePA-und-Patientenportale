# Lokaler Stack: Postgres + PostgREST + GoTrue

Entbündelter Ersatz für Supabase (siehe KONTEXT.md, „Architekturentscheidung
Multi-User-Web-Tool"): nur die drei tatsächlich benötigten Bausteine, selbst
gehostet per Docker Compose. Kein Supabase Studio, kein Kong, keine Realtime/
Storage-Dienste.

## Einmalig einrichten

```bash
cd supabase
cp .env.example .env
# Werte in .env füllen, z.B.:
openssl rand -hex 32       # → JWT_SECRET
openssl rand -base64 24    # → POSTGRES_PASSWORD / AUTHENTICATOR_PASSWORD / AUTH_ADMIN_PASSWORD
```

## Starten (Reihenfolge beachten)

GoTrue muss seine eigenen `auth.*`-Tabellen/Funktionen anlegen, **bevor**
unsere Migration läuft (die per Fremdschlüssel auf `auth.users` verweist):

```bash
docker compose up -d db mailpit   # Postgres + Mailfänger für Magic-Link/Bestätigungsmails
docker compose up -d auth          # GoTrue: legt auth.users, auth.uid() etc. an
docker compose up -d rest          # PostgREST
```

Danach die Schema-Migration einspielen:

```bash
docker compose exec -T db psql -U postgres -d postgres -v ON_ERROR_STOP=1 \
  < migrations/20260710120000_init_schema.sql

# PostgREST danach den Schema-Cache neu laden lassen:
docker compose exec -T db psql -U postgres -d postgres -c "NOTIFY pgrst, 'reload schema';"
```

## Ports

| Dienst | Port | Zweck |
|---|---|---|
| db (Postgres) | 5432 | direkter DB-Zugriff (psql, Migrationen) |
| auth (GoTrue) | 9999 | `/signup`, `/token`, `/verify`, `/admin/*` |
| rest (PostgREST) | 3001 → intern 3000 | REST-API auf `public`-Schema |
| mailpit (Web-UI) | 8026 | versendete Mails ansehen (Bestätigung, Magic-Link) |

## Wichtige technische Erkenntnisse (Session 2026-07-11)

- **`auth.uid()`/`auth.role()`/`auth.email()`/`auth.jwt()` kommen von GoTrue selbst**
  (Migration `00_init_auth_schema`), nicht vom supabase/postgres-Image. Nicht
  selbst vordefinieren – GoTrue verbindet sich als eigene Rolle
  (`supabase_auth_admin`, angelegt in `init-db/01-auth-schema.sh`) und legt sie
  beim ersten Start selbst an. Eigene Vordefinition führt zu
  `must be owner of function uid`.
- **`supabase_auth_admin` braucht `search_path = auth, public`**, sonst legt
  GoTrue seine (unqualifizierten) Typen/Tabellen in `public` statt `auth` an –
  spätere GoTrue-Migrationen, die explizit `auth.factor_type` referenzieren,
  brechen dann mit „type does not exist".
- **`PGRST_DB_USE_LEGACY_GUCS` muss `false` sein** (PostgREST-Default seit v10+):
  GoTrues `auth.uid()` liest `request.jwt.claim.sub`, nicht die alte
  JSON-GUC `request.jwt.claims`.
- Rollen `anon`/`authenticated`/`service_role`/`authenticator` sind nicht Teil
  von Postgres/PostgREST/GoTrue – die legt `init-db/00-roles.sh` einmalig beim
  ersten Start des DB-Volumes an (inkl. Default-Privileges für künftige
  Tabellen aus der Migration).
- `workgroups` hat in der Migration bewusst nur eine `select`-Policy, keine
  Schreib-Policy – neue Arbeitsgruppen anlegen ist aktuell nur per
  `service_role`/direktem DB-Zugriff möglich, nicht über PostgREST mit einer
  Nutzerrolle. Relevant für T09 (Verwaltungsoberfläche).
- `docker-entrypoint-initdb.d`-Skripte laufen nur beim allerersten Start
  eines leeren `db-data`-Volumes. Nach Änderungen an `init-db/*.sh` während
  der Entwicklung: `docker compose down -v` (Volume löschen) und neu
  hochfahren.

## Smoke-Test (durchgeführt, nicht dauerhaft im Stack)

Signup → Mailpit-Bestätigungsmail → `/verify` → JWT mit `role: authenticated`
→ PostgREST: anonym leer, `authenticated` ohne Membership leer, `viewer`
liest, `editor` schreibt (`POST /process_steps` → 201). Testdaten wieder
gelöscht.
