# KONTEXT.md – Aktueller Arbeitsstand

Dieses Dokument ist das lebende Gedächtnis des Projekts. Es wird zu Beginn jeder Session gelesen und am Ende aktualisiert.

---

## Dateiversionen

| Datei | Version | Stand | Letzte Änderung |
|---|---|---|---|
| `patientenpfad_arbeitsdokument.md` | v3 | 2026-04-24 | Grundprinzip 3 korrigiert: „vor" statt „statt" |
| `patientenpfad_interaktiv.html` | v8 | 2026-04-25 | Struktur-Filter als Filter-Zeile im Toolbar |
| `patientenpfad_editor.html` | v2 | 2026-04-25 | Standards + Struktur-Select ergänzt |
| `patientenpfad_data.js` | v3 | 2026-04-25 | meta.standards (32 Einträge + KIM), struktur-Feld alle 25 Schritte |
| `.github/CODEOWNERS` | – | 2026-04-25 | oeme-github + msusky |
| `CLAUDE.md` | – | 2026-04-25 | Session-Ende-Checkliste erweitert, Widget-Abschnitt aktualisiert |
| `KONTEXT.md` | – | 2026-04-25 | Lebendes Dokument, kein Versionsschema |
| `README.md` | – | 2026-04-25 | Grundprinzip 3 korrigiert |

---

## Worum geht es?

**AK Patientenportale** im Rahmen der INA der gematik — Standardisierung des Datenaustauschs zwischen:
- einrichtungsspezifischen Patientenportalen
- einrichtungsspezifischen Primärsystemen (KIS/PVS)
- der bundesweiten elektronischen Patientenakte (ePA)

Offizielle Seite: https://www.ina.gematik.de/mitwirken/arbeitskreise/rolle-von-patientenportalen-im-zusammenspiel-mit-primaersystemen-und-epa-1

Eine Unterarbeitsgruppe des AK beschäftigt sich mit dem Patientenpfad und den Prozessen vor, im und nach dem Krankenhaus.

---

## Was wurde erarbeitet?

### Methodischer Ansatz
Die Gruppe hat sich auf einen bewusst prozessgetriebenen Ansatz geeinigt – in dieser Reihenfolge:

**Erst die Prinzipien – dann der Prozess – dann die Daten.**

Die Systemebene wird zunächst ausgeklammert und erst später als Mapping auf Prozesse und Daten betrachtet.

### Leitformel
> **Akteur × Prozess → Datenobjekt**

Diese Formel ist der gemeinsame Anker der Gruppe. Kein Element kann ohne die anderen beiden gedacht werden.

### Vier Grundprinzipien
1. **Prozess vor Daten vor System** – Systeme sind Werkzeuge, keine Ausgangspunkte
2. **Keine führenden Systeme** – Daten gehören dem Prozess und dem Patienten
3. **Datenobjekte vor Datenflüsse** – Was wird wann von wem erzeugt, verändert oder gelöscht?
4. **Strukturierte Daten vor Dokumenten** – Maschinenlesbarkeit ist das Ziel; die menschenlesbare Darstellung ist Aufgabe der Systeme

### Erarbeitete Dokumente
1. **`patientenpfad_arbeitsdokument_v3.md`** – Das vollständige Arbeitsdokument mit allen 9 Kapiteln
2. **`patientenpfad_interaktiv.html`** – Interaktive Prozesskarte mit Filter nach Phase und Datenraum

### Struktur des Arbeitsdokuments
1. Einführung des Vorgehens
2. These & Grundprinzipien
3. Prozessmodell (25 Prozessschritte, 3 Phasen, mit Akteuren)
4. Datenmodell (Datenobjekte mit Operationen E/V/G)
5. Informationsdomänen (14 Domänen, systemunabhängig)
6. Datenräume (Portal, Versorgungssysteme, ePA, EHDS)
7. Verteilung der Informationsdomänen über Datenräume (Matrix)
8. Systemebene (Ist-Analyse mit 2 Beispielen + Anforderungen A1-A3)
9. Ausblick (Ziel + nächste Schritte)

---

## GitHub-Konfiguration

### Ruleset (Branch-Schutz für `main`)
- Kein "Required approvals" (würde zweite Person erfordern)
- Stattdessen: **"Require review from Code Owners"** aktiviert
- Code Owners: `@oeme-github` und `@msusky` (`.github/CODEOWNERS`)
- `*.docx` ist in `.gitignore` — Word-Exporte werden nicht eingecheckt

---

## Wichtige inhaltliche Entscheidungen

