# CLAUDE.md – Arbeitsanweisungen für Claude Code

## Sprache
Alle Ausgaben, Commit-Messages, Kommentare und Dokumente auf Deutsch.

---

## Session-Start

1. `git status` und `git log --oneline -5` ausführen — was liegt offen?
2. `git pull` — aktuellen Stand holen
3. `KONTEXT.md` lesen — aktuellen Arbeitsstand verstehen
4. User fragen: Was ist heute das Ziel?

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

## Allgemeine Regeln

- `KONTEXT.md` ist die primäre Informationsquelle zu Beginn jeder Session
- Keine neuen Dateien ohne expliziten Auftrag
- Änderungen am Arbeitsdokument immer mit dem User abstimmen, bevor umgesetzt wird
