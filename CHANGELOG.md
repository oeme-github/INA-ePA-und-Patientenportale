# Changelog – INA-ePA-und-Patientenportale

Format nach [Keep a Changelog](https://keepachangelog.com/de/1.1.0/). Einzige dauerhafte Historie
erledigter Backlog-Punkte (siehe `dev-notes/STANDARDS.md` §3) — `BACKLOG.md` enthält nur noch
offene Punkte. Ausführliche Begründungen/Architekturentscheidungen stehen zusätzlich in
`KONTEXT.md`.

Backlog-IDs vor dem Doku-Check 2026-09-28 wurden ohne Repo-Präfix vergeben (T01, V01, E01 …) und
hier unverändert übernommen; neue IDs folgen der Konvention `INA-ePA-und-Patientenportale_<ID>`.

---

## [2026-09-28] — Doku-Check

### Changed
- `BACKLOG.md` auf offene Punkte verschlankt, erledigte Blöcke (Positionspapier, T01–T14,
  Cutover-Checkliste, Viewer-/Editor-Abgleich) hierher verschoben; verbleibende IDs auf
  `INA-ePA-und-Patientenportale_<ID>` umbenannt.
- T11 (Cutover) als abgeschlossen ohne tatsächlichen Cutover vermerkt (siehe 2026-09-04).

### Removed
- T10 (institutionelles SSO, Entra ID) aus diesem Repo entfernt — der Scaffolding-Code liegt seit
  dem Split (PR #57) ausschließlich in `open-starcore` (`shared/auth.js`, `docker-compose.yml`).
- D03 (`ANLEITUNG_EDITOR.md` weitergeben) — obsolet, aktive AG-Datenpflege ist abgeschlossen
  (Positionspapier veröffentlicht) und der PAT-Editor-Flow wird perspektivisch durch den
  Login-Flow des Multi-User-Tools ersetzt.
- „Migration zu Webserver + JSON" — durch das Multi-User-Web-Tool (heute `open-starcore`)
  überholt.

---

## [2026-09-04] — Cutover-Checkliste abgeschlossen, open-starcore-Split gemergt

### Changed
- **Cutover-Checkliste vollständig abgehakt, ohne tatsächlichen Cutover** (T11 damit
  abgeschlossen). Kernargument: Das Positionspapier ist auf der offiziellen
  [gematik-Seite](https://www.ina.gematik.de/mitwirken/arbeitskreise/rolle-von-patientenportalen-im-zusammenspiel-mit-primaersystemen-und-epa-1)
  veröffentlicht, die aktive AG-Arbeitsphase ist beendet.
  - Datenabgleich grün (Stand 2026-07-19, PR #38/#39): `reconcile_with_data_js.py` Exit-Code 0 —
    Snapshot, vor einem etwaigen echten Cutover erneut prüfen. Tool liegt heute unter
    `tools/prozesslandkarte-sync/`.
  - Rollenkonzept final (PR #41/#42/#43): mehrere Editoren, Admin auf 1–2 Personen, Pflege per
    Mitglieder-UI (T12).
  - Hosting/Betrieb (PR #56): Nutzer hostet selbst auf `inabox.lan`.
  - SSO-Entscheidung (PR #45): Magic-Link + Passwort-Fallback reicht, SSO optional.
  - Audit-Protokoll (PR #46): harte Anforderung, per Trigger aktiv befüllt.
  - AG-Freigabe / Kommunikation: durch die Veröffentlichung des Positionspapiers erledigt.
  - Parallelbetriebs-Zeitraum: kein fester Zeitraum nötig, keine aktive Datenpflege mehr.
  - Rückfallplan: Prinzip Export (CSV/JSON) + Re-Import, Quellcode in `open-starcore`; bewusst
    erst bei Bedarf als Skript/Runbook ausgebaut.
- PR #57 gemergt (`c0568a7`): `supabase/`, `viewer-db/`, `editor-db/`, `shared/` aus diesem Repo
  entfernt, leben mit voller Historie in
  [open-starcore](https://github.com/oeme-github/open-starcore).

---

## [2026-08-15] — Heimnetz-Deployment + Ausgliederung nach open-starcore

### Added
- Heimnetz-Deployment auf VM `inabox.lan` (PR #56): Docker-Compose-Stack + statischer Webserver
  als systemd-Unit, Reboot-Persistenz per echtem `sudo reboot` verifiziert.
- `tools/prozesslandkarte-sync/` (vormals `supabase/seed/`, PR #57): INA-spezifisches
  Datenabgleich-Tooling mit eigener `.env` (`DB_HOST`/`DB_PORT`/`POSTGRES_PASSWORD`).

### Fixed
- `start.sh` spielte bei Erststart nur die erste von sieben Migrationen ein.
- `ensure_test_user()` scheiterte seit T14 am Einladungs-Gate (fehlende `pending_invites`-Zeile).
- `GOTRUE_URL`/`REST_URL`/Mailpit-Link waren fest auf `localhost` verdrahtet, jetzt aus
  `location.hostname` abgeleitet.

### Changed
- Tool-Code nach `open-starcore` ausgegliedert (PR #57): Branding generisch (`APP_TITLE`),
  UI-Text „Prozessschritte" → „Einträge", Ports parametrisiert.

---

## [2026-07-21] — T13: Verlauf-Ansicht

### Added
- **T13** — „Verlauf"-Abschnitt pro Prozessschritt im Editor (PR #55), neue RPC
  `list_audit_actors` (viewer-gated) löst Akteurs-E-Mails auf.

### Fixed
- `onSaveStep()` schrieb bei jedem Speichern alle Dimensionen blind neu (delete+insert) und
  erzeugte massives Rauschen im Auditlog — jetzt Diff gegen die geladene Baseline, nur geänderte
  Felder/Dimensionen werden geschrieben.

---

## [2026-07-19] — Viewer-/Editor-Abgleich, Rollen, Audit, Einladungen

### Added
- **T12** — Mitglieder-Verwaltungs-UI im Editor: RPCs `lookup_user_by_email`/
  `list_workgroup_members` (PR #41), dritte Sidebar-Ansicht „Mitglieder" (PR #42, per PR #49
  nachträglich korrekt nach `main` gebracht — gestapelter PR war nur im Zwischenbranch gelandet).
- **T14** — Einladungs-gesteuerte Selbstregistrierung: `pending_invites` + Gate-/Provisioning-
  Trigger (PR #50), `create_user:true` in `shared/auth.js` (PR #51), Einladen in der
  Mitglieder-UI (PR #52), CSS-Nachbesserung (PR #53).
- Audit-/Versionsprotokoll aktiv (PR #46): Trigger auf `process_steps`/`process_step_values`,
  Rauschunterdrückung fürs Seed-Skript (`app.skip_audit`).
- **E08** — Drag&Drop für Reihenfolge (Prozessschritte, Dimension-Werte, Dimensionen-Liste),
  atomar per deferrable Unique-Constraint + Bulk-Upsert (PR #37).
- **V01** Struktur-Filter (Datenfix im Seed-Skript), **V02/V03** Rechtsgrundlage-/Standard-Filter
  über neue generische Ebene `dimension_values.gruppe`, **V04** Export-Toolbar (CSV/JSON generisch
  aus `dims`, PDF per `window.print()`), **V06** Matrix-Zellen als klickbare Schritt-Chips,
  **V09** Matrix Cross-Highlighting beim Hover (PR #34).
- **E03** Sticky-Speichern-Fußzeile, **E05** Akkordeon-Layout statt Sidebar+Panel, **E07**
  Filterfeld in langen Checkbox-Listen.

### Changed
- **V07** Suchumfang: Titel/Akteur/Objekt/Detail plus Rechtsgrundlage/Standard (PR #29),
  Ist/Lücke/Forderungen bleiben ausgeschlossen.
- Toolbar-Zeilenabstand im Viewer vergrößert (PR #32).

### Fixed
- **E09** „+ Neu" bei Dimensionen für Nicht-Admins deaktiviert (PR #30).
- **E10** Werte-Eingabe bei neuer Dimension erst nach dem Speichern sichtbar, Erfolgsmeldung
  sichtbar, `httpErrorHint()` unterscheidet 403/409 (PR #31).
- Fehlende Ausführungsrechte für `start.sh`/`stop.sh` im Git-Index (PR #38).
- Seed-Skript seit E08 kaputt (`ON CONFLICT` gegen deferrable Constraint), PR #39.
- `magiclink`- vs. `signup`-Token-Typ bei der Verifizierung (PR #51).

---

## [2026-07-11] — Multi-User-Web-Tool: Prototyp T01–T11

### Added
- **T01** SQL-Schema für generisches Datenmodell (`workgroups`/`dimensions`/`dimension_values`/
  `process_steps`/`memberships`).
- **T02** Lokaler Stack Postgres + PostgREST + GoTrue (+ Mailpit), Smoke-Test inkl. RLS.
- **T03** Seed-Migration von `patientenpfad_data.js` (idempotent, liest live ein).
- **T04/T05** Viewer-Prototyp `viewer-db` gegen die DB, Tabs/Filter/Matrix dynamisch aus
  `dimensions`.
- **T06/T07** Editor-Prototyp `editor-db`, Formularfelder dynamisch.
- **T08** Gemeinsamer Login-Bildschirm (`shared/auth.js`), Magic-Link zuerst.
- **T09** Dimensionen-Verwaltung im Editor (Rolle `admin`).
- **T10** SSO-Scaffolding für Microsoft Entra ID (deaktiviert, braucht App-Registrierung im
  Tenant) — Weiterführung siehe `open-starcore`.
- **T11** Datenabgleich-Skript `reconcile_with_data_js.py` + Cutover-Checkliste.
- **V05** Breadcrumb-Kopfzeile (dynamisch), **V08** Operation-Badge auf geschlossener Karte.
- **E02** Scrollbare Boxen für lange Checkbox-Listen (>10 Werte), **E04** breitere Sidebar,
  **E06** kein „+ Hinzufügen" bei Navigations-Dimensionen.

### Fixed
- **E01** CSS-Selektor `.field label` → `.field > label` (Checkbox-Texte nicht mehr in
  Großbuchstaben).
- GoTrue-Rollenbug (`role:''`) per `before insert or update`-Trigger in `post-auth-init.sql`.

---

## [2026-07-10] — Positionspapier abgeschlossen

### Changed
- **P01** PR #26 gemergt (2026-06-19).
- Positionspapier von der AG außerhalb dieses Repos fertiggestellt und eingereicht.

### Removed
- **P02** (Kap. 1/2/4.1/4.2 einarbeiten), **P03** (Plenumsentscheidung Patientenberatung),
  **P04** (Folgeschritt zu P03), **P05** (weitere Feedback-Runden) — obsolet, Dokument-Track
  geschlossen.

---

## Frühere Stände

Die Historie vor 2026-07-10 (Widget-Requirements R1–R4, PRs #2–#26, Ist-Analyse,
Positionspapier-Feedbackrunden) ist in `KONTEXT.md` („Geplante Aufgaben", „Requirements") und in
der Git-Historie dokumentiert.