### Zum Begriff „Datenobjekt"
Bewusste Abkehr vom Begriff „Datenaustausch zwischen Systemen". Stattdessen: Datenobjekte werden von Akteuren im Kontext von Prozessen erzeugt, verändert oder gelöscht. Systeme sind nur der Darstellungslayer.

### Zur Definition von „Erzeugt (E)"
> Ein Datenobjekt gilt als erzeugt (E), wenn es im Kontext des jeweiligen Prozessschritts erstmalig vorliegt – unabhängig davon, ob es an anderer Stelle bereits existiert.

### Zur Einwilligung / Widerspruch
Einwilligung und Widerspruch sind zwei eigenständige Datenobjekte mit unterschiedlicher rechtlicher Wirkung. Beide werden erzeugt (E).

### Zur Pflege
Die Pflege wurde bewusst als eigenständiger Akteur mit drei eigenen Prozessschritten eingeführt:
- Pflegeassessment
- Pflegedokumentation
- Pflegerische Entlassungsplanung

### Zur Kommunikation / TI-Messenger
Kommunikation wird systemunabhängig betrachtet. Der TI-Messenger ist eine Implementierung, keine Domäne. Kommunikation als Informationsdomäne existiert unabhängig vom Übertragungsweg.

### Zum EHDS
Der European Health Data Space wurde als vierter Datenraum aufgenommen – neben Portal, Versorgungssystemen und ePA. Er erweitert den Datenraum auf die europäische Ebene.

### Zur ePA
Die ePA ist heute dokumentenlastig. Das Ziel sind strukturierte Datenobjekte, die maschinenlesbar und automatisierbar sind. Die Matrix der Informationsdomänen erhebt keinen Anspruch auf Vollständigkeit.

---

## Geplante Aufgaben

| Aufgabe | Wer | Status |
|---|---|---|
| `patientenpfad_arbeitsdokument.md` als Word-Datei bereitstellen | Du | Erledigt (lokal per Pandoc generiert, nicht eingecheckt) |
| HTML-Widget weiter verbessern | Claude | Abgeschlossen – alle Requirements R1–R4 erledigt |
| PR #2 (CODEOWNERS + .gitignore) mergen | oeme-github | Erledigt (gemergt 2026-04-25) |
| PR #3 (Widget v2) mergen | oeme-github | Erledigt (gemergt 2026-04-25) |
| PR #4 (Freitextsuche) mergen | oeme-github | Erledigt (gemergt 2026-04-25) |
| PR #5 (AK Patientenportale) mergen | oeme-github | Erledigt (gemergt 2026-04-25) |
| PR #6 (Export PDF/CSV/JSON) mergen | oeme-github | Erledigt (gemergt 2026-04-25) |
| PR #7 (Standards + Struktur-Kennzeichen) mergen | oeme-github | Erledigt (gemergt 2026-04-25) |
| PR #8 (Standards-Filter + Auf-/Zuklappen + Struktur-Filter) mergen | oeme-github | Erledigt (gemergt 2026-04-25) |
| PR #10 (Struktur-Filter + CLAUDE.md Commit-Konventionen) mergen | oeme-github | Erledigt (gemergt 2026-04-25) |

---

## Requirements: HTML-Widget (`patientenpfad_interaktiv.html`)

Ziel: Eine interaktive, pflegbare Prozesslandkarte, die in der Arbeitsgruppe genutzt und weiterentwickelt werden kann.

### R1 – Datenstruktur erweitern

| ID | Anforderung | Priorität | Status |
|---|---|---|---|
| R1.1 | Laufende Nummer `nr` (1–25) pro Prozessschritt ergänzen | Hoch | Erledigt |
| R1.2 | Feld `domäne` ergänzen – Zuordnung zu einer der 14 Informationsdomänen (Kap. 5) | Hoch | Erledigt |
| R1.3 | Feld `standards` ergänzen – zunächst leer, später mit FHIR/IHE/HL7 befüllen | Mittel | Erledigt (Entwurf – Review durch AG) |
| R1.4 | Feld `gesetze` ergänzen – Zuordnung relevanter Rechtsgrundlagen pro Schritt (z.B. DSGVO Art. 9, SGB V § 291a, PatDatSchG, KHZG) | Hoch | Erledigt (Entwurf – Review durch AG) |

### R2 – Benutzeroberfläche verbessern

