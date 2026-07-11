# Backlog – INA-ePA-und-Patientenportale

## Letzter Stand

**Positionspapier:** Abgeschlossen und eingereicht (2026-07-10, manuell durch die AG außerhalb dieses Repos)
**Projektfokus jetzt:** Tooling — Prozesslandkarte als Multi-User-Web-Tool für weitere Arbeitsgruppen (siehe unten)

---

## Positionspapier – abgeschlossen (2026-07-10)

| ID | Aufgabe | Priorität | Status |
|----|---------|-----------|--------|
| P01 | PR #26 mergen (sobald Review abgeschlossen) | Hoch | ✅ Erledigt (2026-06-19) |
| P02 | Kapitel 1, 2, 4.1, 4.2 vom Plenum einarbeiten (Platzhalter) | Hoch | ⏹ Obsolet — AG hat außerhalb des Repos fertiggestellt |
| P03 | Plenumsentscheidung: Querschnittsthema Patientenberatung als eigenständiger Prozessschritt? | Hoch | ⏹ Obsolet — liegt jetzt beim Plenum, nicht mehr Teil dieses Repos |
| P04 | Bei P03 = Ja: Schritt in `patientenpfad_data.js` ergänzen + Renummerierung | Mittel | ⏹ Obsolet (siehe P03) |
| P05 | Weiteres Feedback-Runden einarbeiten (nächste Reviewer) | Mittel | ⏹ Obsolet — Dokument-Track geschlossen |

**Status-Legende:** 📋 Offen · 🔄 In Bearbeitung · ✅ Erledigt · ⏭ Wartet auf Bedingung · ⏹ Obsolet

---

## Multi-User-Web-Tool – nächste Schritte (ab Session 2026-07-10)

Ziel: Prozesslandkarte (Viewer/Editor/Daten) für weitere Arbeitsgruppen als echtes mehrbenutzerfähiges Web-Tool nutzbar machen, statt GitHub-Pages + PAT-basiertem Editor. Architekturrichtung: selbst gehostet Postgres + PostgREST + GoTrue (entbündelt statt voller Supabase-Stack — gleiche Bausteine, geringerer Betriebsaufwand, kein SaaS-Vendor-Lock-in), generisches Dimensionen-Datenmodell (Phasen/Datenräume/Domänen etc. sind alle Instanzen desselben Mechanismus, keine hart codierten Sonderfälle). Details siehe KONTEXT.md, Abschnitt „Architekturentscheidung: Multi-User-Web-Tool".

**⚠ Harte Randbedingung:** Das bestehende Tool (`patientenpfad_interaktiv.html`, `patientenpfad_editor.html`, `patientenpfad_data.js`) ist im Wirkbetrieb der AG und darf durch die folgenden Aufgaben nicht beeinträchtigt werden. Entwicklung erfolgt additiv (neue Dateien/Verzeichnisse), keine Änderung der produktiven Dateien "in place". Umschaltung erst nach Parallelbetrieb/Validierung (siehe T11).

