# AK Patientenportale – Patientenpfad & Datenstandards

**[AK Patientenportale](https://www.ina.gematik.de/mitwirken/arbeitskreise/rolle-von-patientenportalen-im-zusammenspiel-mit-primaersystemen-und-epa-1)** im Rahmen der INA der gematik — Standardisierung des Datenaustauschs zwischen einrichtungsspezifischen Patientenportalen, Primärsystemen (KIS/PVS) und der elektronischen Patientenakte (ePA).

**Live-Version:** [oeme-github.github.io/INA-ePA-und-Patientenportale](https://oeme-github.github.io/INA-ePA-und-Patientenportale/)

---

## Leitformel

> **Akteur × Prozess → Datenobjekt**

Kein Element kann ohne die anderen beiden gedacht werden.

---

## Grundprinzipien

1. **Prozess vor Daten vor System** – Systeme sind Werkzeuge, keine Ausgangspunkte
2. **Keine führenden Systeme** – Daten gehören dem Prozess und dem Patienten
3. **Datenobjekte vor Datenflüsse** – Was wird wann von wem erzeugt, verändert oder gelöscht?
4. **Strukturierte Daten vor Dokumenten** – Maschinenlesbarkeit ist das Ziel

---

## Dateien

| Datei | Inhalt |
|---|---|
| `KONTEXT.md` | Aktueller Arbeitsstand, Entscheidungen, offene Punkte – wird jede Session aktualisiert |
| `patientenpfad_arbeitsdokument.md` | Vollständiges Arbeitsdokument (9 Kapitel) |
| `patientenpfad_data.js` | Daten und Konfiguration – Quelle der Wahrheit für Viewer und Editor |
| `patientenpfad_interaktiv.html` | Interaktive Prozesskarte – Viewer mit Filter nach Phase, Datenraum und Rechtsgrundlage |
| `patientenpfad_editor.html` | Daten-Editor – Prozessschritte und Auswahllisten pflegen, Daten exportieren |

---

## Arbeitsweise mit dem Widget

### Daten pflegen

1. `patientenpfad_editor.html` im Browser öffnen — lädt `patientenpfad_data.js` aus demselben Ordner
2. Prozessschritte bearbeiten, hinzufügen oder löschen
3. Auswahllisten (Domänen, Akteure, Datenobjekte, Rechtsgrundlagen) über „Auswahllisten verwalten" pflegen
4. „data.js exportieren" — lädt die aktualisierte Datei herunter
5. Heruntergeladene Datei ersetzt die bestehende `patientenpfad_data.js`
6. Änderung committen und per Pull Request in `main` mergen

### Datenstruktur (`patientenpfad_data.js`)

Die Datei enthält zwei Objekte:

```js
const meta = {
  domaenen:        [...],  // 14 Informationsdomänen
  akteure:         [...],  // Prozessbeteiligte
  datenobjekte:    [...],  // Erzeugte / veränderte Objekte
  rechtsgrundlagen:[...]   // Gesetzliche Grundlagen (Entwurf)
};

const data = [
  { nr, phase, titel, akteur[], objekt[], op, dr[], domäne, gesetze[], detail },
  ...
];
```

Viewer und Editor laden diese Datei per `<script src="patientenpfad_data.js">` — kein Server erforderlich, keine externen Abhängigkeiten.

---

## Zusammenarbeit

### Branches

- `main` ist immer stabil und gepusht
- Neue Arbeiten starten auf einem Feature-Branch:
  - `feature/thema` – neue Inhalte oder Funktionen
  - `fix/thema` – Korrekturen
- Kein direktes Pushen in `main`

### Pull Requests

- Jede Änderung kommt per Pull Request in `main`
- PR-Beschreibung: kurz erklären was geändert wurde und warum
- Mindestens ein Review vor dem Merge

### Commits

- Kleine, fokussierte Commits — eine Sache pro Commit
- Messages auf Deutsch, Format: `Bereich: Was und warum`
- Beispiele:
  - `Widget: Druckansicht ergänzt`
  - `Prozessmodell: Pflegeschritte präzisiert`
  - `KONTEXT: Offene Punkte nach Session aktualisiert`

---

## Dokumente konvertieren

Das Arbeitsdokument liegt als Markdown vor und kann mit [Pandoc](https://pandoc.org) in andere Formate (Word, PDF, HTML u.a.) konvertiert werden. Installationshinweise für alle Betriebssysteme finden sich auf [pandoc.org](https://pandoc.org/installing.html).

Generierte Dateien (`.docx`, `.pdf`) werden nicht ins Repository eingecheckt.

---

## Aktueller Stand

Siehe [`KONTEXT.md`](KONTEXT.md) für den aktuellen Arbeitsstand, offene Punkte und inhaltliche Entscheidungen.
