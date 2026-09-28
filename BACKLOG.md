# Backlog – INA-ePA-und-Patientenportale

Enthält nur offene Punkte. Erledigte/verworfene Punkte stehen in `CHANGELOG.md`, ausführliche
Entscheidungen in `KONTEXT.md`.

## Letzter Stand

**Positionspapier:** abgeschlossen, eingereicht (2026-07-10) und auf der gematik-Seite
veröffentlicht — die aktive AG-Arbeitsphase ist beendet.
**Multi-User-Web-Tool:** Prototyp T01–T14 erledigt, Code seit PR #57 (2026-09-04 gemergt) in
[open-starcore](https://github.com/oeme-github/open-starcore) — Tool-Aufgaben gehören dorthin.
Hier verbleibt nur `tools/prozesslandkarte-sync/` (Datenabgleich).
**Cutover-Checkliste:** vollständig abgehakt (2026-09-04), kein tatsächlicher Cutover geplant —
`patientenpfad_interaktiv.html`/`patientenpfad_editor.html`/`patientenpfad_data.js` bleiben
unverändert im Betrieb (GitHub Pages). Vor einem etwaigen späteren Cutover:
`reconcile_with_data_js.py` erneut laufen lassen.

**Status-Legende:** 📋 Offen · 🔄 In Bearbeitung · ⏭ Wartet auf Bedingung

---

## Inhaltliche Punkte – zurückgestellt (seit 2026-07-10)

Die AG arbeitet inhaltlich nicht weiter. Die Punkte werden nicht aktiv verfolgt, bleiben aber
festgehalten, falls die Arbeit wieder aufgenommen wird.

| ID | Aufgabe | Status |
|----|---------|--------|
| INA-ePA-und-Patientenportale_D01 | Schritte 9–12 (Präklinisch) mit `ist`/`luecke`/`forderungen` befüllen | ⏭ Wartet auf AG |
| INA-ePA-und-Patientenportale_D02 | Schritte 14–25 (Klinisch + Post) mit `ist`/`luecke`/`forderungen` befüllen | ⏭ Wartet auf AG |
| INA-ePA-und-Patientenportale_I01 | Standards prüfen: FHIR, IHE, HL7 — welche erfüllen die Anforderungen A1–A3? | ⏭ Wartet auf AG |
| INA-ePA-und-Patientenportale_I02 | Impulse aus dem Ausland: Dänemark, Estland, Niederlande | ⏭ Wartet auf AG |
| INA-ePA-und-Patientenportale_I03 | Pilotprozesse für Proof of Concept definieren | ⏭ Wartet auf AG |
| INA-ePA-und-Patientenportale_I04 | Matrix (Kap. 7 Arbeitsdokument) in der Gruppe weiter diskutieren und verfeinern | ⏭ Wartet auf AG |
| INA-ePA-und-Patientenportale_F01 | Soll „Patient beraten und aufklären" ein eigenständiger Prozessschritt im Modell werden? (Plenum) | ⏭ Wartet auf Plenum |
| INA-ePA-und-Patientenportale_D04 | Systemebene (Kap. 8): weitere Ist-Analyse-Beispiele | ⏭ Wartet auf AG-Input |
| INA-ePA-und-Patientenportale_D05 | Lebenszyklus von Datenobjekten — bewusst ausgeklammert, kann später ergänzt werden | ⏭ Zurückgestellt |
