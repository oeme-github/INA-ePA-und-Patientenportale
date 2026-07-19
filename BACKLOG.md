# Backlog – INA-ePA-und-Patientenportale

## Letzter Stand

**Positionspapier:** Abgeschlossen und eingereicht (2026-07-10, manuell durch die AG außerhalb dieses Repos)
**Projektfokus jetzt:** Tooling — Prozesslandkarte als Multi-User-Web-Tool für weitere Arbeitsgruppen (siehe unten)
**PR #27 gemergt (2026-07-19):** Bündelte Positionspapier-Abschluss + Multi-User-Web-Tool-Prototyp (T01–T09 erledigt, T10/T11 vorbereitet) sowie den vollständigen Viewer-/Editor-Abgleich (V01–V08, E01–E07) — direkt auf `main` per GitHub-UI gemergt (2197dfb)
**Viewer-/Editor-Abgleich (2026-07-19):** Alle 15 Punkte aus dem Abgleich (V01–V08, E01–E07) sind erledigt — `viewer-db`/`editor-db` funktional auf Stand der Bestandstools, inkl. der beiden größeren Punkte E05 (Akkordeon-Layout) und V02/V03 (neue generische Gruppierungs-Ebene `dimension_values.gruppe`). Direkt im Anschluss gemeinsames Live-Testing mit dem Nutzer: V09 (Matrix Cross-Highlighting) und E09/E10 (Dimension-Formular-Bugs) gefunden und behoben, E08 (Drag&Drop für Reihenfolge) als offener Punkt aufgenommen. Details siehe KONTEXT.md.
**PRs #28–#35 gemergt (2026-07-19):** Alle acht aus der Live-Testing-Runde entstandenen PRs geprüft und nach `main` gemergt (Details/Konfliktauflösung siehe KONTEXT.md). Keine offenen PRs mehr. **Nächster Schritt: E08 (Drag&Drop für Reihenfolge)** — Design-Frage offen: `process_steps.nr` hat `unique(workgroup_id, nr)`, Umsortieren muss mehrere Zeilen atomar neu nummerieren; `dimension_values.reihenfolge` hat keinen entsprechenden Constraint, dort einfacher. Umfang laut Nutzer: beide Listen (Prozessschritte + Dimension-Werte).

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
| T01 | SQL-Schema-Migration für generisches Datenmodell (workgroups/dimensions/dimension_values/process_steps/memberships) skizzieren | Hoch | ✅ Erledigt — `supabase/migrations/20260710120000_init_schema.sql`, seit T02 produktiv im Einsatz und in T03–T11 mehrfach erweitert/getestet |
| T02 | Postgres + PostgREST + GoTrue selbst hosten (lokal/Docker zum Start; Migration `20260710120000_init_schema.sql` einspielen) | Hoch | ✅ Erledigt (2026-07-11) — `supabase/docker-compose.yml` + `supabase/README.md`, Smoke-Test erfolgreich (Signup/Verify/JWT/RLS über PostgREST) |
| T03 | Heutige `patientenpfad_data.js`/`meta` als Seed-Daten der ersten Workgroup migrieren (Stand zum Migrationszeitpunkt, nicht nur heutiger Commit — AG pflegt in der Zwischenzeit über den bestehenden Editor weiter) | Hoch | ✅ Erledigt (2026-07-11) — `supabase/seed/`, idempotent, liest `patientenpfad_data.js` live ein (erneut lauffähig nach weiterer AG-Pflege) |
| T04 | Neuer, separater Viewer-Prototyp gegen Datenbank statt gegen `patientenpfad_data.js` (eigene Datei/Pfad, `patientenpfad_interaktiv.html` bleibt unangetastet) | Hoch | ✅ Erledigt (2026-07-11) — `viewer-db/index.html`, Login (GoTrue) + Datenabruf (PostgREST) + Kartenlogik, per Headless-Chrome-Screenshots verifiziert |
| T05 | Viewer: Tabs/Filter/Matrix-Achsen dynamisch aus `dimensions` statt hart codiert rendern | Hoch | ✅ Erledigt (2026-07-11) — `viewer-db/index.html`, inkl. generischer Matrix-Ansicht (frei wählbare Achsen), Farben aus `dimension_values.farbe` mit Hash-Fallback |
| T06 | Neuer, separater Editor-Prototyp mit Datenbank-Write + Row-Level-Security (bestehender GitHub-PUT-Editor bleibt parallel nutzbar) | Hoch | ✅ Erledigt (2026-07-11) — `editor-db/index.html` |
| T07 | Editor: Formularfelder dynamisch aus `dimensions` generieren | Mittel | ✅ Erledigt (2026-07-11) — zusammen mit T06 umgesetzt, da neuer Editor von Anfang an dynamisch gebaut wurde |
| T08 | Login-Bildschirm (E-Mail/Magic-Link zuerst) | Hoch | ✅ Erledigt (2026-07-11) — `shared/auth.js`, von viewer-db und editor-db gemeinsam genutzt, Passwort als Fallback |
| T09 | Editor: Verwaltungsoberfläche für neue Dimensionen (statt nur Werte) | Mittel | ✅ Erledigt (2026-07-11) — neue Ansicht in `editor-db/index.html`: Dimensionen anlegen/bearbeiten/löschen (Rolle `admin`), Werte pro Dimension bearbeiten/löschen (Rolle `editor`+) |
| T10 | Institutionelles SSO (Kandidat: Microsoft Entra ID) ergänzen | Niedrig | 🔄 Scaffolding erledigt (2026-07-11) — GoTrue-Konfiguration + Redirect-Flow in `shared/auth.js` fertig verdrahtet, aber deaktiviert (`ssoAzureEnabled: false`); echte Aktivierung braucht eine App-Registrierung im Entra-ID-Tenant der Organisation (externe Abhängigkeit, siehe supabase/README.md) |
| T11 | Cutover: Bestandstool erst ablösen/umleiten, nachdem neues Tool im Parallelbetrieb validiert ist (Datenabgleich, AG-Freigabe) | Hoch | 🔄 Vorbereitung erledigt (2026-07-11) — `supabase/seed/reconcile_with_data_js.py` (Datenabgleich, getestet) + Cutover-Checkliste (siehe unten); tatsächlicher Cutover erfordert AG-Freigabe, keine technische Einzelentscheidung |

