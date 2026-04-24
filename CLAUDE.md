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

1. Neue Entscheidungen und offene Punkte in `KONTEXT.md` eintragen
2. Alle Änderungen committen (Deutsch, Format: `Bereich: Was und warum`)
3. Branch pushen
4. Pull Request erstellen, falls noch nicht vorhanden
5. User informieren: Was liegt auf GitHub, was ist noch offen?

---

## Git-Workflow

- Nie direkt in `main` pushen
- Feature-Branches: `feature/thema`, `fix/thema`
- Ein Commit pro sinnvoller Arbeitseinheit
- Commit-Format: `Bereich: Was und warum`

Siehe README.md für vollständige Team-Konventionen.

---

## Projektprinzipien

Die vier Grundprinzipien (siehe README.md) gelten auch für technische Entscheidungen:
- Prozess vor Daten vor System
- Keine führenden Systeme
- Datenobjekte statt Datenflüsse
- Strukturierte Daten vor Dokumenten

---

## HTML-Widget (`patientenpfad_interaktiv.html`)

- Alle 25 Prozessschritte leben im `data`-Array — keine externe Datenquelle
- Jeder Eintrag hat: `phase`, `titel`, `akteur`, `objekt`, `op`, `dr`, `detail`
- `sendPrompt()` ist ein Claude.ai-Platzhalter — nicht in Claude Code verwenden
- Keine externen Abhängigkeiten (kein npm, kein CDN) einführen

---

## Allgemeine Regeln

- `KONTEXT.md` ist die primäre Informationsquelle zu Beginn jeder Session
- Keine neuen Dateien ohne expliziten Auftrag
- Änderungen am Arbeitsdokument immer mit dem User abstimmen, bevor umgesetzt wird
