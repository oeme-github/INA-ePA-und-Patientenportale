# INA-Arbeitskreis: Patientenpfad & Datenstandards

Arbeitskreis der gematik ([ina.gematik.de](https://ina.gematik.de)) zur Standardisierung des Datenaustauschs zwischen einrichtungsspezifischen Patientenportalen, Primärsystemen (KIS/PVS) und der elektronischen Patientenakte (ePA).

## Leitformel

> **Akteur × Prozess → Datenobjekt**

Kein Element kann ohne die anderen beiden gedacht werden.

---

## Grundprinzipien

1. **Prozess vor Daten vor System** – Systeme sind Werkzeuge, keine Ausgangspunkte
2. **Keine führenden Systeme** – Daten gehören dem Prozess und dem Patienten
3. **Datenobjekte statt Datenflüsse** – Was wird wann von wem erzeugt, verändert oder gelöscht?
4. **Strukturierte Daten vor Dokumenten** – Maschinenlesbarkeit ist das Ziel

---

## Dateien

| Datei | Inhalt |
|---|---|
| `KONTEXT.md` | Aktueller Arbeitsstand, Entscheidungen, offene Punkte – wird jede Session aktualisiert |
| `patientenpfad_arbeitsdokument_v3.md` | Vollständiges Arbeitsdokument (9 Kapitel) |
| `patientenpfad_interaktiv.html` | Interaktive Prozesskarte mit Filter nach Phase und Datenraum |

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

## Aktueller Stand

Siehe [`KONTEXT.md`](KONTEXT.md) für den aktuellen Arbeitsstand, offene Punkte und inhaltliche Entscheidungen.
