# CLAUDE.md – INA-ePA-und-Patientenportale

## Verbindlicher Arbeitsablauf

Der vollständige Arbeitsablauf (Startup-Routine, Arbeit im Projekt — Commits, Branch-Strategie,
Absturzsicherung, Sicherheitsbeobachtungen —, Session-End-Routine) steht **ausschließlich** in
`dev-notes/STANDARDS.md` §1–§4 — automatisch per `@`-Import geladen (siehe „Automatisch geladene
Dateien" unten), hier nicht redundant wiederholen. Die Abschnitte unten enthalten nur
**projektspezifische Ergänzungen und Fakten**, die es nur für dieses eine Projekt gibt.

**Abweichung vom Hub-Standard (bewusst, historisch gewachsen — dieses Repo ist älter als die
projektübergreifende Sprachregel):** `dev-notes/STANDARDS.md` verlangt global englische
Commit-Messages/Code-Kommentare — dieses Repo committet bewusst auf Deutsch, siehe „Sprache"
unten. **[open-starcore](https://github.com/oeme-github/open-starcore)** (aus diesem Repo
ausgegliedert, 2026-08-15) hat dieselbe Ausnahme geerbt. Nicht ohne Rücksprache angleichen.

## Sprache
Alle Ausgaben, Commit-Messages, Kommentare und Dokumente auf Deutsch.

---

## Entwicklungsumgebung

Gemeinsame Devbox-Umgebung (OS/Hardware/Migrationsgeschichte): siehe `dev-notes/REPOS.md`
(„Speicherorte") — autoritative Quelle, hier bewusst nicht dupliziert (siehe
`dev-notes/STANDARDS.md` §3, „Single Source of Truth für Infra-Fakten").

- **Projektpfad (Devbox):** `~/git_repos/INA-ePA-und-Patientenportale`
- **Versionskontrolle:** Git, Remote auf GitHub
  (`github.com/oeme-github/INA-ePA-und-Patientenportale`)

### Startup-Routine — projektspezifische Ergänzungen
Generischer Kern: siehe `dev-notes/STANDARDS.md` §2. Zusätzlich für dieses Projekt:
- `KONTEXT.md` ist die **primäre** Informationsquelle zu Beginn jeder Session — vor `BACKLOG.md`
  gegenlesen
- `gh issue list --state open` — dieses Projekt nutzt GitHub Issues aktiv

---

## Git-Workflow — projektspezifische Ergänzungen
Generischer Kern (Branch-Strategie, PR-Merge-Freigabepflicht) siehe `dev-notes/STANDARDS.md` §3.
Zusätzlich für dieses Projekt:
- **Commit-Format:** `Bereich: Was und warum`
- **WIP-Commits bei unfertigem Stand:** Ist eine Aufgabe am Session-Ende noch nicht abgeschlossen,
  trotzdem committen: `WIP: Bereich – kurze Beschreibung was fehlt` — so geht kein Stand verloren.
  WIP-Commits beim nächsten Start fertigstellen und squashen (bleiben nie dauerhafter Endzustand,
  vereinbar mit `STANDARDS.md`s „kein WIP als Endzustand"-Regel).

---

## Projektprinzipien

Die vier Grundprinzipien (siehe README.md) gelten auch für technische Entscheidungen:
- Prozess vor Daten vor System
- Keine führenden Systeme
- Datenobjekte vor Datenflüsse
- Strukturierte Daten vor Dokumenten

---

## HTML-Widget und Datenhaltung

**Dateien:**
- `patientenpfad_interaktiv.html` — Viewer (nur Darstellung und Logik)
- `patientenpfad_editor.html` — Editor (Formular-Interface, Meta-Verwaltung, Export)
- `patientenpfad_data.js` — Daten und Konfiguration (Quelle der Wahrheit)

**Struktur von `patientenpfad_data.js`:**
- `meta` — pflegbare Auswahllisten: `domaenen`, `akteure`, `datenobjekte`, `rechtsgrundlagen`
- `data` — 25 Prozessschritte; Felder: `nr`, `phase`, `titel`, `akteur[]`, `objekt[]`, `op`, `dr[]`, `domäne`, `gesetze[]`, `detail`

**Regeln:**
- Keine externen Abhängigkeiten (kein npm, kein CDN)
- Viewer und Editor laden `patientenpfad_data.js` per `<script src="...">`
- Änderungen an den Daten immer über den Editor + Export, nicht direkt im JS
- Migrationspfad zu Webserver + JSON ist offen gehalten (Struktur bleibt kompatibel)

---

## Multi-User-Web-Tool — ausgegliedert (Session 2026-08-15)

Der frühere parallele Tooling-Track (`supabase/`, `viewer-db/`, `editor-db/`,
`shared/`) lebt seit dieser Session als eigenständiges, generisches Projekt
in **[open-starcore](https://github.com/oeme-github/open-starcore)** (eigenes
Repo, eigenes `CLAUDE.md`). Grund: das Datenmodell war von Anfang an bewusst
generisch gebaut (mandantenfähig, frei definierbare Dimensionen) und wird
inzwischen auch für Anwendungsfälle außerhalb der INA/AK Patientenportale
genutzt. Details zur Ausgliederung siehe KONTEXT.md, Abschnitt „Ausgliederung
in eigenes Projekt (open-starcore)".

**Harte Randbedingung weiterhin gültig:** `patientenpfad_interaktiv.html`,
`patientenpfad_editor.html` und `patientenpfad_data.js` bleiben unangetastet,
solange das ausgegliederte Tool nicht nachweislich gleichwertig ist und die
AG einem Cutover zugestimmt hat (siehe Cutover-Checkliste in BACKLOG.md) —
das gilt unabhängig davon, in welchem Repo der Tool-Code liegt.

**Was noch hier im INA-Repo lebt:** `tools/prozesslandkarte-sync/` — das
Datenabgleich-Tooling zwischen `patientenpfad_data.js` (bleibt hier, AG
pflegt weiter über den bestehenden Editor) und der Workgroup
`ak-patientenportale` in der open-starcore-Instanz. Gehört inhaltlich hierher
(kennt `patientenpfad_data.js` und den festen Workgroup-Key), nicht zur
generischen Engine. Details: `tools/prozesslandkarte-sync/README.md`.

Die produktiv laufende AK-Patientenportale-Instanz (aktuell `inabox.lan`,
siehe KONTEXT.md „Heimnetz-Deployment: inabox.lan") bezieht ihren Code jetzt
aus `open-starcore`, nicht mehr aus diesem Repo.

---

## Allgemeine Regeln

- Keine neuen Dateien ohne expliziten Auftrag
- Änderungen am Arbeitsdokument immer mit dem User abstimmen, bevor umgesetzt wird

---

## Session-End-Routine — projektspezifische Ergänzungen
Generischer Kern: siehe `dev-notes/STANDARDS.md` §4. Zusätzlich für dieses Projekt:
- **`KONTEXT.md`:** neue Entscheidungen/Architekturentscheidungen + Begründungen eintragen;
  offene Punkte aktualisieren (erledigte abhaken, neue ergänzen); Dateiversionen-Tabelle (Stand +
  Datum) aktualisieren; Requirements-Tabelle-Status auf „Erledigt" setzen wo zutreffend
- **`patientenpfad_arbeitsdokument.md`:** bei inhaltlichen Änderungen Versionsnummer erhöhen
  (v3 → v4 etc.) und Datum aktualisieren
- **`patientenpfad_data.js`:** prüfen ob durch einen Editor-Export verändert (`git status`) — falls
  ja, mit Hinweis auf den Export committen
- PR erstellen (falls noch nicht vorhanden), Beschreibung: was geändert, was noch offen

---

## Automatisch geladene Dateien (via `@`-Import)
- @KONTEXT.md — **zuerst lesen**: primäre Informationsquelle, aktueller Arbeitsstand
- @BACKLOG.md — offene Aufgaben, Cutover-Checkliste
- @README.md — Projektübersicht, vollständige Team-Konventionen
- @~/git_repos/dev-notes/STANDARDS.md — verbindlicher, projektübergreifender Arbeitsablauf
  (Hub-Regelwerk; externer Import außerhalb dieses Projekts — Claude Code zeigt beim allerersten
  Laden einen einmaligen Genehmigungsdialog, danach automatisch)

---

## Doku-Check (alle 4 Wochen)
Dedizierte Session zur Synchronisierung der Dokumentation mit dem tatsächlichen Projektstand:
- `CLAUDE.md` — nur noch projektspezifische Fakten hier; deckt sich der Rest noch mit
  `dev-notes/STANDARDS.md`, oder ist hier wieder generischer Inhalt reingerutscht?
- `README.md`/`KONTEXT.md` — Features, Konfiguration, Team-Konventionen
- `BACKLOG.md` — erledigte Einträge bereinigen, neue Erkenntnisse ergänzen; IDs auf
  `<repo>_<ID>`-Konvention prüfen und ggf. nachziehen (siehe `dev-notes/STANDARDS.md`) — inkl.
  Querverweise in `dev-notes/PROJECTS.md`/`dev-notes/projects/INA-ePA-und-Patientenportale.md`
  und `open-starcore`

Nächster Doku-Check: **2026-10-03**

---

## Verwandte Repositories

| Repo | Zweck |
|------|-------|
| `oeme-github/dev-notes` | PM-Hub, Projektübersicht |
| `oeme-github/open-starcore` | Ausgegliederte generische Multi-User-Engine (2026-08-15) — teilt sich die Deutsch-Sprachregel-Ausnahme |
