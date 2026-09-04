# CLAUDE.md – Arbeitsanweisungen für Claude Code

## Sprache
Alle Ausgaben, Commit-Messages, Kommentare und Dokumente auf Deutsch.

---

## Session-Start

1. `git status` und `git log --oneline -5` ausführen — was liegt offen?
2. `git pull` — aktuellen Stand holen
3. `KONTEXT.md` lesen — aktuellen Arbeitsstand verstehen
4. `gh issue list --state open` ausführen — offene Issues anzeigen
5. User fragen: Was ist heute das Ziel?

---

## Session-Ende

### 1. Dokumente prüfen und aktualisieren

**`KONTEXT.md`**
- Neue Entscheidungen, Architekturentscheidungen und Begründungen eintragen
- Offene Punkte aktualisieren (erledigte abhaken, neue ergänzen)
- Dateiversionen-Tabelle aktualisieren (Stand und Datum prüfen)
- Requirements-Tabelle: Status der bearbeiteten Punkte auf „Erledigt" setzen

**`patientenpfad_arbeitsdokument.md`**
- Prüfen ob inhaltliche Änderungen aus der Session eingeflossen sind
- Falls ja: Versionsnummer erhöhen (v3 → v4 etc.) und Datum aktualisieren

**`patientenpfad_data.js`**
- Prüfen ob die Datei durch einen Editor-Export verändert wurde (`git status`)
- Falls ja: committen mit Hinweis auf den Export

**`CLAUDE.md`**
- Prüfen ob neue Arbeitsanweisungen oder Konventionen ergänzt werden müssen
- Technische Hinweise zum Widget bei strukturellen Änderungen aktualisieren

### 2. Alles committen und pushen

- Alle offenen Änderungen committen (Deutsch, Format: `Bereich: Was und warum`)
- Branch pushen

### 3. Pull Request

- PR erstellen, falls noch nicht vorhanden
- PR-Beschreibung: Was wurde geändert, was ist noch offen?

### 4. User informieren

- Was liegt auf GitHub (PR, Branch)?
- Was ist noch offen für die nächste Session?

### 5. Hub-Übergabe

Zusätzlich zu obigen Schritten gilt `dev-notes/STANDARDS.md` Abschnitt 4
(Projekt-End-Routine):
1. `~/git_repos/dev-notes/projects/INA-ePA-und-Patientenportale.md`
   schreiben (Datum, zuletzt erledigt, nächster Schritt, offene Fragen —
   Format: `dev-notes/templates/SESSION.md`)
2. `~/git_repos/dev-notes/PROJECTS.md` — Eintrag
   „INA-ePA-und-Patientenportale" mit demselben nächsten Schritt
   aktualisieren
3. Danach im Hub-Chat (dev-notes-Session) kurz Bescheid geben: was erledigt
   wurde, nächster Schritt — die Hub-Session hat sonst keinen Einblick in
   diese Konsole

---

## Git-Workflow

- Nie direkt in `main` pushen
- Feature-Branches: `feature/thema`, `fix/thema`
- Ein Commit pro sinnvoller Arbeitseinheit
- Commit-Format: `Bereich: Was und warum`

**Häufig committen — nicht erst am Session-Ende:**
Nach jeder abgeschlossenen Teilaufgabe direkt committen und pushen, nicht auf das Session-Ende warten.

**WIP-Commits bei unfertigem Stand:**
Wenn eine Aufgabe am Session-Ende noch nicht abgeschlossen ist, trotzdem committen:
`WIP: Bereich – kurze Beschreibung was fehlt`
So geht kein Stand verloren. WIP-Commits beim nächsten Start fertigstellen und squashen.

**Vor jedem Branch-Wechsel: `git status` prüfen.**
Nie `git checkout` oder `git switch` ausführen, bevor sichergestellt ist, dass keine uncommitted Changes vorhanden sind. Falls doch: erst committen oder stashen.

Siehe README.md für vollständige Team-Konventionen.

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

- `KONTEXT.md` ist die primäre Informationsquelle zu Beginn jeder Session
- Keine neuen Dateien ohne expliziten Auftrag
- Änderungen am Arbeitsdokument immer mit dem User abstimmen, bevor umgesetzt wird
