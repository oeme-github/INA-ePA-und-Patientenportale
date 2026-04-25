// Patientenpfad – Daten und Konfiguration
//
// Felder: nr, phase, titel, akteur[], objekt[], op, dr[], domäne, gesetze[], detail
// phase:  'vor' | 'im' | 'nach'
// op:     E = Erzeugt, V = Verändert, G = Gelöscht
// Alle Array-Felder (akteur, objekt, dr, gesetze) beziehen sich auf meta-Listen.

// ── Konfiguration (pflegbar über den Editor) ──────────────────────────────────

const meta = {

  domaenen: [
    'Anamnese', 'Befunde', 'Behandlung', 'Diagnosen', 'Dokumente',
    'Einwilligung', 'Kommunikation', 'Medikation', 'Nachsorge',
    'Patient', 'Pflege', 'Termin', 'Überweisung', 'Verlauf'
  ],

  akteure: [
    'Arzt', 'Niedergelassener Arzt', 'Patient', 'Pflege', 'Sozialdienst', 'Verwaltung'
  ],

  datenobjekte: [
    'AHB / Reha-Antrag',
    'Abschlussdokumentation / Fallabschluss',
    'Anamnese',
    'Arztbrief / Entlassbericht',
    'Check-in Bestätigung',
    'Diagnose / Befunddokumentation',
    'Einwilligungserklärung',
    'Entlassungsplan',
    'Laborwerte / Befunde im Portal',
    'Medikationsplan',
    'Nachricht / Rückfrage',
    'Nachsorgetermin',
    'Patientenfall / Fallakte',
    'Patientenstammdaten',
    'Pflegeassessment',
    'Pflegedokumentation / Vitalwerte',
    'Pflegerischer Überleitungsbogen',
    'Pflegeüberleitungsdokument',
    'Strukturierte Datenobjekte in der ePA',
    'Terminanfrage / Terminbestätigung',
    'Überweisung / Einweisung',
    'Untersuchungsergebnisse / Befunde',
    'Verlaufsdokumentation / PROMs',
    'Vorbefunde / Fremdbefunde',
    'Widerspruch'
  ],

  rechtsgrundlagen: [
    'AMVV § 14',
    'BGB § 630a (Behandlungsvertrag)',
    'BGB § 630d (Einwilligung)',
    'BGB § 630f (Dokumentationspflicht)',
    'BGB § 630f + § 630g',
    'BGB § 630g (Akteneinsicht)',
    'DiGAV',
    'DSGVO Art. 6',
    'DSGVO Art. 6 Abs. 1',
    'DSGVO Art. 6 + Art. 9',
    'DSGVO Art. 7 + Art. 9',
    'DSGVO Art. 9',
    'KHEntgG',
    'KHEntgG § 2',
    'KHZG',
    'KrPflG',
    'MBO-Ä § 10',
    'PatDatSchG',
    'SGB IX',
    'SGB V § 31a (Medikationsplan)',
    'SGB V § 39',
    'SGB V § 39 (Entlassmanagement)',
    'SGB V § 40 (Anschlussheilbehandlung)',
    'SGB V § 68a (DiGA)',
    'SGB V § 73 (Überweisungen)',
    'SGB V § 75 (Terminvermittlung)',
    'SGB V § 75a',
    'SGB V § 291 (eGK)',
    'SGB V § 301',
    'SGB V § 341 ff. (ePA)',
    'SGB V § 341–360 (ePA)',
    'SGB V § 342 (ePA-Einwilligung)',
    'SGB XI',
    'SGB XI § 14 (Pflegebedürftigkeit)',
    'SGB XI § 37',
    'StGB § 203 (Schweigepflicht)',
    'TKG'
  ]

};

// ── Prozessschritte ───────────────────────────────────────────────────────────

