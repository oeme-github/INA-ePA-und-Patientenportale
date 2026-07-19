#!/usr/bin/env bash
# Startet den kompletten lokalen Stack mit einem Aufruf:
# Postgres + PostgREST + GoTrue + Mailpit (Docker) sowie den statischen
# Webserver für viewer-db/editor-db. Idempotent — kann beliebig oft erneut
# aufgerufen werden, ohne bestehende Daten zu verändern:
# - Docker-Services: `docker compose up -d` startet nur, was nicht schon läuft
# - Schema-Migration + Seed-Daten laufen nur beim allerersten Start (leeres
#   DB-Volume), nicht bei jedem Aufruf — sonst würde jede spätere Pflege über
#   den Editor bei jedem Start wieder überschrieben
# - Test-Nutzer (demo/editor/admin) werden nur angelegt, falls sie noch
#   nicht existieren
#
# Verwendung: ./start.sh (aus beliebigem Verzeichnis aufrufbar)
set -euo pipefail

SUPABASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SUPABASE_DIR")"
STATIC_PORT="${STATIC_PORT:-8095}"

cd "$SUPABASE_DIR"

# ── .env sicherstellen ──────────────────────────────────────────────
if [ ! -f .env ]; then
  echo "==> supabase/.env fehlt, erzeuge neue lokale Secrets ..."
  cat > .env <<EOF
POSTGRES_PASSWORD=$(openssl rand -base64 24 | tr -d '/+=')
AUTHENTICATOR_PASSWORD=$(openssl rand -base64 24 | tr -d '/+=')
AUTH_ADMIN_PASSWORD=$(openssl rand -base64 24 | tr -d '/+=')
JWT_SECRET=$(openssl rand -hex 32)
SITE_URL=http://localhost:3000
EOF
fi

# shellcheck disable=SC1091
source .env
DB_PORT="${DB_PORT:-5435}"
REST_PORT="${REST_PORT:-8001}"

# ── Docker-Stack ─────────────────────────────────────────────────────
echo "==> Postgres + Mailpit starten ..."
docker compose up -d db mailpit

echo "==> Warte auf Postgres ..."
until docker compose exec -T db pg_isready -U postgres >/dev/null 2>&1; do sleep 1; done

echo "==> GoTrue (Auth) starten ..."
docker compose up -d auth

echo "==> Warte auf GoTrue ..."
until curl -s -o /dev/null "http://localhost:9999/settings"; do sleep 1; done

echo "==> post-auth-init.sql einspielen (Rollen-Default/-Trigger, idempotent) ..."
docker compose exec -T db psql -U postgres -d postgres -v ON_ERROR_STOP=1 < post-auth-init.sql > /dev/null

echo "==> PostgREST starten ..."
docker compose up -d rest

# ── Schema-Migration + Seed nur beim allerersten Start ──────────────
FRESH="$(docker compose exec -T db psql -U postgres -d postgres -tAc "select to_regclass('public.workgroups')" | tr -d '[:space:]')"
if [ -z "$FRESH" ]; then
  echo "==> Erststart erkannt: Schema-Migration einspielen ..."
  docker compose exec -T db psql -U postgres -d postgres -v ON_ERROR_STOP=1 < migrations/20260710120000_init_schema.sql
  docker compose exec -T db psql -U postgres -d postgres -c "NOTIFY pgrst, 'reload schema';" > /dev/null

  echo "==> Seed-Daten aus patientenpfad_data.js einspielen ..."
  (cd seed && python3 seed_ak_patientenportale.py)
else
  echo "==> Schema existiert bereits (kein Erststart) — Migration/Seed übersprungen."
fi

# ── Test-Nutzer anlegen, falls noch nicht vorhanden ─────────────────
ensure_test_user() {
  local email="$1" password="$2" rolle="$3"
  local exists
  exists="$(docker compose exec -T db psql -U postgres -d postgres -tAc \
    "select 1 from auth.users where email='${email}'" | tr -d '[:space:]')"
  if [ -n "$exists" ]; then
    return
  fi

  echo "  Lege Test-Nutzer ${email} (Rolle ${rolle}) an ..."
  curl -s -X POST http://localhost:9999/signup -H "Content-Type: application/json" \
    -d "{\"email\":\"${email}\",\"password\":\"${password}\"}" > /dev/null
  sleep 1

  local msg_id
  msg_id="$(curl -s http://localhost:8026/api/v1/messages | python3 -c "
import json, sys
email = sys.argv[1]
msgs = [m for m in json.load(sys.stdin)['messages'] if m['To'][0]['Address'] == email]
print(msgs[0]['ID'] if msgs else '')
" "$email")"
  if [ -z "$msg_id" ]; then
    echo "    WARNUNG: keine Bestätigungsmail für ${email} in Mailpit gefunden — Nutzer bleibt unbestätigt."
    return
  fi

  local token
  token="$(curl -s "http://localhost:8026/api/v1/message/${msg_id}" | python3 -c "
import json, re, sys
print(re.search(r'code: (\d+)', json.load(sys.stdin)['Text']).group(1))
")"
  curl -s -X POST http://localhost:9999/verify -H "Content-Type: application/json" \
    -d "{\"type\":\"signup\",\"email\":\"${email}\",\"token\":\"${token}\"}" > /dev/null

  docker compose exec -T db psql -U postgres -d postgres -c "
    insert into memberships (user_id, workgroup_id, rolle)
    select id, (select id from workgroups where key='ak-patientenportale'), '${rolle}'
    from auth.users where email='${email}'
    on conflict (user_id, workgroup_id) do update set rolle = excluded.rolle;
  " > /dev/null
}

echo "==> Test-Nutzer prüfen/anlegen ..."
ensure_test_user "demo@prozesslandkarte.local" "demo-passwort-123" "viewer"
ensure_test_user "editor@prozesslandkarte.local" "editor-passwort-123" "editor"
ensure_test_user "admin@prozesslandkarte.local" "admin-passwort-123" "admin"

# ── Statischer Webserver für viewer-db/editor-db ────────────────────
if ! curl -s -o /dev/null "http://localhost:${STATIC_PORT}/"; then
  echo "==> Statischen Webserver für viewer-db/editor-db starten (Port ${STATIC_PORT}) ..."
  (cd "$REPO_ROOT" && nohup python3 -m http.server "$STATIC_PORT" > /tmp/prozesslandkarte-http.log 2>&1 &)
  sleep 1
else
  echo "==> Statischer Webserver läuft bereits auf Port ${STATIC_PORT}."
fi

cat <<EOF

Fertig! Alles läuft:

  Viewer:   http://localhost:${STATIC_PORT}/viewer-db/
  Editor:   http://localhost:${STATIC_PORT}/editor-db/
  Mailpit:  http://localhost:8026  (Bestätigungscodes für Magic-Link)

Test-Zugänge (Login-Bildschirm → "Alternative: mit Passwort anmelden"):
  demo@prozesslandkarte.local   / demo-passwort-123   (Rolle: viewer)
  editor@prozesslandkarte.local / editor-passwort-123 (Rolle: editor)
  admin@prozesslandkarte.local  / admin-passwort-123  (Rolle: admin)

Stack stoppen: ./stop.sh (Daten bleiben erhalten)
Kompletter Reset: ./stop.sh --wipe-data (löscht das DB-Volume, nächster
start.sh macht einen Erststart)
EOF
