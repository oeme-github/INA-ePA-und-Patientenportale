# KONTEXT.md – Aktueller Arbeitsstand

Dieses Dokument ist das lebende Gedächtnis des Projekts. Es wird zu Beginn jeder Session gelesen und am Ende aktualisiert.

---

## Dateiversionen

| Datei | Version | Stand | Letzte Änderung |
|---|---|---|---|
| `patientenpfad_arbeitsdokument.md` | v3 | 2026-04-24 | Initialer Stand, Dateiname bereinigt |
| `patientenpfad_interaktiv.html` | v1 | 2026-04-24 | Initialer Stand |
| `.github/CODEOWNERS` | – | 2026-04-25 | Neu angelegt |
| `KONTEXT.md` | – | 2026-04-25 | Lebendes Dokument, kein Versionsschema |
| `README.md` | – | 2026-04-24 | Lebendes Dokument, kein Versionsschema |

---

## Worum geht es?

Arbeitskreis der gematik (ina.gematik.de) zur Standardisierung des Datenaustauschs zwischen:
- einrichtungsspezifischen Patientenportalen
- einrichtungsspezifischen Primärsystemen (KIS/PVS)
- der bundesweiten elektronischen Patientenakte (ePA)

Eine Unterarbeitsgruppe wurde gegründet, die sich mit dem Patientenpfad und den Prozessen vor, im und nach dem Krankenhaus beschäftigt.

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
3. **Datenobjekte statt Datenflüsse** – Was wird wann von wem erzeugt, verändert oder gelöscht?
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
| HTML-Widget weiter verbessern | Claude | Offen |
| PR #2 (CODEOWNERS + .gitignore) mergen | oeme-github | Offen |

---

## Offene Punkte & nächste Schritte

### Im Dokument
- Systemebene (Kap. 8) könnte um weitere Ist-Analyse-Beispiele ergänzt werden
- Lebenszyklus von Datenobjekten wurde diskutiert, aber bewusst ausgeklammert – kann später ergänzt werden
- Die Matrix (Kap. 7) soll in der Gruppe weiter diskutiert und verfeinert werden

### Am HTML-Widget
- Verbesserung der Lesbarkeit und des Designs
- Weitere Interaktivität
- Export-Funktion oder Druckansicht
- Weitere Detailkarten pro Phase

### Inhaltlich
- Standards prüfen: FHIR, IHE, HL7 – welche erfüllen die Anforderungen A1-A3?
- Impulse aus dem Ausland: Dänemark, Estland, Niederlande
- Pilotprozesse definieren für einen Proof of Concept

---

## Technische Hinweise (für Claude Code)

- Alle 25 Prozessschritte sind im `data`-Array in `patientenpfad_interaktiv.html` definiert
- Jeder Eintrag hat: `phase`, `titel`, `akteur`, `objekt`, `op`, `dr` (Datenräume), `detail`
- Die vier Datenräume sind: `portal`, `versorgung`, `epa`, `ehds`
- `sendPrompt()` ist ein Claude.ai-Platzhalter – in Claude Code durch eigene Logik ersetzen