const data = [

  // ── Vor dem Krankenhaus ──────────────────────────────────────────────────────

  {
    nr: 1,
    phase: 'vor',
    titel: 'Termin anfragen / buchen',
    akteur: ['Patient', 'Verwaltung'],
    objekt: ['Terminanfrage / Terminbestätigung'],
    op: 'E',
    dr: ['portal', 'versorgung'],
    domäne: 'Termin',
    gesetze: ['SGB V § 75 (Terminvermittlung)', 'DSGVO Art. 6 Abs. 1'],
    detail: 'Terminvereinbarung für ambulante Vorstellung oder stationäre Aufnahme. Das Portal ist die primäre Schnittstelle – der Patient löst den Prozess aus.'
  },
  {
    nr: 2,
    phase: 'vor',
    titel: 'Überweisung / Einweisung bereitstellen',
    akteur: ['Niedergelassener Arzt', 'Patient'],
    objekt: ['Überweisung / Einweisung'],
    op: 'E',
    dr: ['versorgung', 'epa'],
    domäne: 'Überweisung',
    gesetze: ['SGB V § 73 (Überweisungen)', 'DSGVO Art. 9'],
    detail: 'Die Überweisung wird im Kontext des Krankenhauses erstmalig bereitgestellt. Heute oft noch als Papier oder PDF – ein klassischer Medienbruch.'
  },
  {
    nr: 3,
    phase: 'vor',
    titel: 'Stammdaten erfassen / aktualisieren',
    akteur: ['Patient', 'Verwaltung'],
    objekt: ['Patientenstammdaten'],
    op: 'E, V',
    dr: ['portal', 'versorgung'],
    domäne: 'Patient',
    gesetze: ['DSGVO Art. 6 + Art. 9', 'SGB V § 291 (eGK)', 'KHEntgG § 2'],
    detail: 'Kontaktdaten und Versicherungsdaten werden erfasst oder aktualisiert. Datenobjekt kann sowohl neu entstehen als auch verändert werden.'
  },
  {
    nr: 4,
    phase: 'vor',
    titel: 'Vorbefunde bereitstellen',
    akteur: ['Patient', 'Niedergelassener Arzt'],
    objekt: ['Vorbefunde / Fremdbefunde'],
    op: 'E',
    dr: ['portal', 'versorgung', 'epa'],
    domäne: 'Befunde',
    gesetze: ['DSGVO Art. 9', 'BGB § 630g (Akteneinsicht)', 'SGB V § 341 ff. (ePA)'],
    detail: 'Upload oder Zugriff auf vorhandene Dokumente. Idealerweise strukturierte Datenobjekte – nicht PDFs.'
  },
  {
    nr: 5,
    phase: 'vor',
    titel: 'Anamnesebogen ausfüllen',
    akteur: ['Patient'],
    objekt: ['Anamnese'],
    op: 'E',
    dr: ['portal', 'versorgung', 'epa'],
    domäne: 'Anamnese',
    gesetze: ['DSGVO Art. 9', 'BGB § 630a (Behandlungsvertrag)'],
    detail: 'Digitale medizinische Vorgeschichte. Zentrales Datenobjekt – wird im gesamten Pfad weitergenutzt. Sollte strukturiert vorliegen, nicht als Freitext.'
  },
  {
    nr: 6,
    phase: 'vor',
    titel: 'Einwilligungen erteilen',
    akteur: ['Patient'],
    objekt: ['Einwilligungserklärung', 'Widerspruch'],
    op: 'E',
    dr: ['portal', 'versorgung', 'epa', 'ehds'],
    domäne: 'Einwilligung',
    gesetze: ['DSGVO Art. 7 + Art. 9', 'BGB § 630d (Einwilligung)', 'SGB V § 342 (ePA-Einwilligung)'],
    detail: 'Datenschutz und Behandlungseinwilligung. Einwilligung und Widerspruch sind eigenständige Datenobjekte mit unterschiedlicher rechtlicher Wirkung.'
  },

  // ── Im Krankenhaus ───────────────────────────────────────────────────────────

  {
    nr: 7,
    phase: 'im',
    titel: 'Digitaler Check-in',
    akteur: ['Patient', 'Verwaltung'],
    objekt: ['Check-in Bestätigung'],
    op: 'E',
    dr: ['portal', 'versorgung'],
    domäne: 'Patient',
    gesetze: ['DSGVO Art. 6', 'SGB V § 39', 'KHZG'],
    detail: 'Bestätigung der Anwesenheit. Auslöser des stationären Prozesses – verbindet das Portal mit der Verwaltung.'
  },
  {
    nr: 8,
    phase: 'im',
    titel: 'Administrative Aufnahme',
    akteur: ['Verwaltung'],
    objekt: ['Patientenfall / Fallakte'],
    op: 'E',
    dr: ['versorgung'],
    domäne: 'Patient',
    gesetze: ['DSGVO Art. 9', 'KHEntgG § 2', 'SGB V § 39'],
    detail: 'Fallanlage im KIS. Zentrales Datenobjekt für den gesamten stationären Aufenthalt.'
  },
  {
    nr: 9,
    phase: 'im',
    titel: 'Pflegeassessment',
    akteur: ['Pflege'],
    objekt: ['Pflegeassessment'],
    op: 'E',
    dr: ['versorgung'],
    domäne: 'Pflege',
    gesetze: ['DSGVO Art. 9', 'SGB XI § 14 (Pflegebedürftigkeit)', 'KrPflG'],
    detail: 'Erfassung des pflegerischen Bedarfs bei Aufnahme – Mobilität, Ernährung, Risikoscreening. Eigenständiges Datenobjekt der Pflege.'
  },
  {
    nr: 10,
    phase: 'im',
    titel: 'Durchführung diagnostischer Maßnahmen',
    akteur: ['Arzt', 'Pflege'],
    objekt: ['Untersuchungsergebnisse / Befunde'],
    op: 'E',
    dr: ['versorgung', 'epa', 'ehds'],
    domäne: 'Befunde',
    gesetze: ['DSGVO Art. 9', 'BGB § 630a (Behandlungsvertrag)', 'MBO-Ä § 10'],
    detail: 'Untersuchungen und Diagnostik. Erzeugt medizinische Kerndaten – sollten strukturiert vorliegen für optimale Weiterverarbeitung.'
  },
  {
    nr: 11,
    phase: 'im',
    titel: 'Dokumentation medizinischer Ergebnisse',
    akteur: ['Arzt'],
    objekt: ['Diagnose / Befunddokumentation'],
    op: 'E, V',
    dr: ['versorgung', 'epa', 'ehds'],
    domäne: 'Diagnosen',
    gesetze: ['DSGVO Art. 9', 'BGB § 630f (Dokumentationspflicht)', 'MBO-Ä § 10'],
    detail: 'Befunde und Diagnosen werden dokumentiert. Zentrales Datenobjekt – wird laufend verändert und ergänzt.'
  },
  {
    nr: 12,
    phase: 'im',
    titel: 'Pflegedokumentation',
    akteur: ['Pflege'],
    objekt: ['Pflegedokumentation / Vitalwerte'],
    op: 'E, V',
    dr: ['versorgung', 'epa'],
    domäne: 'Pflege',
    gesetze: ['DSGVO Art. 9', 'BGB § 630f (Dokumentationspflicht)', 'SGB XI'],
    detail: 'Laufende Dokumentation von Pflegemaßnahmen, Vitalwerten und Verlauf. Wird kontinuierlich ergänzt.'
  },
  {
    nr: 13,
    phase: 'im',
    titel: 'Bereitstellung Informationen im Portal',
    akteur: ['Arzt', 'Verwaltung'],
    objekt: ['Laborwerte / Befunde im Portal'],
    op: 'E',
    dr: ['portal', 'versorgung'],
    domäne: 'Befunde',
    gesetze: ['DSGVO Art. 9', 'BGB § 630g (Akteneinsicht)', 'KHZG', 'SGB V § 341 ff. (ePA)'],
    detail: 'Ausgewählte Informationen werden dem Patienten im Portal bereitgestellt – z.B. Laborwerte. Strukturierte Daten ermöglichen eine sinnvolle Darstellung.'
  },
  {
    nr: 14,
    phase: 'im',
    titel: 'Kommunikation mit Behandlungsteam',
    akteur: ['Patient', 'Arzt', 'Pflege'],
    objekt: ['Nachricht / Rückfrage'],
    op: 'E',
    dr: ['portal', 'versorgung', 'epa'],
    domäne: 'Kommunikation',
    gesetze: ['DSGVO Art. 9', 'StGB § 203 (Schweigepflicht)', 'TKG'],
    detail: 'Nachrichten und Rückfragen – unabhängig vom Übertragungsweg (Portal, TI-Messenger oder andere Kanäle).'
  },
  {
    nr: 15,
    phase: 'im',
    titel: 'Entlassungsvorbereitung',
    akteur: ['Arzt', 'Verwaltung', 'Sozialdienst'],
    objekt: ['Entlassungsplan'],
    op: 'E',
    dr: ['versorgung', 'epa'],
    domäne: 'Nachsorge',
    gesetze: ['SGB V § 39 (Entlassmanagement)', 'DSGVO Art. 9'],
    detail: 'Organisation der Entlassung. Auslöser für mehrere nachgelagerte Prozesse – Pflegeüberleitung, AHB, Nachsorgetermin.'
  },
  {
    nr: 16,
    phase: 'im',
    titel: 'Pflegerische Entlassungsplanung',
    akteur: ['Pflege', 'Sozialdienst'],
    objekt: ['Pflegerischer Überleitungsbogen'],
    op: 'E',
    dr: ['versorgung', 'epa'],
    domäne: 'Nachsorge',
    gesetze: ['SGB V § 39 (Entlassmanagement)', 'SGB XI § 37', 'DSGVO Art. 9'],
    detail: 'Pflegerische Bedarfserfassung und Weitergabe. Eigenständiges Datenobjekt – intern für die Planung.'
  },
  {
    nr: 17,
    phase: 'im',
    titel: 'Pflegeüberleitung',
    akteur: ['Sozialdienst', 'Pflege'],
    objekt: ['Pflegeüberleitungsdokument'],
    op: 'E',
    dr: ['versorgung', 'epa'],
    domäne: 'Nachsorge',
    gesetze: ['SGB V § 39 (Entlassmanagement)', 'SGB XI § 37', 'DSGVO Art. 9'],
    detail: 'Bedarfserfassung und Organisation der pflegerischen Weiterversorgung. Das Überleitungsdokument geht an die nachversorgende Einrichtung.'
  },
  {
    nr: 18,
    phase: 'im',
    titel: 'AHB / Reha beantragen',
    akteur: ['Arzt', 'Sozialdienst'],
    objekt: ['AHB / Reha-Antrag'],
    op: 'E',
    dr: ['versorgung', 'epa'],
    domäne: 'Nachsorge',
    gesetze: ['SGB V § 40 (Anschlussheilbehandlung)', 'SGB IX', 'DSGVO Art. 9'],
    detail: 'Antragstellung und Weiterleitung an Kostenträger. Erzeugt ein eigenständiges Datenobjekt mit Weiterleitung an externe Akteure.'
  },

  // ── Nach dem Krankenhaus ─────────────────────────────────────────────────────

  {
    nr: 19,
    phase: 'nach',
    titel: 'Bereitstellung Entlassdokumente',
    akteur: ['Arzt', 'Verwaltung'],
    objekt: ['Arztbrief / Entlassbericht'],
    op: 'E',
    dr: ['portal', 'versorgung', 'epa', 'ehds'],
    domäne: 'Dokumente',
    gesetze: ['BGB § 630f + § 630g', 'DSGVO Art. 9', 'SGB V § 39 (Entlassmanagement)', 'MBO-Ä § 10'],
    detail: 'Arztbrief und Befunde nach Entlassung. Zentrales Übergabedokument – sollte strukturiert vorliegen, nicht nur als PDF.'
  },
  {
    nr: 20,
    phase: 'nach',
    titel: 'Bereitstellung Medikationsplan',
    akteur: ['Arzt'],
    objekt: ['Medikationsplan'],
    op: 'E',
    dr: ['portal', 'versorgung', 'epa', 'ehds'],
    domäne: 'Medikation',
    gesetze: ['SGB V § 31a (Medikationsplan)', 'DSGVO Art. 9', 'AMVV § 14'],
    detail: 'Aktueller Medikationsplan nach Entlassung. Klassisches Konsistenzproblem – existiert heute oft mehrfach und nicht synchronisiert.'
  },
  {
    nr: 21,
    phase: 'nach',
    titel: 'Bereitstellung Dokumente für ePA',
    akteur: ['Arzt', 'Verwaltung'],
    objekt: ['Strukturierte Datenobjekte in der ePA'],
    op: 'E',
    dr: ['epa', 'ehds'],
    domäne: 'Dokumente',
    gesetze: ['SGB V § 341–360 (ePA)', 'DSGVO Art. 9', 'PatDatSchG'],
    detail: 'Upload strukturierter Datenobjekte in die ePA. Ziel: keine Dokumente, sondern maschinenlesbare strukturierte Daten.'
  },
  {
    nr: 22,
    phase: 'nach',
    titel: 'Nachsorgetermin vereinbaren',
    akteur: ['Patient', 'Verwaltung'],
    objekt: ['Nachsorgetermin'],
    op: 'E',
    dr: ['portal', 'versorgung'],
    domäne: 'Termin',
    gesetze: ['SGB V § 39 (Entlassmanagement)', 'SGB V § 75a', 'DSGVO Art. 6'],
    detail: 'Terminplanung nach Entlassung. Portal als primäre Schnittstelle für den Patienten.'
  },
  {
    nr: 23,
    phase: 'nach',
    titel: 'Digitale Verlaufserfassung',
    akteur: ['Patient'],
    objekt: ['Verlaufsdokumentation / PROMs'],
    op: 'E',
    dr: ['portal', 'versorgung', 'epa'],
    domäne: 'Verlauf',
    gesetze: ['DSGVO Art. 9', 'SGB V § 68a (DiGA)', 'DiGAV'],
    detail: 'Fragebögen und PROMs nach Entlassung. Patient als aktiver Datenerzeuger – strukturierte Rückmeldungen ermöglichen Automatisierung.'
  },
  {
    nr: 24,
    phase: 'nach',
    titel: 'Kommunikation mit Klinik',
    akteur: ['Patient', 'Arzt'],
    objekt: ['Nachricht / Rückfrage'],
    op: 'E, V',
    dr: ['portal', 'versorgung', 'epa'],
    domäne: 'Kommunikation',
    gesetze: ['DSGVO Art. 9', 'StGB § 203 (Schweigepflicht)', 'TKG'],
    detail: 'Rückfragen nach Entlassung – unabhängig vom Übertragungsweg.'
  },
  {
    nr: 25,
    phase: 'nach',
    titel: 'Abschluss der Behandlung',
    akteur: ['Arzt', 'Verwaltung'],
    objekt: ['Abschlussdokumentation / Fallabschluss'],
    op: 'E',
    dr: ['versorgung', 'epa'],
    domäne: 'Dokumente',
    gesetze: ['BGB § 630f (Dokumentationspflicht)', 'DSGVO Art. 9', 'KHEntgG', 'SGB V § 301'],
    detail: 'Behandlungsfall wird abgeschlossen. Finales Datenobjekt des Patientenpfads.'
  },

];
