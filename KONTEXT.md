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
| `CLAUDE.md` | – | 2026-07-11 | Abschnitt zum Multi-User-Web-Tool (supabase/, viewer-db/, editor-db/, shared/) ergänzt |
| `index.html` | v2 | 2026-04-29 | Startseite mit Viewer- und Editor-Karten |
| `forderungen_praeklinisch.md` | v1 | 2026-05-21 | Neu: Forderungen Präklinisch in drei Varianten |
| `positionspapier.md` | v0.5 | 2026-06-09 | LSR-Feedback (20 Kommentare) + Kap. 4.1/4.2 aus Parallelversion v0.4.1 eingearbeitet |
| `agenda_positionspapier.md` | – | 2026-06-03 | Neu: AG-Dokument konvertiert (Grundlage Kapitelstruktur) |
| `forderungen_ag.md` | – | 2026-06-03 | Neu: AG-Dokument konvertiert (Grundlage Kap. 5) |
| `KONTEXT.md` | – | 2026-07-11 | T02–T11: lokaler Stack, Seed-Migration, Viewer-/Editor-Prototyp, Login, Dimensionen-Verwaltung, SSO-Scaffolding, Datenabgleich |
| `supabase/docker-compose.yml`, `supabase/init-db/`, `supabase/README.md` | v1 | 2026-07-11 | Neu: lokaler Stack (T02) |
| `supabase/seed/` | v1 | 2026-07-11 | Neu: Seed-Migration patientenpfad_data.js → generisches Datenmodell (T03) |
| `viewer-db/index.html` | v2 | 2026-07-11 | Viewer-Prototyp (T04), dynamisch aus dimensions (T05), gemeinsamer Login (T08) |
| `editor-db/index.html` | v3 | 2026-07-11 | Editor-Prototyp (T06+T07), gemeinsamer Login (T08), Dimensionen-Verwaltung (T09) |
| `shared/auth.js` | v2 | 2026-07-11 | Gemeinsamer Login (T08: Magic-Link + Passwort-Fallback; T10: SSO-Scaffolding Entra ID) |
| `supabase/seed/reconcile_with_data_js.py` | v1 | 2026-07-11 | Neu: Datenabgleich DB ↔ patientenpfad_data.js, reiner Lesevergleich (T11) |
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

## Architekturentscheidung: Multi-User-Web-Tool (Session 2026-07-10)

Ziel: Die interaktive Prozesslandkarte (`patientenpfad_interaktiv.html`, `patientenpfad_editor.html`, `patientenpfad_data.js`) soll auch von anderen Arbeitsgruppen genutzt werden können — als echtes mehrbenutzerfähiges Web-Tool statt der heutigen GitHub-Pages-Lösung (Viewer lädt eine statische JS-Datei, Editor schreibt per GitHub-REST-API mit persönlichem Access-Token zurück ins Repo).

**Anforderungen laut Nutzer:**
- Mehrbenutzerfähig, über das Web nutzbar (kein Fork/Kopie pro AG)
- Authentifizierung statt PAT-Copy-Paste — Kandidaten: E-Mail/Magic-Link (Einstieg) und institutionelles SSO, plausibel Microsoft Entra ID (gematik nutzt SharePoint/M365)
- Hosting-Träger noch offen (evtl. gematik langfristig, evtl. weiter der Nutzer selbst) — Architektur darf sich nicht darauf festlegen
- **Erweiterbarkeit ist eines der zentralen Entwurfsziele, auch strukturell**: Andere AGs sollen nicht nur neue Domänen/Werte ergänzen können, sondern perspektivisch auch eigene Phasenanzahl/-namen oder eigene Datenraum-Achsen definieren — ohne Codeänderung

