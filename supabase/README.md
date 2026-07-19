# Lokaler Stack: Postgres + PostgREST + GoTrue

Entbündelter Ersatz für Supabase (siehe KONTEXT.md, „Architekturentscheidung
Multi-User-Web-Tool"): nur die drei tatsächlich benötigten Bausteine, selbst
gehostet per Docker Compose. Kein Supabase Studio, kein Kong, keine Realtime/
Storage-Dienste.

## TL;DR: alles mit einem Aufruf starten

```bash
./supabase/start.sh
```

Idempotent — legt beim allerersten Aufruf `.env` (neue Secrets), Schema und
Seed-Daten sowie die drei Test-Zugänge (`demo@`/`editor@`/`admin@…`) an und
startet den statischen Webserver für Viewer/Editor; bei jedem weiteren
Aufruf werden nur fehlende Teile ergänzt, nichts wird überschrieben. Details
zu den einzelnen Schritten (falls manuell/einzeln gebraucht) siehe unten.

Stoppen mit `./supabase/stop.sh` (Daten bleiben erhalten — Container werden
entfernt, aber nicht das DB-Volume). Für einen kompletten Reset:
`./supabase/stop.sh --wipe-data` (löscht auch die Daten; der nächste
`start.sh`-Aufruf spielt Schema + Seed dann wieder frisch ein).

## Einmalig einrichten (manuell, falls nicht über start.sh)

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

## Viewer-Prototyp gegen die Datenbank (T04)

`../viewer-db/index.html` ist ein separater, eigenständiger Viewer-Prototyp
(gleiche Optik/Filter/Kartenlogik wie `patientenpfad_interaktiv.html`), der
Daten aber live per PostgREST aus der Datenbank lädt statt aus
`patientenpfad_data.js`. Die produktiven Dateien (`patientenpfad_interaktiv.html`,
`patientenpfad_editor.html`, `patientenpfad_data.js`) bleiben dabei unangetastet.

Start (beliebiger statischer Webserver genügt, kein Build-Schritt). **Wichtig:**
vom Projekt-Wurzelverzeichnis aus starten, nicht aus `viewer-db/` selbst —
`viewer-db` und `editor-db` binden beide `../shared/auth.js` ein (T08), das
liegt außerhalb ihres jeweiligen Ordners:

```bash
# im Projekt-Wurzelverzeichnis (INA-ePA-und-Patientenportale/):
python3 -m http.server 8095
# im Browser: http://localhost:8095/viewer-db/
```

Der Prototyp braucht eine echte Anmeldung (GoTrue) UND eine Mitgliedschaft
(`memberships`-Zeile) in einer Workgroup, sonst blendet RLS alle Daten aus.
Demo-Zugang anlegen (einmalig, nach `docker compose up -d auth`):

```bash
# 1) Nutzer registrieren (löst Bestätigungsmail an Mailpit aus)
curl -X POST http://localhost:9999/signup -H "Content-Type: application/json" \
  -d '{"email":"demo@prozesslandkarte.local","password":"demo-passwort-123"}'

# 2) Bestätigungscode aus Mailpit holen (http://localhost:8026) und verifizieren
curl -X POST http://localhost:9999/verify -H "Content-Type: application/json" \
  -d '{"type":"signup","email":"demo@prozesslandkarte.local","token":"<code aus Mailpit>"}'

# 3) Mitgliedschaft als viewer in ak-patientenportale anlegen
docker compose exec -T db psql -U postgres -d postgres -c "
  insert into memberships (user_id, workgroup_id, rolle)
  select id, (select id from workgroups where key='ak-patientenportale'), 'viewer'
  from auth.users where email='demo@prozesslandkarte.local';
"
```

Login im Prototyp mit `demo@prozesslandkarte.local` / `demo-passwort-123`.
`GOTRUE_URL`/`REST_URL` sind oben in `viewer-db/index.html` als Konstanten
hinterlegt (Default: die Ports aus diesem Stack) – bei abweichenden Ports
dort anpassen.

Getestet (Headless-Chrome-Screenshots, Session 2026-07-11): Login, alle 25
Prozessschritte über alle drei Phasen, Karten-Detail-Aufklappen, Freitextsuche
mit Highlighting, Datenraum-Filter (Dimmen), Matrix-Ansicht, Logout,
Fehlermeldung bei falschem Passwort.

**T05 (erledigt):** Tabs/Filter/Kartenfelder/Matrix-Achsen werden inzwischen
vollständig dynamisch aus `dimensions`/`dimension_values` abgeleitet, nicht
mehr hart codiert (Details siehe KONTEXT.md).

## Editor-Prototyp gegen die Datenbank (T06+T07)

`../editor-db/index.html` — separater Editor-Prototyp (bestehender
`patientenpfad_editor.html` bleibt unangetastet). Formularfelder werden pro
Dimension generisch erzeugt (`single_select`/`multi_select`/`text`), neue
Werte lassen sich inline ergänzen. Speichern schreibt direkt per PostgREST,
abgesichert durch RLS (nur Rolle `editor`/`admin` darf schreiben).

```bash
# im Projekt-Wurzelverzeichnis (INA-ePA-und-Patientenportale/), siehe Hinweis oben:
python3 -m http.server 8095
# im Browser: http://localhost:8095/editor-db/
```

Zum Testen der Schreibrechte zusätzlich zum `demo`-Viewer-Zugang (siehe oben)
einen Editor-Zugang anlegen (gleiches Verfahren: signup → Mailpit-Code →
verify → Mitgliedschaft), nur mit Rolle `editor` statt `viewer`:

```bash
curl -X POST http://localhost:9999/signup -H "Content-Type: application/json" \
  -d '{"email":"editor@prozesslandkarte.local","password":"editor-passwort-123"}'
# Code aus Mailpit holen und verifizieren (siehe oben), dann:
docker compose exec -T db psql -U postgres -d postgres -c "
  insert into memberships (user_id, workgroup_id, rolle)
  select id, (select id from workgroups where key='ak-patientenportale'), 'editor'
  from auth.users where email='editor@prozesslandkarte.local';
"
```

Getestet (Headless-Chrome): Formularfelder korrekt vorbefüllt, Titel ändern +
neuen Dimension-Wert ergänzen + Speichern (persistiert, Liste aktualisiert
sich), RLS-Grenzfall mit `viewer`-Rolle (Speichern schlägt kontrolliert fehl,
DB bleibt unverändert), neuen Schritt anlegen und löschen.

## Dimensionen-Verwaltung im Editor (T09)

Im Editor (`editor-db/index.html`) zwischen „Prozessschritte" und
„Dimensionen" umschalten (Sidebar-Tabs). Dort lassen sich neue Dimensionen
anlegen (Key/Label/Typ/Reihenfolge/Farbe/Navigationsachse) sowie bestehende
bearbeiten/löschen, und die Werte einer Dimension pflegen (bearbeiten/
löschen, nicht nur ergänzen wie im Prozessschritt-Formular). Dimensionen
anlegen/ändern/löschen erfordert laut Schema die Rolle `admin`, nicht nur
`editor` (`"Admins verwalten Dimensionen"`-Policy) — mit `editor` bleibt nur
die Werte-Pflege innerhalb bestehender Dimensionen möglich. Admin-Testzugang
analog zu `demo@…`/`editor@…` anlegen, nur mit Rolle `admin`:

```bash
curl -X POST http://localhost:9999/signup -H "Content-Type: application/json" \
  -d '{"email":"admin@prozesslandkarte.local","password":"admin-passwort-123"}'
# Code aus Mailpit holen und verifizieren (siehe oben), dann:
docker compose exec -T db psql -U postgres -d postgres -c "
  insert into memberships (user_id, workgroup_id, rolle)
  select id, (select id from workgroups where key='ak-patientenportale'), 'admin'
  from auth.users where email='admin@prozesslandkarte.local';
"
```

Getestet (Headless-Chrome): Dimension anlegen (Reihenfolge korrekt
vorgeschlagen), Wert ergänzen (erscheint sofort im Prozessschritt-Formular),
RLS-Grenzfall mit `editor`-Rolle (Anlegen schlägt mit HTTP 403 fehl, DB
unverändert), Dimension wieder löschen.

## Mitglieder-Verwaltung im Editor (T12)

Ersetzt den bisherigen Weg (manuelles `docker compose exec ... psql ...
insert into memberships ...`, siehe oben bei den Test-Zugängen) durch eine
UI: im Editor zwischen „Prozessschritte"/„Dimensionen"/„Mitglieder"
umschalten. Erfordert wie die Dimensionen-Verwaltung die Rolle `admin`
(`"Admins verwalten Mitgliedschaften"`-Policy) — mit `editor`/`viewer` zeigt
der Tab nur einen Hinweistext, keine Liste.

**Kein echtes Invite-System:** eine Person muss sich zuerst selbst
registrieren (Login-Screen → Magic-Link oder Passwort), erst danach kann ein
admin sie im Editor per E-Mail-Adresse finden und ihr eine Rolle zuweisen.
Dahinter stecken zwei neue `security definer`-RPCs (Migration
`20260719100000_add_member_lookup_functions.sql`), weil `auth.users` selbst
über PostgREST nicht erreichbar ist (`PGRST_DB_SCHEMA=public`):

- `lookup_user_by_email(p_email, p_workgroup_id)` — löst eine E-Mail-Adresse
  zur `user_id` auf (`null`, falls kein Account existiert)
- `list_workgroup_members(p_workgroup_id)` — Mitgliederliste inkl. E-Mail

Beide prüfen den `admin`-Status selbst (RLS greift bei `security definer`
nicht), liefern sonst HTTP 403. Nach dem Einspielen einer neuen
Funktions-Migration nicht vergessen: `NOTIFY pgrst, 'reload schema';`
(PostgREST cacht Funktionssignaturen wie Tabellenschemata).

Client-seitiger Selbstschutz (kein DB-Constraint): Die letzte `admin`-Rolle
einer Workgroup lässt sich weder herabstufen noch entfernen, um
versehentliches Selbst-Aussperren zu verhindern.

Getestet per Playwright: Admin sieht/verwaltet die Mitgliederliste, Mitglied
per E-Mail hinzufügen (inkl. Negativfälle unbekannte E-Mail / bereits
Mitglied), Rolle ändern, Mitglied entfernen, RLS-Grenzfall mit `editor`-Rolle,
Selbstschutz bei letztem Admin (Herabstufen und Entfernen beide blockiert).

## Änderungsprotokoll (Cutover-Checkliste: Audit-/Versionsprotokoll)

`process_step_audit` (Schema seit T02, siehe `init_schema.sql`) wird seit
Migration `20260719110000_enable_process_step_audit.sql` aktiv befüllt —
vorher war sie nur eine leere Struktur. Trigger auf `process_steps` UND
`process_step_values` (die fachlichen Inhalte eines Schritts liegen im
generischen Datenmodell nicht in `process_steps` selbst), beide
`security definer`, da die Tabelle bewusst keine Schreib-Policy hat.

Abfragbar nur über die API (`GET /process_step_audit?process_step_id=eq.<id>`),
RLS erlaubt Lesen ab Rolle `viewer` in der jeweiligen Workgroup — bisher
keine eigene UI dafür.

**Rauschunterdrückung:** `seed_ak_patientenportale.py` löscht/schreibt bei
jedem Lauf alle `process_step_values` komplett neu, auch wenn sich nichts
geändert hat. Das Skript setzt deshalb `set local app.skip_audit='on'` für
seine eigene Transaktion — ein manueller `psql`-Zugriff, der das nicht
setzt, wird dagegen ganz normal protokolliert (z.B. mit `changed_by =
null`, da ohne PostgREST-JWT kein `auth.uid()` verfügbar ist).

**Wichtig bei künftigen Migrationen an `process_step_audit`:**
`process_step_id` hat bewusst **keinen** Fremdschlüssel auf `process_steps`
(anders als beim ursprünglichen T02-Entwurf) — ein Audit-Log darf nicht
verschwinden, wenn die protokollierte Zeile gelöscht wird. `workgroup_id`
ist denormalisiert direkt in der Tabelle mitgeführt (nicht per Join
ermittelt), sonst würden RLS-Leserechte und der Cascade-Trigger nach einer
Löschung ins Leere laufen.

## Datenabgleich gegen patientenpfad_data.js (T11-Vorbereitung)

`supabase/seed/reconcile_with_data_js.py` vergleicht den aktuellen DB-Stand
der Workgroup `ak-patientenportale` Feld für Feld gegen den *aktuellen*
Stand von `patientenpfad_data.js` (reiner Lesevergleich, keine Schreib­
operation):

```bash
cd supabase/seed
python3 reconcile_with_data_js.py
# Exit-Code 0 = identisch, 1 = Abweichungen (werden aufgelistet)
```

Sinnvoll vor einem Cutover (siehe Checkliste in BACKLOG.md) oder nachdem die
AG über den bestehenden Editor weitergepflegt hat — bei Abweichungen zuerst
`seed_ak_patientenportale.py` erneut laufen lassen, dann erneut prüfen.

## Gemeinsamer Login (T08)

`../shared/auth.js` wird von `viewer-db` und `editor-db` gemeinsam per
`<script src="../shared/auth.js">` eingebunden — daher der Hinweis oben,
beide Prototypen über einen Server im Projekt-Wurzelverzeichnis zu starten.
Login-Reihenfolge: Magic-Link zuerst (E-Mail → GoTrue `/otp` → 6-stelliger
Code aus der Mail/Mailpit → `/verify`), Passwort als eingeklappter Fallback
(z.B. für die obigen `demo@…`/`editor@…`-Testzugänge). `demo@…` und
`editor@…` funktionieren mit beiden Wegen — es ist derselbe GoTrue-Nutzer,
nur die Anmeldemethode unterscheidet sich.

## Institutionelles SSO — Microsoft Entra ID (T10)

GoTrue unterstützt Entra ID als externen OAuth-Provider bereits fertig
(`GOTRUE_EXTERNAL_AZURE_*` in `docker-compose.yml`, `SSO_AZURE_*` in
`.env.example`) — der Redirect-Flow (`/authorize?provider=azure` → Microsoft-
Login → zurück mit `#access_token` im URL-Hash) ist in `shared/auth.js`
(`signInWithAzure()`) verdrahtet und nutzt denselben Hash-Consuming-Pfad wie
der Magic-Link-Bonusweg.

**Was hier bewusst fehlt und nicht lokal nachgebaut werden kann:** eine
echte App-Registrierung im Entra-ID-Tenant der Organisation (Client-ID/
-Secret, erlaubte Redirect-URIs). Das erfordert Zugriff auf den Azure-AD-
Tenant der gematik/des Krankenhauses, den ich als lokaler Dev-Prototyp
nicht besitze und nicht selbst anlegen kann. Bis eine Organisation das
selbst einrichtet, bleibt SSO im Login-Bildschirm ausgeblendet
(`ssoAzureEnabled: false` in `viewer-db/index.html` und
`editor-db/index.html`).

**Um SSO später scharf zu schalten**, sobald eine App-Registrierung
existiert:
1. In Entra ID: App-Registrierung anlegen, Redirect-URI auf die GoTrue-URL
   setzen (z.B. `http://localhost:9999/callback` lokal), Client-Secret
   erzeugen.
2. `supabase/.env`: `SSO_AZURE_ENABLED=true` sowie Client-ID/-Secret/
   Tenant-URL/Redirect-URI eintragen, Stack neu starten (`docker compose up
   -d auth`).
3. In `viewer-db/index.html` und `editor-db/index.html`: `ssoAzureEnabled:
   true` in `initLoginScreen(...)` setzen.

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
  nach. **Ein reiner Spalten-Default reicht aber nicht**: GoTrue schreibt bei
  jedem Signup explizit `role=''` (nicht NULL, nicht weggelassen) – ein
  Default greift nur, wenn die Spalte in der INSERT-Anweisung fehlt. Deshalb
  zusätzlich ein Trigger auf `auth.users`, der leere Rollen korrigiert
  (gefunden beim T06-Test mit einem zweiten, neu angelegten Nutzer). **Ein
  `before insert`-Trigger allein reichte danach immer noch nicht** (T09-Test):
  GoTrue überschreibt den Nutzer offenbar noch mindestens einmal per `UPDATE`
  im selben Signup/Verify-Ablauf, mit einem in Go noch leeren Rollen-Feld —
  ein reiner Insert-Trigger sieht diese spätere Update nicht. Endgültiger
  Fix: Trigger auf `before insert or update` erweitert.

## Smoke-Test (durchgeführt, nicht dauerhaft im Stack)

Signup → Mailpit-Bestätigungsmail → `/verify` → JWT mit `role: authenticated`
→ PostgREST: anonym leer, `authenticated` ohne Membership leer, `viewer`
liest, `editor` schreibt (`POST /process_steps` → 201). Testdaten wieder
gelöscht.
