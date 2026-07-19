#!/usr/bin/env bash
# Gegenstück zu start.sh: stoppt den kompletten lokalen Stack wieder.
#
# Nicht-destruktiv per Default: `docker compose down` entfernt nur die
# Container, nicht das Datenbank-Volume — beim nächsten start.sh sind alle
# Daten (Seed, eigene Änderungen, Test-Nutzer) wieder da. Für einen
# vollständigen Reset (z.B. um T02 clean neu durchzuspielen) explizit
# --wipe-data übergeben.
#
# Verwendung:
#   ./stop.sh              # Container stoppen/entfernen, Daten bleiben erhalten
#   ./stop.sh --wipe-data   # zusätzlich das DB-Volume löschen (alle Daten weg!)
set -euo pipefail

SUPABASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STATIC_PORT="${STATIC_PORT:-8095}"

cd "$SUPABASE_DIR"

echo "==> Statischen Webserver (Port ${STATIC_PORT}) stoppen ..."
if pkill -f "http.server ${STATIC_PORT}" 2>/dev/null; then
  echo "    gestoppt."
else
  echo "    war nicht aktiv."
fi

if [ "${1:-}" = "--wipe-data" ]; then
  echo "==> Docker-Stack stoppen UND Datenbank-Volume löschen ..."
  docker compose down -v
  echo "    Alle Daten (Seed, eigene Änderungen, Test-Nutzer) sind weg — nächster start.sh macht einen Erststart."
else
  echo "==> Docker-Stack stoppen (Daten bleiben erhalten) ..."
  docker compose down
fi

echo ""
echo "Fertig. Erneut starten mit: ./start.sh"