**Harte Randbedingung: Das bestehende Tool ist im Wirkbetrieb (Session 2026-07-10)**
`patientenpfad_interaktiv.html`, `patientenpfad_editor.html` und `patientenpfad_data.js` werden aktiv von der AG genutzt und dürfen durch die Weiterentwicklung nicht beeinträchtigt werden. Konsequenzen für die Umsetzung:
- Diese drei Dateien bleiben unverändert nutzbar (GitHub Pages + PAT-Editor-Flow), bis das neue System nachweislich gleichwertig ist — kein Umbau "in place".
- Das neue Multi-User-Tool wird additiv entwickelt (neue Dateien/Verzeichnisse wie `supabase/`, perspektivisch ein eigenes Frontend), nicht durch Modifikation der produktiven Dateien.
- Umschaltung (Cutover) erst nach Parallelbetrieb/Validierung, mit Rückfalloption auf das bestehende Tool.
- Datenpflege der AG läuft in der Zwischenzeit normal über den heutigen Editor weiter — die künftige Migration (T03) muss auch nachträglich gepflegte Schritte erfassen, nicht nur den heutigen Stand von `patientenpfad_data.js`.

**Gewählte Richtung:** Backend-as-a-Service auf Postgres-Basis statt Eigenentwicklung von Auth/Backend-Server. Begründet durch: echte Mehrbenutzerfähigkeit + Rollen, eingebaute Auth mit E-Mail/Magic-Link UND späterer Enterprise-SSO-Option, Row-Level-Security für Rollen pro Arbeitsgruppe, selbst hostbar (Open Source) falls gematik später eigene Infrastruktur nutzen will, kein Vendor-Lock-in.

Verworfen: (a) weiter Git-basiert nur mit OAuth statt PAT — löst die technische Hürde für nicht-technische AG-Mitglieder nicht und bringt keine echten Rollen; (b) volles Custom-Backend — mehr Aufwand für Funktionen, die eine BaaS-Lösung fertig mitbringt, passt nicht zum unklaren Hosting-/Budgetrahmen.

**Nachtrag (Session 2026-07-11) — entbündelt statt volles Supabase:** Nach Diskussion zu Lizenz (EUPL 1.2, siehe unten) und Abhängigkeits-Minimierung wurde die ursprüngliche Referenz "Supabase" präzisiert: statt des vollen Supabase-Stacks (inkl. Kong, Realtime, Storage, Studio, imgproxy — ca. 8 Docker-Services) werden nur die drei tatsächlich benötigten Bausteine selbst gehostet: **Postgres + PostgREST + GoTrue**. Das sind exakt die Komponenten, aus denen Supabase selbst besteht; das bereits entworfene Schema inkl. RLS-Policies und der `auth.users`/`auth.uid()`-Konvention bleibt dadurch unverändert gültig. Kein Admin-UI (Supabase Studio) — unkritisch, da Editor/Dimensionsverwaltung (T06/T09) ohnehin selbst gebaut werden.

Lizenzprüfung EUPL 1.2: kein Konflikt. Nutzung von Postgres/PostgREST/GoTrue (alle MIT- bzw. Apache-2.0-lizenziert) als externe Dienste über HTTP/API ist unabhängig von der Lizenz der eigenen Codebasis — Copyleft-Pflichten entstehen nur bei Verbreitung eines Derivative Work mit eingebettetem Fremdcode, nicht bei Servicenutzung. Die Entscheidung für den entbündelten Stack ist daher primär durch Abhängigkeits-/Betriebsaufwand motiviert, nicht durch Lizenzrecht.

Verworfen (Nachtrag): (c) Supabase Cloud (gehostet) — SaaS-Vendor-Abhängigkeit, passt nicht zur offenen Hosting-Frage; (d) voller Supabase-Stack selbst gehostet — zu hoher Betriebsaufwand (~8 Services) für das, was tatsächlich gebraucht wird; (e) PocketBase — geringster Betriebsaufwand (ein Binary), aber SQLite statt Postgres und würde das bereits entworfene Schema/RLS verwerfen.

**Datenmodell — generische mehrdimensionale Prozesskatalog-Engine:** Weil Erweiterbarkeit auch strukturell gelten soll, werden Phasen und Datenräume keine Sonderfälle mehr, sondern Instanzen desselben generischen Mechanismus wie Domänen/Akteure/Rechtsgrundlagen:
- `workgroups` — eine Zeile pro Arbeitsgruppe/Mandant
- `dimensions` — pro Workgroup: jede Kategorie/Achse (inkl. „Phase" und „Datenraum" selbst), mit Typ (Single-/Multi-Select/Freitext), Flag `ist_navigationsachse`, Reihenfolge, Farbe
- `dimension_values` — Werte innerhalb einer Dimension (heutige Auswahllisten + heutige Phasen-/Datenraum-Werte)
- `process_steps` — minimale Kernspalten (`nr`, `titel`, Freitext) + Zuordnung zu Dimension-Werten
- `memberships` — `user_id × workgroup_id × Rolle (viewer/editor/admin)`

