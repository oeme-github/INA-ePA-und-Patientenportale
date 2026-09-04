# Datenabgleich: patientenpfad_data.js ↔ open-starcore

Bindeglied zwischen diesem Repo (`patientenpfad_data.js`, weiterhin von der
AG über den bestehenden Editor gepflegt) und der Workgroup
`ak-patientenportale` in der ausgegliederten
[open-starcore](https://github.com/oeme-github/open-starcore)-Instanz.
Gehört inhaltlich nicht zur generischen Engine (kennt `patientenpfad_data.js`
und den festen Workgroup-Key), deshalb hier statt dort.

Bis einschließlich Session 2026-08-15 lag dieses Tooling unter
`supabase/seed/` in diesem Repo — seitdem lebt die Engine selbst in
`open-starcore`, dieser Ordner bleibt zurück.

## Voraussetzungen

- Node.js (für `extract_data_js.mjs`, liest `../../patientenpfad_data.js`
  per Node-`vm`-Modul live ein — kein npm-Paket, reines Node)
- Python 3 mit `venv`

## Einrichten

```bash
cd tools/prozesslandkarte-sync
python3 -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
cp .env.example .env
# DB_HOST/DB_PORT/POSTGRES_PASSWORD der Ziel-Instanz eintragen
```

Läuft ortsunabhängig gegen den exponierten Postgres-Port der Ziel-Instanz
(z.B. `inabox.lan:5435`) — nicht zwingend auf demselben Host wie die
Instanz selbst, solange Netzwerkzugriff auf den DB-Port besteht.

## Seed / erneuter Abgleich

```bash
python3 seed_ak_patientenportale.py
```

Idempotent (`ON CONFLICT DO UPDATE` bzw. `DELETE` + Neuaufbau der
`process_step_values` pro Schritt) — beliebig oft erneut lauffähig, z.B.
nachdem die AG über den bestehenden Editor weitergepflegt hat.
`meta.{domaenen,akteure,datenobjekte,standards,rechtsgrundlagen}` werden zu
Dimensionen; `phase` und `dr` (Datenraum) werden dabei zu zwei weiteren
Dimensionen statt Sonderfällen.

## Nur prüfen, ohne zu schreiben

```bash
python3 reconcile_with_data_js.py
# Exit-Code 0 = identisch, 1 = Abweichungen (werden aufgelistet)
```

Reiner Lesevergleich der DB-Workgroup `ak-patientenportale` gegen den
*aktuellen* Stand von `patientenpfad_data.js`. Sinnvoll vor einem Cutover
(siehe Checkliste in `../../BACKLOG.md`) oder nachdem die AG über den
bestehenden Editor weitergepflegt hat — bei Abweichungen zuerst
`seed_ak_patientenportale.py` erneut laufen lassen, dann erneut prüfen.
