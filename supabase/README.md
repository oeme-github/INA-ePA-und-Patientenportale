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

Direkt danach einmalig `post-auth-init.sql` einspielen (setzt den Default
`role = 'authenticated'` für neue Nutzer – fehlt hier, weil wir nicht das
volle supabase/postgres-Image nutzen, siehe Datei-Kommentar):

```bash
docker compose exec -T db psql -U postgres -d postgres -v ON_ERROR_STOP=1 \
  < post-auth-init.sql
```

Danach die Schema-Migration einspielen:

```bash
docker compose exec -T db psql -U postgres -d postgres -v ON_ERROR_STOP=1 \
  < migrations/20260710120000_init_schema.sql

# PostgREST danach den Schema-Cache neu laden lassen:
docker compose exec -T db psql -U postgres -d postgres -c "NOTIFY pgrst, 'reload schema';"
```

## Seed-Daten (T03)

`seed/` migriert die heutige `patientenpfad_data.js` (Viewer/Editor-Datenquelle,
bleibt unangetastet im Wirkbetrieb) als erste Workgroup `ak-patientenportale`
in das generische Datenmodell:

```bash
cd supabase/seed
python3 -m venv .venv && source .venv/bin/activate   # optional
pip install -r requirements.txt
python3 seed_ak_patientenportale.py
```

- `extract_data_js.mjs` liest `../../patientenpfad_data.js` per Node `vm`-Modul
  live ein (kein Regex-Parsing, keine eigene Kopie der Inhalte) – Re-Seeding
  nach weiterer AG-Pflege über den bestehenden Editor liefert also immer den
  aktuellen Stand.
- `seed_ak_patientenportale.py` ist idempotent (`ON CONFLICT DO UPDATE` bzw.
  `DELETE` + Neuaufbau der `process_step_values` pro Schritt) und kann beliebig
  oft erneut laufen.
- `meta.{domaenen,akteure,datenobjekte,standards,rechtsgrundlagen}` werden zu
  Dimensionen; `phase` und `dr` (Datenraum) werden dabei zu zwei weiteren
  Dimensionen statt Sonderfällen (siehe KONTEXT.md).
- Werte, die in einem Prozessschritt vorkommen, aber in der `meta`-Liste
  fehlen (z.B. Tippfehler in `patientenpfad_data.js`), werden automatisch als
  zusätzlicher Wert ergänzt statt stillschweigend verworfen — mit Hinweis auf
  stderr. Bekannter Fall: Schritt 3 referenziert `HL7 FHIR R4 (Patient)`,
  fehlt in `meta.standards`.

## Ports

| Dienst | Port | Zweck |
|---|---|---|
| db (Postgres) | 5435 (`DB_PORT`) | direkter DB-Zugriff (psql, Migrationen) |
| auth (GoTrue) | 9999 | `/signup`, `/token`, `/verify`, `/admin/*` |
| rest (PostgREST) | 8001 (`REST_PORT`) → intern 3000 | REST-API auf `public`-Schema |
| mailpit (Web-UI) | 8026 | versendete Mails ansehen (Bestätigung, Magic-Link) |

Ports zentral registriert in `dev-notes/PORTS.md`. `db` lief anfangs hartkodiert auf 5432,
`rest` auf 3001 — beides kollidierte mit `buero-desk-booking` (Postgres bzw. NestJS-Backend-Dev)
und wurde am 2026-07-11 auf `DB_PORT`/`REST_PORT` (Default 5435/8001) umgestellt.

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
- **`GOTRUE_JWT_DEFAULT_GROUP_NAME` ist in dieser GoTrue-Version ein reines
  No-op** (Deprecation-Hinweis im Log, aber ohne Wirkung). Im vollen
  supabase/postgres-Image bekommen neue Nutzer ihre Rolle stattdessen über
  einen Spalten-Default `auth.users.role = 'authenticated'`. Ohne diesen
  Default (unser Fall) liefert GoTrue JWTs mit `role:""`, und PostgREST kann
  nicht per `SET ROLE` wechseln → `post-auth-init.sql` setzt den Default
  nach.

## Smoke-Test (durchgeführt, nicht dauerhaft im Stack)

Signup → Mailpit-Bestätigungsmail → `/verify` → JWT mit `role: authenticated`
→ PostgREST: anonym leer, `authenticated` ohne Membership leer, `viewer`
liest, `editor` schreibt (`POST /process_steps` → 201). Testdaten wieder
gelöscht.
