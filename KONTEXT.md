# KONTEXT.md – Aktueller Arbeitsstand

Dieses Dokument ist das lebende Gedächtnis des Projekts. Es wird zu Beginn jeder Session gelesen und am Ende aktualisiert.

---

## Dateiversionen

| Datei | Version | Stand | Letzte Änderung |
|---|---|---|---|
| `patientenpfad_arbeitsdokument.md` | v6 | 2026-05-28 | Kap. 9.3: Differenzierung Patientenportal vs. Zuweiserportal ergänzt |
| `patientenpfad_interaktiv.html` | v13 | 2026-05-28 | Akteure als Tags in Prozess-Kacheln (Issue #22) |
| `patientenpfad_editor.html` | v3 | 2026-05-11 | GitHub-API-Integration, neue Felder ist/luecke/forderungen |
| `patientenpfad_data.js` | v7 | 2026-05-28 | ist/luecke/forderungen Schritte 7, 8, 13 befüllt (UAG Klinische Prozesse) |
| `ANLEITUNG_EDITOR.md` | – | 2026-05-11 | Neu: Token-Setup und Nutzung der GitHub-Speicherung |
| `.github/CODEOWNERS` | – | 2026-04-25 | oeme-github + msusky |
| `CLAUDE.md` | – | 2026-04-25 | Session-Ende-Checkliste erweitert, Widget-Abschnitt aktualisiert |
| `index.html` | v2 | 2026-04-29 | Startseite mit Viewer- und Editor-Karten |
| `forderungen_praeklinisch.md` | v1 | 2026-05-21 | Neu: Forderungen Präklinisch in drei Varianten |
| `positionspapier.md` | v0.4 | 2026-06-08 | msusky-Feedback eingearbeitet (14 Kommentare); DOCX lokal als v0.4 erzeugen |
| `agenda_positionspapier.md` | – | 2026-06-03 | Neu: AG-Dokument konvertiert (Grundlage Kapitelstruktur) |
| `forderungen_ag.md` | – | 2026-06-03 | Neu: AG-Dokument konvertiert (Grundlage Kap. 5) |
| `KONTEXT.md` | – | 2026-06-08 | Session 2026-06-08 (II) abgeschlossen |
| `README.md` | – | 2026-04-29 | GitHub-Pages-Link ergänzt |

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

## Quellen und Artefakte der AG

Originaldokumente (Präsentationen, Zusammenfassungen, UAG-Ergebnisse) liegen im SharePoint der gematik / KIG. Der Zugriff ist auf AK-Mitglieder beschränkt. Artefakte werden nicht ins Repository eingecheckt – relevante Inhalte fließen direkt in `patientenpfad_data.js` und `patientenpfad_arbeitsdokument.md` ein.

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

### Zur Ist-Analyse (Issue #14)

Die UAG „Vor Krankenhaus" hat in ihrer ersten Sitzung entschieden, auf Detailebene zu bleiben und pro Prozessschritt textuell zu beschreiben: Was ist da? / Was fehlt? / Forderungen. Diese Struktur wurde als drei neue Felder (`ist`, `luecke`, `forderungen`) im Datenmodell abgebildet. Schritte 1–3 sind mit dem UAG-Ergebnis befüllt, Schritte 4–25 warten auf weitere Sitzungen.

### Zur Ist-Analyse: Umgang mit bestehender Technik (Session 2026-05-18)

AG-Feedback: Technisch orientierte Mitglieder befürchten einen "Papiertiger", wenn bestehende technische Lösungen nicht berücksichtigt werden. Reaktion: Rahmentext in Kap. 1 des Arbeitsdokuments ergänzt — bestehende Lösungen (VSDM, ISiK, ePA, FHIR) sind explizit Ausgangspunkt der Ist-Analyse, nicht ihr Gegner. Die `ist`-Felder beschreiben jetzt konkret und wertschätzend, was heute bereits funktioniert.

Inhaltliche Korrekturen aus der Sitzung:
- KIM-Adresse ist ein Attribut des Hausarztes, nicht des Patienten (Patienten haben keine KIM-Adressen)
- Die gematik hat kein Einwilligungsmanagement in der ePA eingeführt — der gesetzlich vorgesehene Widerspruch (SGB V § 342) wurde an die KIS delegiert
- Die Anamnese wird als kontinuierlicher, akteursübergreifender Prozess beschrieben: einmal erheben, sektorenübergreifend verfeinern — nicht neu erzeugen

### Zur Online-Pflege (Editor GitHub-Integration)

Der Editor kann `patientenpfad_data.js` jetzt direkt per GitHub REST API ins Repository schreiben. AG-Mitglieder benötigen einen GitHub Personal Access Token (classic, `repo`-Scope) und tragen ihn einmalig im ⚙-Panel ein. Anleitung: `ANLEITUNG_EDITOR.md`. Damit entfällt der manuelle Export/Commit-Workflow für die Datenpflege.

### Zu persistent vs. transient (Issue #17)
Die AG hat Datenobjekte als reine Speicherobjekte missverstanden und den EHDS als „transaktional" bezeichnet. Beides ist berechtigt: Das Dokument verwendete „vorliegen" (Kap. 6), was Persistenz impliziert. Klarstellung in Kap. 4 und Kap. 6: Datenobjekte können persistent (Diagnose, Medikationsplan) oder transient (Terminanfrage, Nachricht) sein – die Unterscheidung trifft der Prozess. EHDS-Beschreibung um transaktionale Dimension ergänzt (MyHealth@EU).

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
| Issue #12 (DIN EN ISO/IEEE 11073 ergänzen) | Claude | Erledigt (2026-04-29) |
| Issue #13 (Matrix-Ansicht Domänen × Datenräume) | Claude | Erledigt (2026-04-30) – PR #15 gemergt |
| R2.5 (Druckübersicht strukturierte Tabelle) | Claude | Erledigt (2026-04-30) – PR #16 |
| Matrix-Legende + Hover-Fix | Claude | Erledigt (2026-04-30) – PR #16 |
| Issue #14 (Ist-Analyse) | Claude | Erledigt (2026-05-11) – PR #19, PR #20 |
| Issue #17 (Datenobjekte persistent/transient) | Claude | Erledigt (2026-05-07) – PR #18 |
| Ist-Analyse Schritte 1–6 überarbeiten (AG-Feedback Papiertiger) | Claude | Erledigt (2026-05-18) – PR #23 |
| Forderungen Präklinisch verdichten und als Positionspapier aufbereiten | Claude | Erledigt (2026-05-21) – PR #24 gemergt |
| Schritte 7, 8, 13 mit UAG-Ergebnissen befüllen (klinische Phase) | Claude | Erledigt (2026-05-28) – PR #24 gemergt |
| Issue #22: Akteure als Tags in Prozess-Kacheln | Claude | Erledigt (2026-05-28) – PR #25 gemergt |
| Positionspapier: Grundstruktur + Kap. 3 und 4 ausarbeiten | Claude | Erledigt (2026-06-03) – PR #26 offen |
| Positionspapier: IQWiG-Feedback (Klaus Koch) einarbeiten | Claude | Erledigt (2026-06-03) – PR #26 aktualisiert, v0.2 |
| Positionspapier: HO-Feedback (Henrik Ohlms) einarbeiten | Claude | Erledigt (2026-06-08) – PR #26 aktualisiert, v0.3 |
| Positionspapier: msusky-Feedback einarbeiten (14 Kommentare) | Claude | Erledigt (2026-06-08) – PR #26 aktualisiert, v0.4 |

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
| R2.5 | Druckansicht / Export (alle sichtbaren Karten als strukturierte Übersicht) | Niedrig | Erledigt |

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

### Im Tool
- Schritte 1–6: `ist`, `luecke`, `forderungen` überarbeitet und vereinheitlicht (Session 2026-05-18, PR #23)
- Schritte 7–25: Felder `ist`, `luecke`, `forderungen` noch leer – Befüllung in weiteren UAG-Sitzungen
- Editor-Anleitung (`ANLEITUNG_EDITOR.md`) an AG-Mitglieder weitergeben, die Daten pflegen sollen

### Positionspapier (Session 2026-06-03)
- Zwei AG-Dokumente (`Agenda Positionspapier.docx`, `Forderungen.docx`) als Markdown konvertiert
- `positionspapier.md` angelegt: alle 6 Kapitel, Kap. 3 und 4 vollständig ausgearbeitet
- Kap. 3: Grundprinzipien, Prozessmodell, Domänen, Datenräume, Akteure, interaktives Schaubild
- Kap. 4.3: 12 analysierte Prozessschritte aus 3 UAGs (je eine je Phase)
- Kap. 4.4: Ist-Analyse + Use Case für alle 12 Schritte
- Kap. 5+6: Vorschläge der UAG für Plenum — nicht unsere Kapitel
- Kap. 1, 2, 4.1, 4.2: Platzhalter — obliegen dem Plenum
- QS-Runde abgeschlossen: Abkürzungen eingeführt, Dopplungen bereinigt, Zählfehler korrigiert
- PR #26 offen, noch nicht gemergt

### IQWiG-Feedback (Session 2026-06-03, II)
- Erste Rückmeldung von Klaus Koch (IQWiG) über `positionspapier_IQWiG.docx` mit 12 Kommentaren ausgewertet
- Kernforderung IQWiG: Patientenberatung/-aufklärung und Gesundheitsinformationen als Datenobjekte im Modell verankern
- Akteur „Ersteller von Gesundheitsinformationen" (§ 139a SGB V) ergänzt
- Informationsdomäne „Dokumente" um Gesundheitsinformationen erweitert
- Schritte 8, 13, 19, 21: Lückenabschnitte um Gesundheitsinformationen-Dimension ergänzt
- Kap. 3.2: Prozessbegleitende Elemente (Querschnittsthema) eingeführt
- Kap. 4.4: Neuer Abschnitt Querschnittsthema Patientenberatung + Plenum-Hinweis zu Option 2 (eigener Prozessschritt)
- Kap. 5.2: § 395 SGB V und LOINC-Verknüpfung ergänzt
- Begriff „Quelle der Wahrheit" → „verbindlicher Referenzdatensatz" (konsistent an 3 Stellen)
- `positionspapier.md` auf v0.2 hochgesetzt, DOCX lokal neu erzeugt
- PR #26 aktualisiert

### HO-Feedback (Session 2026-06-08)
- Rückmeldung von Henrik Ohlms (HO) über `positionspapier_HO.docx` mit 4 Kommentaren ausgewertet
- Kommentar #29: ISiK-Formulierung auf „durchsetzen" umgestellt (Standard gilt bereits) — Schritt 7 + Kap. 5.1
- Kommentar #32: Ist-Analyse-Kontext klargestellt: „Im heutigen Ist-Zustand gilt das KIS als führendes System..." — kein echter Widerspruch zu Grundprinzip
- Kommentar #38: PDF-Fallback als explizite Übergangslösung formuliert (nicht als gleichwertige Alternative)
- Kommentar #39: „Datenhoheit beim Krankenhaus" ersetzt durch „Keine Sekundärnutzung und keine proprietäre Bindung" — Widerspruch zu Grundprinzip aufgelöst; AG-Hinweis zur Prüfung ergänzt
- `positionspapier.md` auf v0.3 hochgesetzt, DOCX lokal neu erzeugt
- Änderungshistorie als eigener Abschnitt am Ende des Dokuments ergänzt
- PR #26 aktualisiert

### msusky-Feedback (Session 2026-06-08, II)
- Rückmeldung von msusky über PR #26 mit 14 Inline-Kommentaren eingearbeitet
- Grundprinzipien Kap. 3.2: Terminologie auf „Datenobjekte" vereinheitlicht; Grundprinzip 4 umbenannt in „Strukturierte Datenobjekte vor dokumentenbasierter Darstellung"; Lebenszyklus (E/V/G) von Bereitstellung/Nutzung getrennt; Operation als Verb des Prozessschritts präzisiert
- Kap. 3.3: Überschrift um „Datenräume und Akteure" ergänzt
- Kap. 4.3: Auswahlkriterien der Prozessschritte korrigiert — Longlist 80+ Schritte, zweistufige Auswahl, drei UAG-Methoden
- Kap. 4.4: Einheitliche Zwischenüberschriften (Ist-Zustand / Lücke / Use Case / Forderung) in allen 12 Schritten + Querschnittsthema
- Schritt 6: Fokus auf Consent Management geschärft; datenschutzrechtliche vs. medizinrechtliche Einwilligung getrennt; Use Case auf ePA-Zugriff/Widerspruch neu geschrieben
- Schritt 13: Lücke in zwei getrennte Probleme aufgeteilt (Redundanz/Architektur + Workflow/Ethik); Use Case ergänzt
- Schritt 21: Redundanzen zu Schritt 6 und 13 entfernt; Fokus auf Strukturdaten statt Dokumente
- Kap. 5: „Keine kommerzielle Sekundärnutzung" (Abgrenzung zu GDNG-Forschungszwecken)
- `positionspapier.md` auf v0.4 hochgesetzt; DOCX lokal neu erzeugen
- PR #26 kommentiert — msusky per GitHub-Benachrichtigung informiert

### UAG Klinische Prozesse (Session 2026-05-28)
- Schritte 7, 8 und 13 mit UAG-Ergebnissen befüllt (`ist`, `luecke`, `forderungen`)
- UAG-Fazit: Methode funktioniert; nicht alle Schritte konnten bearbeitet werden
- UAG empfiehlt Differenzierung Patientenportal vs. Zuweiserportal → als neuer Abschnitt 9.3 ins Arbeitsdokument übernommen

### Im Dokument
- Systemebene (Kap. 8) könnte um weitere Ist-Analyse-Beispiele ergänzt werden
- Lebenszyklus von Datenobjekten wurde diskutiert, aber bewusst ausgeklammert – kann später ergänzt werden
- Die Matrix (Kap. 7) soll in der Gruppe weiter diskutiert und verfeinert werden

### Inhaltlich
- Standards prüfen: FHIR, IHE, HL7 – welche erfüllen die Anforderungen A1-A3?
- Impulse aus dem Ausland: Dänemark, Estland, Niederlande
- Pilotprozesse definieren für einen Proof of Concept

### Offene Plenumsentscheidung: Querschnittsthema Patientenberatung
- Kap. 4.4 enthält Querschnittsthema + Plenum-Hinweis
- Frage: Soll „Patient beraten und aufklären" als eigenständiger Prozessschritt ins Modell aufgenommen werden?
- Bei Ja: Ergänzung in `patientenpfad_data.js` und ggf. Renummerierung erforderlich

---

## Technische Hinweise (für Claude Code)

- Daten liegen in `patientenpfad_data.js` — nicht in der HTML-Datei
- `meta`-Objekt enthält pflegbare Auswahllisten: `domaenen`, `akteure`, `datenobjekte`, `rechtsgrundlagen`
- `data`-Array: 25 Einträge mit `nr`, `phase`, `titel`, `akteur[]`, `objekt[]`, `op`, `dr[]`, `domäne`, `gesetze[]`, `detail`
- Die vier Datenräume sind: `portal`, `versorgung`, `epa`, `ehds`
- Viewer und Editor laden `patientenpfad_data.js` per `<script src="...">`
- Suche im Viewer: kombiniert mit allen Filtern, Highlighting via `<mark>`-Tags