| ID | Anforderung | Priorität | Status |
|---|---|---|---|
| R2.1 | Zähler anzeigen: „X von 25 Prozessschritten sichtbar" | Hoch | Erledigt |
| R2.2 | Freitextsuche über Titel, Akteur, Objekt | Mittel | Erledigt (mit Highlighting) |
| R2.3 | `sendPrompt()`-Button entfernen – toter Platzhalter | Hoch | Erledigt |
| R2.4 | Detailkarte: `nr`, `domäne`, `standards` und `gesetze` anzeigen, sobald befüllt | Mittel | Erledigt |
| R2.5 | Druckansicht / Export (alle sichtbaren Karten als strukturierte Übersicht) | Niedrig | Offen |

### R3 – Pflegbarkeit & Architektur

| ID | Anforderung | Priorität | Status |
|---|---|---|---|
| R3.1 | Daten in separate Datei `patientenpfad_data.js` auslagern (`const data = [...]`) | Hoch | Erledigt |
| R3.2 | HTML-Datei bindet Datendatei ein: `<script src="patientenpfad_data.js">` | Hoch | Erledigt |
| R3.3 | Phasengrenzen im `data`-Array durch Kommentare markieren | Mittel | Erledigt |
| R3.4 | Migrationspfad zu Web-Server + JSON offen halten (spätere Phase) | – | Entschieden |
| R3.5 | `meta`-Objekt in `data.js` für pflegbare Auswahllisten (domaenen, akteure, datenobjekte, rechtsgrundlagen) | Hoch | Erledigt |
| R3.6 | `patientenpfad_editor.html` – separater Editor mit Meta-Verwaltung und Export | Hoch | Erledigt |

**Architekturentscheidung – Migrationspfad:**

```
Phase 1 (jetzt):   patientenpfad_data.js   →  const data = [{...}]
Phase 2 (später):  patientenpfad_data.json →  [{...}]  (JS-Wrapper fällt weg)
```

Die Datenstruktur selbst ändert sich beim Übergang **nicht**. Der Wechsel auf einen Webserver mit JSON ist damit eine spätere, isolierte Änderung.

### R4 – Export

| ID | Anforderung | Priorität | Status |
|---|---|---|---|
| R4.1 | PDF-Export via Browser-Druckdialog (optimiertes Drucklayout) | Mittel | Erledigt (inkl. Filterzeile im Druck) |
| R4.2 | CSV-Export der sichtbaren/gefilterten Prozessschritte | Mittel | Erledigt |
| R4.3 | JSON-Export des vollständigen `data`-Arrays | Niedrig | Erledigt (gefilterte Auswahl) |

### Reihenfolge der Umsetzung

1. R3.1 + R3.2 + R3.3 — Datentrennung: `data.js` auslagern
2. R1.1 + R1.2 + R1.4 — Datenstruktur mit `nr`, `domäne` und `gesetze` befüllen
3. R2.3 — `sendPrompt()` entfernen
4. R2.1 + R2.4 — Zähler und erweiterte Detailkarte (inkl. Domäne, Rechtsgrundlagen)
5. R1.3 + R2.2 — Standards-Feld, Freitextsuche
6. R4.1 + R4.2 + R4.3 — Export (PDF, CSV, JSON)
7. R3.4 — Migration zu Web-Server + JSON (eigene spätere Session)

---

## Offene Punkte & nächste Schritte

### Im Dokument
- Systemebene (Kap. 8) könnte um weitere Ist-Analyse-Beispiele ergänzt werden
- Lebenszyklus von Datenobjekten wurde diskutiert, aber bewusst ausgeklammert – kann später ergänzt werden
- Die Matrix (Kap. 7) soll in der Gruppe weiter diskutiert und verfeinert werden

### Inhaltlich
- Standards prüfen: FHIR, IHE, HL7 – welche erfüllen die Anforderungen A1-A3?
- Impulse aus dem Ausland: Dänemark, Estland, Niederlande
- Pilotprozesse definieren für einen Proof of Concept

---

## Technische Hinweise (für Claude Code)

- Daten liegen in `patientenpfad_data.js` — nicht in der HTML-Datei
- `meta`-Objekt enthält pflegbare Auswahllisten: `domaenen`, `akteure`, `datenobjekte`, `rechtsgrundlagen`
- `data`-Array: 25 Einträge mit `nr`, `phase`, `titel`, `akteur[]`, `objekt[]`, `op`, `dr[]`, `domäne`, `gesetze[]`, `detail`
- Die vier Datenräume sind: `portal`, `versorgung`, `epa`, `ehds`
- Viewer und Editor laden `patientenpfad_data.js` per `<script src="...">`
- Suche im Viewer: kombiniert mit allen Filtern, Highlighting via `<mark>`-Tags