**Offene Entscheidungen (siehe KONTEXT.md):** Wer hostet langfristig (Nutzer vs. gematik)? Finale SSO-Wahl? Ist ein Git-artiges Audit-/Versionsprotokoll ein hartes Anforderungskriterium?

**Hinweis aus T02:** `workgroups` hat bewusst keine Schreib-Policy — neue Arbeitsgruppen anlegen geht aktuell nur per `service_role`/direktem DB-Zugriff, nicht über PostgREST mit einer Nutzerrolle. Bei T09 (Verwaltungsoberfläche) berücksichtigen (z.B. eigene Admin-Policy oder separater privilegierter Endpunkt).

### Cutover-Checkliste (Vorbereitung für T11 — bewusst noch keine Ausführung)

**Wichtig:** Die folgende Checkliste ist Vorbereitung, keine Ausführung. Ein
tatsächlicher Cutover (Bestandstool ablösen/umleiten) ist an die harte
Randbedingung aus KONTEXT.md gebunden ("Diese drei Dateien bleiben
unverändert nutzbar … bis das neue System nachweislich gleichwertig ist")
und erfordert eine Entscheidung/Freigabe der AG, keine technische
Einzelperson-Entscheidung. Diese Liste hilft, wann diese Freigabe sinnvoll
eingeholt werden kann — sie ersetzt sie nicht.

- [ ] **Datenabgleich grün:** `supabase/seed/reconcile_with_data_js.py` läuft ohne Abweichungen (Exit-Code 0) gegen den *aktuellen* Stand von `patientenpfad_data.js` — nicht nur den Stand von T03
- [ ] **Rollenkonzept final:** Wer bekommt welche `memberships`-Rolle (viewer/editor/admin) in der produktiven Workgroup? Wer pflegt das?
- [ ] **Hosting/Betrieb geklärt:** Wer betreibt den Stack langfristig (Nutzer selbst vs. gematik) — siehe offene Entscheidung oben
- [ ] **SSO-Entscheidung:** Reicht E-Mail/Magic-Link zum Start, oder muss institutionelles SSO (T10) vorher stehen?
- [ ] **Audit-/Versionsprotokoll geklärt:** Ist der Git-Commit-Verlauf-Ersatz (`process_step_audit`-Tabelle, aktuell nur angelegt, nicht aktiv genutzt) ausreichend, oder ein hartes Kriterium?
- [ ] **AG-Freigabe eingeholt:** Plenum/Ansprechpartner der AG hat den Parallelbetrieb bewertet und dem Wechsel zugestimmt
- [ ] **Parallelbetriebs-Zeitraum definiert:** Wie lange laufen altes und neues Tool nebeneinander, bevor endgültig umgestellt wird?
- [ ] **Rückfallplan dokumentiert:** Wie kommt die AG zurück zum alten Tool, falls das neue nach dem Umstieg Probleme zeigt?
- [ ] **Kommunikation an die AG:** Wer informiert wann über den Wechsel (neue URL, neuer Login-Weg)?

### Viewer-Abgleich: viewer-db vs. patientenpfad_interaktiv.html (Session 2026-07-11)

Optischer/funktionaler Abgleich zwischen dem Bestands-Viewer und `viewer-db`
(Screenshots nebeneinander, Original vs. dynamisches Rendering aus T05).
Nebenbefund dabei behoben: eine übrig gebliebene Test-Dimension ("Test") und
ein Test-Phasenwert ("test") aus einer früheren Browser-Testsession haben
den Viewer auf 0/25 sichtbare Schritte gebracht — aus der DB gelöscht,
Datenabgleich (`reconcile_with_data_js.py`) läuft wieder grün.

| ID | Aufgabe | Priorität | Status |
|----|---------|-----------|--------|
| V01 | Struktur-Filter ergänzen (klickbare Chips strukturiert/teilstrukturiert/unstrukturiert) | Mittel | ✅ Erledigt (2026-07-19) — reiner Datenfix im Seed-Skript (`struktur`: `single_select`/nicht-navigierend → `multi_select`/`ist_navigationsachse=true`), generischer Toggle-Filter-Mechanismus greift automatisch |
| V02 | Rechtsgrundlage-Filter ergänzen — Original gruppiert 37 Einzelgesetze automatisch in ~13 Kategorien (Regex auf `§`/`Art.`/`Abs.`); Design-Frage, ob generisch nachbaubar oder eigene "Übergruppe"-Dimension nötig | Mittel | ✅ Erledigt (2026-07-19) — neue generische Gruppierungs-Ebene: `dimension_values.gruppe` (Migration), Seed-Skript befüllt Gesetz/Standard einmalig mit den bewährten Original-Regeln, Editor bekommt ein "Gruppe"-Pflegefeld, Viewer einen eigenen Gruppen-Toggle-Filter |
| V03 | Standard-Filter ergänzen — analog zu V02, Original gruppiert per hart codierten `startsWith`-Regeln ("HL7 FHIR", "IHE", "gematik", "Terminologien", "Sonstige") | Mittel | ✅ Erledigt (2026-07-19) — siehe V02, gleicher generischer Mechanismus |
| V04 | Export-Toolbar ergänzen: "Alle aufklappen", PDF/CSV/JSON | Niedrig | ✅ Erledigt (2026-07-19) — CSV/JSON generisch aus `dims` abgeleitet (keine hart codierte Spaltenliste wie im Original), PDF via `window.print()` + neue `@media print`-Regel |
| V05 | Kopfzeile/Breadcrumb ergänzen ("Akteur × Prozess → Datenobjekt · 25 Schritte · 3 Phasen · 4 Datenräume · AK Patientenportale ↗") | Niedrig | ✅ Erledigt (2026-07-11) — dynamisch berechnet (Schritte-/Achsen-Anzahl aus `dims`, Workgroup-Name aus DB), ohne externen Link |
| V06 | Matrix: Zellen sollen Schritt-Titel zeigen (anklickbar, farbcodiert nach Phase) statt nur Zahlen | Mittel | ✅ Erledigt (2026-07-19) — Zelle berechnete das gefilterte Array schon vorher, reduzierte es nur auf `.length`; jetzt klickbare, phasenfarbige Chips (Klick wechselt zur Kartenansicht und öffnet den Schritt) |
| V07 | Suchumfang klären: aktuell durchsucht `viewer-db` alle Felder (auch Ist/Lücke/Forderungen), Original nur Titel/Akteur/Objekt/Detail — gewollt oder angleichen? | Niedrig | ✅ Erledigt (2026-07-19) — erst an Original angeglichen (nur Titel/Akteur/Objekt/Detail), nach Nutzer-Feedback ("DSGVO" fand keinen Treffer) bewusst wieder breiter als das Original: Rechtsgrundlage/Standard zusätzlich durchsucht, Ist/Lücke/Forderungen bleiben ausgeschlossen (PR #29) |
| V08 | Operation-Badge ("E"/"E,V") zusätzlich auf der geschlossenen Karte anzeigen, nicht nur im aufgeklappten Detail | Niedrig | ✅ Erledigt (2026-07-11) — generisch als dritte Multi-Select-Dimension (reihenfolge-basiert) neben Vorschau-Zeile 2 |
| V09 | Matrix: Cross-Highlighting beim Hover fehlt — ein Schritt kann mehrfach in der Matrix auftauchen (mehrere Werte auf X- oder Y-Achse), Original hebt beim Hover alle Vorkommen hervor und dimmt den Rest | Mittel | ✅ Erledigt (2026-07-19) — Event-Delegation auf `#karten` (analog zum Original auf `#matrix-view`), `data-nr`-Attribut pro Chip, `.highlighted`/`.dimmed-by-hover`-Klassen (PR #34) |

### Editor-Abgleich: editor-db vs. patientenpfad_editor.html (Session 2026-07-11)

Usability-Durchgang durch `editor-db` (User-Feedback: "im Moment noch
unübersichtlich"), verglichen mit dem Layout-Prinzip von
`patientenpfad_editor.html`.

| ID | Aufgabe | Priorität | Status |
|----|---------|-----------|--------|
| E01 | **CSS-Bug:** Selektor `.field label` trifft versehentlich auch jedes Checkbox-Label (technisch ebenfalls ein `<label>`) — dadurch stehen aktuell alle Checkbox-Texte in Großbuchstaben (z.B. "DSGVO ART. 6 ABS. 1" statt "DSGVO Art. 6 Abs. 1"), nicht nur die Feld-Überschrift wie beabsichtigt | Hoch | ✅ Erledigt (2026-07-11) — `.field label` → `.field > label` (direkter Kind-Selektor); zusätzlich dieselbe Ausnahme für das "Navigationsachse"-Checkbox-Label in der Dimensionen-Ansicht ergänzt |
| E02 | Große Checkbox-Listen (Datenobjekt: 25, Rechtsgrundlage: 37, Standard: 36 Einträge) laufen flach und unbegrenzt durch — ein Schritt-Formular kommt so auf ~2200px Scrollhöhe. Original steckt diese Listen in feste, scrollbare Boxen (~150px, eigener Scrollbalken). Vermutlich Hauptursache für "unübersichtlich" | Hoch | ✅ Erledigt (2026-07-11) — Schwellwert generisch über Werteanzahl (>10), nicht über Dimension-Key; Formular jetzt ~1985px statt ~2200px, Rechtsgrundlage/Standard scrollen sichtbar in eigener Box |
| E03 | Kein sichtbarer Speichern-Button ohne komplett nach unten zu scrollen (Folge von E02) — sticky/fixierter Speichern-Bereich sinnvoll | Hoch | ✅ Erledigt (2026-07-19) — `.form-actions` ist jetzt eine per `position:sticky` an den Browser-Viewport geklebte Fußzeile (nach E05 überarbeitet, siehe dort) |
| E04 | Sidebar (Schritt-/Dimensionsliste) mit 280px schmal, lange Titel werden abgeschnitten ("Durchführung diagnostischer Maßna…") | Mittel | ✅ Erledigt (2026-07-11) — Sidebar auf 320px verbreitert, Titel brechen jetzt auf bis zu 2 Zeilen um statt abzuschneiden (durch E05 inzwischen ohnehin volle Breite statt fester Sidebar) |
| E05 | Layoutprinzip überdenken: Original nutzt ein Akkordeon (Zeile anklicken → Formular klappt direkt darunter auf, kompaktes 2-spaltiges Grid für kurze Felder), aktuell Liste links + immer sichtbares Formular rechts, einspaltig | Mittel | ✅ Erledigt (2026-07-19) — Sidebar+Panel durch Akkordeon ersetzt (einheitlich für Prozessschritte und Dimensionen); Speichern/Formular-Logik unverändert, nur das Formular-Element wird per JS hinter die aufgeklappte Zeile verschoben |
| E06 | "+ Hinzufügen"-Zeile für neue Werte erscheint bei jedem Feld, auch bei selten erweiterten wie Phase/Struktur — unnötiges visuelles Rauschen | Niedrig | ✅ Erledigt (2026-07-11) — bei Navigations-Dimensionen (Phase, Datenraum) durch Hinweistext auf die Dimensionen-Ansicht ersetzt, Werte-Pflege bleibt dort möglich |
| E07 | Keine Such-/Filterfunktion innerhalb der langen Checkbox-Listen (z.B. 37 Rechtsgrundlagen durchsuchen) | Niedrig | ✅ Erledigt (2026-07-19) — Filtertext-Input für dieselben Felder wie E02 (>10 Werte), blendet nicht passende Checkbox-Zeilen aus |
| E09 | "+ Neu"-Button bei Dimensionen war für Nicht-Admins anklickbar, obwohl neue Dimensionen laut RLS-Policy nur mit der Rolle `admin` angelegt werden können — lief korrekt gegen HTTP 403, aber unnötig | Niedrig | ✅ Erledigt (2026-07-19) — Button wird nach dem Rollen-Check in `startApp()` deaktiviert (`myRole !== 'admin'`), mit Tooltip zur Begründung |
| E10 | Beim Anlegen einer neuen Dimension war die "+ Hinzufügen"-Zeile für Werte schon vor dem Speichern sichtbar/bedienbar, tat aber nichts (kein `currentDimId` vorhanden). Nebenbefunde beim Beheben: die "Gespeichert."-Erfolgsmeldung im Dimension-Formular war faktisch nie sichtbar (wurde vom nachfolgenden Rerender sofort wieder versteckt); Fehlermeldungen fragten immer "Fehlt die Rolle?", auch bei reinen Konflikten (HTTP 409, z.B. doppelte `nr`/doppelter Key) statt Rechteproblemen (HTTP 403) | Mittel | ✅ Erledigt (2026-07-19) — Werte-Eingabe erst nach dem ersten Speichern sichtbar, Erfolgsmeldung wird erst nach dem Rerender gesetzt, neue `httpErrorHint()`-Hilfsfunktion unterscheidet 403/409 |
| E08 | Drag&Drop für Reihenfolge — sowohl Prozessschritte (`nr`) als auch Dimension-Werte (`reihenfolge`) werden aktuell über ein Zahlenfeld sortiert; manuelles Eintippen ist fehleranfällig (Nutzer-Feedback: `nr` doppelt vergeben löst korrekt einen Konflikt aus — `process_steps` hat `unique(workgroup_id, nr)` — aber die Fehlermeldung war ursprünglich irreführend, siehe Fix in PR #31). Design-Frage: Drag&Drop muss beim Umsortieren mehrere Zeilen atomar neu nummerieren (sonst kollidiert die Zwischenzustands-Nummer mit dem Unique-Constraint) — für Dimension-Werte gibt es keinen Unique-Constraint auf `reihenfolge`, dort einfacher. Umfang laut Nutzer: beide Listen (Prozessschritte + Dimension-Werte) | Mittel | 📋 Offen |

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