Migration: heutige `patientenpfad_data.js` wird zu Seed-Daten der ersten Workgroup, `meta` wird zu den ersten `dimensions`/`dimension_values` — kein inhaltlicher Verlust.

**Phasierung:**
1. Generisches Datenmodell steht, heutige AG als erste Workgroup 1:1 abgebildet (keine Regression)
2. Viewer/Editor rendern Tabs/Filter/Formulare/Matrix-Achsen dynamisch aus `dimensions` statt hart codiert
3. Editor bekommt eine Verwaltungsoberfläche, mit der eine AG selbst neue Dimensionen anlegt

**Offene Punkte:**
- Wer hostet/betreibt langfristig (Nutzer selbst vs. gematik)
- Finale Wahl des SSO-Providers/-Protokolls
- Ob ein Git-artiges Audit-/Versionsprotokoll (heute „gratis" durch Commits) ein hartes Anforderungskriterium ist — vor der Datenmodell-Umsetzung klären
- Vollständiger Plan liegt unter `/home/oeme/.claude/plans/transient-finding-cat.md` (lokale Planungsdatei, nicht im Repo)

### T02 abgeschlossen: lokaler Stack läuft (Session 2026-07-11)

`supabase/docker-compose.yml` (Postgres 16, PostgREST v12.2.3, GoTrue v2.167.0, Mailpit für lokale Bestätigungs-/Magic-Link-Mails) + `supabase/init-db/` (Rollen `anon`/`authenticated`/`service_role`/`authenticator`, Schema `auth` + eigene Rolle `supabase_auth_admin` dafür) + `supabase/README.md`. Migration `20260710120000_init_schema.sql` erfolgreich eingespielt. Details, Stolpersteine und Startreihenfolge stehen in `supabase/README.md` — wichtigste Erkenntnis: `auth.uid()`/`auth.role()`/`auth.email()`/`auth.jwt()` werden von GoTrue selbst angelegt (nicht vorab definieren!), und PostgREST braucht `PGRST_DB_USE_LEGACY_GUCS=false`, damit das zusammenpasst.

Smoke-Test erfolgreich: Signup → Bestätigungsmail in Mailpit → `/verify` → JWT (`role: authenticated`) → PostgREST: anonym leer, authenticated ohne Membership leer, `viewer` liest, `editor` schreibt (`POST /process_steps` → 201). Testdaten danach wieder gelöscht, DB ist leer und bereit für T03 (Seed-Migration der heutigen `patientenpfad_data.js`).

Offen aus T02: `workgroups` hat bewusst keine Schreib-Policy (nur service_role kann neue Arbeitsgruppen anlegen) — bei T09 berücksichtigen.

### T03 abgeschlossen: patientenpfad_data.js als Seed migriert (Session 2026-07-11)

`supabase/seed/extract_data_js.mjs` liest `patientenpfad_data.js` per Node
`vm`-Modul live ein (keine eigene Kopie der Inhalte), `seed_ak_patientenportale.py`
spielt daraus idempotent die Workgroup `ak-patientenportale` ein: 13 Dimensionen
(`phase`, `datenraum`, `domaene`, `akteur`, `objekt`, `operation`, `gesetz`,
`standard`, `struktur`, plus die vier Freitextfelder `detail`/`ist`/`luecke`/
`forderungen` als eigene Text-Dimensionen), 133 Dimension-Werte, 25
Prozessschritte, 479 Prozessschritt-Werte. Stichprobe (Schritt 3) 1:1 gegen
`patientenpfad_data.js` verifiziert; zweiter Lauf des Skripts erzeugt exakt
dieselben Zeilenzahlen (Idempotenz bestätigt).

Nebenbefund: Schritt 3 referenziert den Standard „HL7 FHIR R4 (Patient)",
der in `meta.standards` fehlt (vermutlich ein Pflegefehler im bestehenden
Editor). Das Seed-Skript verwirft solche Fälle nicht, sondern ergänzt sie
automatisch als zusätzlichen Dimension-Wert (mit Hinweis auf stderr) — kein
inhaltlicher Verlust, aber ein Hinweis, dass `meta.standards` in
`patientenpfad_data.js` bei Gelegenheit im bestehenden Editor nachgezogen
werden könnte.

Da die AG weiterhin über den bestehenden Editor an `patientenpfad_data.js`
arbeitet, ist das Skript bewusst erneut lauffähig — vor dem eigentlichen
Cutover (T11) muss es noch einmal gegen den dann aktuellen Stand laufen.

### T04 abgeschlossen: Viewer-Prototyp gegen die Datenbank (Session 2026-07-11)

`viewer-db/index.html` — neue, eigenständige Datei (keine Änderung an
`patientenpfad_interaktiv.html`). Optik/Filterlogik/Kartenaufbau bewusst am
bestehenden Viewer orientiert (CSS-Klassen, Phase-Tabs, Datenraum-Toggles,
Suche mit Highlighting, Detail-Aufklappen), aber Datenquelle ist jetzt
`fetch()` gegen PostgREST statt `<script src="patientenpfad_data.js">`.

Zusätzlich nötig: ein Login-Bildschirm (E-Mail/Passwort gegen GoTrue,
`/token?grant_type=password`), da RLS ohne gültiges JWT + Mitgliedschaft
alle Zeilen ausblendet. Das ist noch nicht T08 (der eigentliche
Login-Bildschirm mit Magic-Link, Passwort-Reset etc.), sondern die minimale
Authentifizierung, die der Prototyp braucht, um überhaupt Daten zu sehen —
T08 wird das später ersetzen/ausbauen.

Transformation: `process_steps` wird mit eingebetteten
`process_step_values(dimensions(key), dimension_values(key,label))` per
PostgREST-Resource-Embedding in einem Request geladen und im Browser zu
einem Objekt pro Prozessschritt zusammengefasst (gruppiert nach
`dimensions.key`) — funktional identisch zum alten `data`-Array aus
`patientenpfad_data.js`.

Getestet per Headless-Chrome (CDP, Screenshots): Login, alle 25
Prozessschritte/3 Phasen, Karten-Detail, Freitextsuche mit Highlighting,
Datenraum-Filter (Dimmen), Logout, Fehlermeldung bei falschem Passwort.
Demo-Zugang (`demo@prozesslandkarte.local`, viewer-Rolle in
`ak-patientenportale`) dokumentiert in `supabase/README.md`.

Nebenbefund beim Testen: `GOTRUE_JWT_DEFAULT_GROUP_NAME` ist in dieser
GoTrue-Version wirkungslos (reines Deprecation-Log) — ohne den
Spalten-Default `auth.users.role = 'authenticated'` (den das volle
supabase/postgres-Image mitbringt, wir aber nicht nutzen) bekommen neue
Nutzer ein JWT mit `role:""`, und PostgREST kann nicht per `SET ROLE`
wechseln. Behoben über `supabase/post-auth-init.sql` (bereits committed).

### T05 abgeschlossen: Viewer dynamisch aus dimensions (Session 2026-07-11)

`viewer-db/index.html` rendert jetzt nichts mehr hart codiert. Ableitung aus
den geladenen `dimensions` (siehe `setupDimensions()`):
- Navigations-Dimensionen (`ist_navigationsachse=true`): `single_select` →
  Tab-Leiste (wie bisher „Phase") + Sektionsgruppierung; `multi_select` →
  Toggle-Filter (wie bisher „Datenraum"). Beliebig viele/wenige möglich, nicht
  auf genau 2 festgelegt.
- Alle anderen Auswahl-Dimensionen: die ersten zwei `multi_select` erscheinen
  kompakt auf der Karte (Vorschau), alle `single_select` als Kopf-Chips, der
  Rest (weitere `multi_select` + alle `text`-Dimensionen) nur in der
  aufgeklappten Detailansicht — generische Regel über `reihenfolge`, nicht
  über Feldnamen.
- Farben: `dimension_values.farbe` (ein Akzent-Hex) wird per `chipStyle()` zu
  Hintergrund/Text/Rand aufgehellt/abgedunkelt; fehlt `farbe`, greift ein
  deterministischer Hash auf eine Fallback-Palette. `phase`/`datenraum`/
  `struktur` bekommen im Seed-Skript jetzt explizit die bisherigen Hex-Werte,
  damit die Optik gegenüber dem alten Viewer erhalten bleibt.
- Matrix-Ansicht neu (Toggle „Karten"/„Matrix"): zwei frei wählbare
  Dimensionen als Achsen (Dropdowns), Zellen zählen Prozessschritte mit
  beiden Werten — ersetzt die bisherige fest verdrahtete Domäne×Datenraum-
  Matrix durch eine generische Variante.

Per Headless-Chrome verifiziert: Tabs/Filter/Farben/Kartenlayout sehen dem
Ist-Zustand sehr ähnlich (bewusst kein pixelgenauer Nachbau, da eine
generische Regel niemals 1:1 eine hart codierte Sonderbehandlung treffen
kann), Suche inkl. Highlighting über alle Dimensionen, Datenraum-Filter
(Dimmen), Matrix-Ansicht (Domäne × Datenraum als Default-Achsen) — alles
funktional bestätigt.

`seed_ak_patientenportale.py` erweitert: `dimension_values`-Farbe ist jetzt
optional als drittes Tupel-Element pro Wert angebbar.

### T06+T07 abgeschlossen: Editor-Prototyp, Formularfelder dynamisch (Session 2026-07-11)

`editor-db/index.html` — neue, eigenständige Datei (bestehender
`patientenpfad_editor.html` bleibt unangetastet). T06 und T07 wurden
zusammengelegt: da der Editor ohnehin neu gebaut wird, ergab ein zunächst
hart codiertes Formular (T06) mit anschließender Umstellung auf dynamische
Felder (T07) keinen Mehrwert gegenüber direkt dynamischem Aufbau.

Struktur: Seitenliste aller Prozessschritte (`nr`+`titel`) + Formular pro
Schritt, Felder generisch aus `dimensions` erzeugt (`single_select` → Select,
`multi_select` → Checkbox-Liste, `text` → Textarea). Neue Werte lassen sich
inline pro Dimension ergänzen (analog zur Meta-Verwaltung im bestehenden
Editor), landen sofort nutzbar in der Werteliste. Speichern: `process_steps`
per PATCH/POST, `process_step_values` pro Dimension per volles
Delete-and-Reinsert (wie schon im Seed-Skript) — abgesichert einzig durch
PostgREST + RLS, kein serverseitiger Sonderweg.

Zwei echte Bugs beim Testen gefunden und behoben (nicht nur kosmetisch):
- **`addDimensionValue` rief zuerst `renderForm()` (kompletter Neuaufbau des
  Formulars von Server-Daten) auf** — das hat jede unsaved Änderung in
  anderen Feldern (inkl. Titel) weggeworfen, sobald man einen neuen Wert
  ergänzt hat. Fix: nur das betroffene Feld wird per DOM-Patch aktualisiert
  (`addOptionToField`), der Rest des Formulars bleibt unangetastet.
- **`GOTRUE_JWT_DEFAULT_GROUP_NAME` ist wirkungslos UND der Spalten-Default
  auf `auth.users.role` reicht nicht** — GoTrue schreibt bei jedem Signup
  explizit `role=''` (nicht NULL, nicht weggelassen), ein Spalten-Default
  greift aber nur, wenn die Spalte in der INSERT-Anweisung fehlt. Ein zweiter,
  nach dem ersten (T02-)Fix neu angelegter Nutzer hatte deshalb wieder
  `role:""`. Behoben durch einen `before insert`-Trigger auf `auth.users` in
  `post-auth-init.sql`, der leere Rollen auf `authenticated` korrigiert —
  robuster als der reine Spalten-Default.

Getestet per Headless-Chrome: Login als `editor`, Formularfelder korrekt
vorbefüllt (Stichprobe Schritt 1 1:1 gegen Datenbank), Titel ändern + neuen
Domänen-Wert ergänzen + Speichern (Änderung persistiert, Sidebar aktualisiert
sich), RLS-Grenzfall mit `viewer`-Rolle (Speichern schlägt kontrolliert fehl,
klare Fehlermeldung, DB bleibt unverändert), neuen Schritt anlegen (nr
korrekt vorgeschlagen) und wieder löschen. Test-Zugang
`editor@prozesslandkarte.local` / `editor-passwort-123` (Rolle `editor` in
`ak-patientenportale`) zusätzlich zum bestehenden `demo@…`-Viewer-Zugang.

### T08 abgeschlossen: gemeinsamer Login-Bildschirm mit Magic-Link zuerst (Session 2026-07-11)

`shared/auth.js` — von `viewer-db/index.html` und `editor-db/index.html`
gemeinsam per `<script src="../shared/auth.js">` eingebunden (klassisches
Script, keine Module — Reihenfolge der `<script>`-Tags ist deshalb
unkritisch, da `GOTRUE_URL` erst zur Laufzeit der aufgerufenen Funktionen
existieren muss, nicht beim Parsen). `initLoginScreen({title, hint,
onSuccess})` baut den kompletten Login-Bildschirm einmalig ins DOM:

- **Magic-Link zuerst** (E-Mail-Feld → „Magic-Link senden" → GoTrue `/otp`
  mit `create_user:false`) — passend zur Architekturentscheidung
  (E-Mail/Magic-Link als Einstieg). Der Nutzer trägt den 6-stelligen Code aus
  der E-Mail ein (`/verify` mit `type:'magiclink'`) statt auf einen Link zu
  klicken — robuster als der Redirect-Link, da dessen `redirect_to` von
  `GOTRUE_SITE_URL` abhängt, was nicht pro Umgebung/Port (viewer-db vs.
  editor-db, unterschiedliche lokale Ports) konfiguriert ist. Ein Bonus-Pfad
  (`tryConsumeUrlHashToken()`) verarbeitet trotzdem `#access_token=...` im
  URL-Hash, falls der Link zufällig passt.
- **Passwort als Fallback** in einem eingeklappten `<details>` — für
  Test-/Demo-Zugänge (`demo@…`, `editor@…`) weiterhin nutzbar, ohne dass
  Magic-Link für automatisierte Tests jedes Mal eine E-Mail-Runde braucht.

Getestet per Headless-Chrome (persistenter Chrome-Tab über zwei
Skript-Aufrufe hinweg, da der Bestätigungscode zwischen „Senden" und
„Bestätigen" per Mailpit-API aus dem Test-Skript geholt wird — die
Mailpit-Weboberfläche selbst lässt sich aus der App heraus nicht per
`fetch()` auslesen, ihre CSP blockt Cross-Origin-Requests bewusst, das ist
kein App-Bug): kompletter Magic-Link-Flow (senden → Code aus Mailpit →
bestätigen → eingeloggt) für `viewer-db` und `editor-db`, Passwort-Fallback
über das `<details>`-Element, Rollen-Badge korrekt.

Nebenbefund: GoTrues `/otp`-Rate-Limit (60s pro E-Mail-Adresse) hat beim
Testen mehrfach zugeschlagen, weil manuelle `curl`-Prüfungen zwischendurch
den Cooldown immer wieder neu gestartet haben — kein Bug, nur beim Testen
zu beachten (nicht mehrfach kurz hintereinander für dieselbe Adresse
anfragen).

### T09 abgeschlossen: Dimensionen-Verwaltung im Editor (Session 2026-07-11)

`editor-db/index.html` bekommt eine zweite Ansicht (Umschalter „Prozess­
schritte"/„Dimensionen" in der Sidebar): Dimensionen anlegen (Key/Label/Typ/
Reihenfolge/Farbe/Navigationsachse-Flag), bearbeiten, löschen; Werte
innerhalb einer Dimension bearbeiten (Label/Farbe/Reihenfolge) und löschen,
nicht mehr nur ergänzen wie zuvor im Prozessschritt-Formular. RLS-Konsequenz
sichtbar gemacht: Dimensionen anlegen/ändern/löschen erfordert laut Schema
die Rolle `admin` (`"Admins verwalten Dimensionen"`-Policy), während Werte
innerhalb bestehender Dimensionen weiterhin mit `editor` gepflegt werden
können (`"Editoren pflegen Dimension-Werte"`) — das war schon immer so im
Schema angelegt, wird jetzt durch eine echte UI sichtbar.

Beim Testen ein zweites Mal auf denselben GoTrue-Rollen-Bug gestoßen wie in
T06/T08, diesmal in einer schlimmeren Ausprägung: ein frisch signup'ter
Nutzer hatte **direkt nach `/signup`** (vor jedem `/verify`) schon wieder
`role:''` in der DB, obwohl der `before insert`-Trigger aus T06 nachweislich
korrekt feuert (mit einer rohen `INSERT`-Anweisung manuell verifiziert).
Ursache: GoTrue schreibt den Nutzer offenbar nicht nur einmal per `INSERT`,
sondern überschreibt ihn im selben Signup/Verify-Ablauf mindestens noch
einmal per `UPDATE` — vermutlich mit einem in Go noch leeren Rollen-Feld aus
dem Moment der Objekterzeugung, nicht dem per Trigger korrigierten
DB-Wert. Ein `BEFORE INSERT`-Trigger greift bei einem `UPDATE` nicht.
**Endgültiger Fix:** `post-auth-init.sql`s Trigger auf `before insert or
update` erweitert — seitdem bekommen alle drei Test-Nutzer (`demo@`,
`editor@`, `admin@`) zuverlässig `role: 'authenticated'`, auch bei
wiederholten Neuanlagen zum Testen.

Getestet per Headless-Chrome mit neuem `admin@prozesslandkarte.local`-Zugang
(Rolle `admin` in `ak-patientenportale`): alle 13 bestehenden Dimensionen
korrekt gelistet (Typ-/Nav-Badges), neue Dimension „Priorität" angelegt
(inkl. automatisch vorgeschlagener nächster `reihenfolge`), neuer Wert
„Hoch" ergänzt und im Prozessschritt-Formular sofort als zusätzliches Feld
sichtbar, RLS-Grenzfall mit `editor`-Rolle (Dimension anlegen schlägt mit
HTTP 403 fehl, DB unverändert), Dimension wieder gelöscht — Datenabgleich
(`reconcile_with_data_js.py`, siehe T11) bestätigt hinterher wieder exakt
25/25 identische Prozessschritte.

### T10: SSO-Scaffolding für Microsoft Entra ID (Session 2026-07-11)

GoTrue unterstützt Entra ID als OAuth-Provider bereits fertig — es fehlt nur
eine echte App-Registrierung im Entra-ID-Tenant der Organisation (Client-ID/
-Secret, Redirect-URI), die ich als lokaler Dev-Prototyp nicht besitze und
nicht selbst anlegen kann (das ist keine technische Lücke, sondern eine
organisatorische Abhängigkeit vom Azure-AD-Tenant der gematik/des
Krankenhauses). Deshalb bewusst nur Scaffolding statt eines vollständigen
Features:
- `supabase/docker-compose.yml`: `GOTRUE_EXTERNAL_AZURE_*`-Variablen (aus
  `SSO_AZURE_*` in `.env`, Default: deaktiviert/leer).
- `shared/auth.js`: `signInWithAzure()` verdrahtet den Redirect-Flow
  (`/authorize?provider=azure` → Microsoft-Login → zurück mit
  `#access_token` im Hash), nutzt denselben `tryConsumeUrlHashToken()`-Pfad
  wie der Magic-Link-Bonusweg aus T08. `initLoginScreen()` bekommt einen
  neuen `ssoAzureEnabled`-Schalter (Default `false`) — ohne echte
  Credentials bleibt der Button ausgeblendet statt kaputt anklickbar zu
  sein.
- Aktivierungsschritte für später in `supabase/README.md` dokumentiert.

Nicht möglich ohne externen Input: eine echte Entra-ID-App-Registrierung zu
testen. Dieser Teil bleibt offen, bis die Organisation das selbst einrichtet.

### T11: Datenabgleich-Skript + Cutover-Checkliste (Session 2026-07-11)

`supabase/seed/reconcile_with_data_js.py` — reiner Lesevergleich (keine
Schreiboperation), prüft die DB-Workgroup `ak-patientenportale` Feld für
Feld gegen den *aktuellen* Stand von `patientenpfad_data.js` (nicht nur den
T03-Migrationsstand): Titel, alle Multi-/Single-Select-Dimensionen, alle
Textfelder, plus fehlende/zusätzliche Prozessschritte. Exit-Code 0 bei
Übereinstimmung, 1 bei Abweichungen. Getestet: lief zunächst grün (25/25
identisch), dann mit einer bewusst eingefügten Abweichung (Titel manuell in
der DB verändert) — Skript hat die Abweichung korrekt erkannt und
gemeldet — dann zurückgesetzt und erneut grün bestätigt.

Cutover-Checkliste als neuer Abschnitt in BACKLOG.md ergänzt (Datenabgleich,
Rollenkonzept, Hosting, SSO-Entscheidung, Audit-Protokoll, AG-Freigabe,
Parallelbetriebs-Zeitraum, Rückfallplan, Kommunikation).

**Bewusst nicht getan:** kein tatsächlicher Cutover. Die harte Randbedingung
aus dieser Datei ("Diese drei Dateien bleiben unverändert nutzbar … bis das
neue System nachweislich gleichwertig ist") gilt unverändert — ein Wechsel
ist eine AG-Entscheidung, keine technische Einzelaufgabe, die sich im
Vorbeigehen erledigen lässt. `patientenpfad_interaktiv.html`,
`patientenpfad_editor.html` und `patientenpfad_data.js` wurden auch in
dieser Session an keiner Stelle verändert.

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
| Positionspapier: LSR-Feedback (20 Kommentare aus v0.3-DOCX) einarbeiten | Claude | Erledigt (2026-06-09) – PR #26 aktualisiert |
| Positionspapier: Zusammenführung mit v0.4.1 (Ralf) – Kap. 4.1 + 4.2 | Claude | Erledigt (2026-06-09) – PR #26 aktualisiert, v0.5 |

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

### Positionspapier abgeschlossen (Session 2026-07-10)
Das Positionspapier wurde von der AG manuell (außerhalb dieses Repos) überarbeitet und am 2026-07-10 beim Plenum eingereicht. Der Dokument-Track ist damit abgeschlossen — `positionspapier.md` in diesem Repo (Stand v0.5, 2026-06-09) wird nicht mehr mit der eingereichten Fassung abgeglichen, offene Punkte wie Kap. 1/2-Platzhalter oder die Datenhoheits-Frage (Kap. 4.1.2 ↔ 5.1) werden nicht weiterverfolgt, sofern nicht explizit neu aufgegriffen. Der Projektfokus liegt ab jetzt vollständig auf dem Tooling (Prozesslandkarte).

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

### Im Dokument, Inhaltlich, Offene Plenumsentscheidung — geschlossen (2026-07-10)
Die folgenden drei Abschnitte betrafen den Dokument-Track des Positionspapiers und werden nicht weiterverfolgt, da die AG das Papier manuell außerhalb dieses Repos fertiggestellt und eingereicht hat (siehe „Positionspapier abgeschlossen" oben). Als historisches Protokoll belassen:

- **Im Dokument:** Systemebene (Kap. 8) weitere Ist-Analyse-Beispiele; Lebenszyklus von Datenobjekten bewusst ausgeklammert; Matrix (Kap. 7) zur weiteren Diskussion vorgesehen
- **Inhaltlich:** Standards-Prüfung FHIR/IHE/HL7 gegen A1-A3; internationale Impulse (Dänemark, Estland, Niederlande) — teilweise bereits in Kap. 4.2 der eingereichten Fassung eingeflossen; Pilotprozesse für Proof of Concept
- **Offene Plenumsentscheidung Querschnittsthema Patientenberatung:** Ob „Patient beraten und aufklären" als eigenständiger Prozessschritt ins Modell soll — Entscheidung liegt beim Plenum, nicht mehr Gegenstand dieses Repos

---

## Technische Hinweise (für Claude Code)

- Daten liegen in `patientenpfad_data.js` — nicht in der HTML-Datei
- `meta`-Objekt enthält pflegbare Auswahllisten: `domaenen`, `akteure`, `datenobjekte`, `rechtsgrundlagen`
- `data`-Array: 25 Einträge mit `nr`, `phase`, `titel`, `akteur[]`, `objekt[]`, `op`, `dr[]`, `domäne`, `gesetze[]`, `detail`
- Die vier Datenräume sind: `portal`, `versorgung`, `epa`, `ehds`
- Viewer und Editor laden `patientenpfad_data.js` per `<script src="...">`
- Suche im Viewer: kombiniert mit allen Filtern, Highlighting via `<mark>`-Tags