| ID | Aufgabe | Priorität | Status |
|----|---------|-----------|--------|
| T01 | SQL-Schema-Migration für generisches Datenmodell (workgroups/dimensions/dimension_values/process_steps/memberships) skizzieren | Hoch | 🔄 In Bearbeitung |
| T02 | Postgres + PostgREST + GoTrue selbst hosten (lokal/Docker zum Start; Migration `20260710120000_init_schema.sql` einspielen) | Hoch | ✅ Erledigt (2026-07-11) — `supabase/docker-compose.yml` + `supabase/README.md`, Smoke-Test erfolgreich (Signup/Verify/JWT/RLS über PostgREST) |
| T03 | Heutige `patientenpfad_data.js`/`meta` als Seed-Daten der ersten Workgroup migrieren (Stand zum Migrationszeitpunkt, nicht nur heutiger Commit — AG pflegt in der Zwischenzeit über den bestehenden Editor weiter) | Hoch | ✅ Erledigt (2026-07-11) — `supabase/seed/`, idempotent, liest `patientenpfad_data.js` live ein (erneut lauffähig nach weiterer AG-Pflege) |
| T04 | Neuer, separater Viewer-Prototyp gegen Datenbank statt gegen `patientenpfad_data.js` (eigene Datei/Pfad, `patientenpfad_interaktiv.html` bleibt unangetastet) | Hoch | ✅ Erledigt (2026-07-11) — `viewer-db/index.html`, Login (GoTrue) + Datenabruf (PostgREST) + Kartenlogik, per Headless-Chrome-Screenshots verifiziert |
| T05 | Viewer: Tabs/Filter/Matrix-Achsen dynamisch aus `dimensions` statt hart codiert rendern | Hoch | ✅ Erledigt (2026-07-11) — `viewer-db/index.html`, inkl. generischer Matrix-Ansicht (frei wählbare Achsen), Farben aus `dimension_values.farbe` mit Hash-Fallback |
| T06 | Neuer, separater Editor-Prototyp mit Datenbank-Write + Row-Level-Security (bestehender GitHub-PUT-Editor bleibt parallel nutzbar) | Hoch | ✅ Erledigt (2026-07-11) — `editor-db/index.html` |
| T07 | Editor: Formularfelder dynamisch aus `dimensions` generieren | Mittel | ✅ Erledigt (2026-07-11) — zusammen mit T06 umgesetzt, da neuer Editor von Anfang an dynamisch gebaut wurde |
| T08 | Login-Bildschirm (E-Mail/Magic-Link zuerst) | Hoch | ⏭ Wartet auf T02 |
| T09 | Editor: Verwaltungsoberfläche für neue Dimensionen (statt nur Werte) | Mittel | 📋 Offen |
| T10 | Institutionelles SSO (Kandidat: Microsoft Entra ID) ergänzen | Niedrig | 📋 Offen |
| T11 | Cutover: Bestandstool erst ablösen/umleiten, nachdem neues Tool im Parallelbetrieb validiert ist (Datenabgleich, AG-Freigabe) | Hoch | 📋 Offen |

**Offene Entscheidungen (siehe KONTEXT.md):** Wer hostet langfristig (Nutzer vs. gematik)? Finale SSO-Wahl? Ist ein Git-artiges Audit-/Versionsprotokoll ein hartes Anforderungskriterium?

**Hinweis aus T02:** `workgroups` hat bewusst keine Schreib-Policy — neue Arbeitsgruppen anlegen geht aktuell nur per `service_role`/direktem DB-Zugriff, nicht über PostgREST mit einer Nutzerrolle. Bei T09 (Verwaltungsoberfläche) berücksichtigen (z.B. eigene Admin-Policy oder separater privilegierter Endpunkt).

---

## Inhaltliche Punkte – zurückgestellt (2026-07-10)

Die AG macht inhaltlich nicht weiter (Positionspapier ist eingereicht). Die folgenden Punkte betrafen den Dokument-/Datenpflege-Track und werden nicht mehr aktiv verfolgt, solange der Fokus auf dem Tooling liegt:

| ID | Aufgabe |
|----|---------|
| D01 | Schritte 9–12 (Präklinisch) mit `ist`/`luecke`/`forderungen` befüllen |
| D02 | Schritte 14–25 (Klinisch + Post) mit `ist`/`luecke`/`forderungen` befüllen |
| D03 | `ANLEITUNG_EDITOR.md` weitergeben — wird durch neuen Login-Flow (T08) ohnehin obsolet |
| I01 | Standards prüfen: FHIR, IHE, HL7 – welche erfüllen Anforderungen A1–A3? |
| I02 | Impulse aus dem Ausland: Dänemark, Estland, Niederlande |
| I03 | Pilotprozesse für Proof of Concept definieren |
| I04 | Matrix (Kap. 7 Arbeitsdokument) in Gruppe weiter diskutieren und verfeinern |
| F01 | Soll „Patient beraten und aufklären" als eigenständiger Prozessschritt ins Modell? (Plenum) |

---

## Zurückgestellt

- **Systemebene Kap. 8**: Weitere Ist-Analyse-Beispiele möglich — wartet auf AG-Input
- **Lebenszyklus von Datenobjekten**: Bewusst ausgeklammert — kann später ergänzt werden
- **Migration zu Webserver + JSON**: durch Multi-User-Web-Tool-Vorhaben (siehe oben) ersetzt/überholt
