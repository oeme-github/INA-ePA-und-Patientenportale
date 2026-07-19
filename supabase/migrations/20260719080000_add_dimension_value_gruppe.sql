-- V02/V03: generische Gruppierungs-Ebene für Dimension-Werte
--
-- Hintergrund: Das Original (patientenpfad_interaktiv.html) gruppiert
-- Rechtsgrundlagen (§/Art./Abs.-Regex) und Standards (startsWith-Kaskade)
-- rein clientseitig, hart codiert auf die heutigen AG-Daten. Das passt
-- nicht zum generischen Dimensionen-Prinzip (siehe KONTEXT.md,
-- "Architekturentscheidung: Multi-User-Web-Tool") — andere Arbeitsgruppen
-- hätten andere Werte und bräuchten eigene Regex-Regeln im Code. Deshalb
-- wird die Gruppierung stattdessen als optionales Attribut am Wert selbst
-- abgelegt, pflegbar über den Editor wie Label/Farbe.

alter table dimension_values add column gruppe text;

comment on column dimension_values.gruppe is
  'Optionale Übergruppe für Werte innerhalb einer Dimension (z.B. Gesetzes-Paragraf -> Gesetzeskategorie, Standard -> Standard-Familie). Rein clientseitig zur Filter-Gruppierung genutzt, keine referenzielle Integrität zu einer eigenen Gruppen-Tabelle.';
