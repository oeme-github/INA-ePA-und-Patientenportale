# Forderungen Präklinisch

*UAG Patientenpfad — Stand: 2026-05-21*
*Basis: Ist-Analyse Prozessschritte 1–6 (patientenpfad_data.js)*

---

## Variante A — Vollständige Einzelpunkte (21 Forderungen)

### 1. Patientenidentifikation
- Eindeutige Patientenidentifikation bereits bei der Terminbuchung etablieren
- Patientenidentifikation mit der Einweisung/Überweisung verknüpfen, um Medienbrüche im weiteren Prozess zu vermeiden
- Einheitlichen Standard für Patientenidentifikation in Portal, KIS und ePA definieren (ISiK Basismodul, IHE PIX/PDQ)

### 2. Digitalisierung von Überweisung und Einweisung
- Elektronische Überweisung und Einweisung flächendeckend einführen — strukturiert, maschinenlesbar, auf Basis von FHIR ServiceRequest
- Einweisung als Auslöser für den frühzeitigen ePA-Zugriff nutzen

### 3. Frühzeitiger ePA-Zugriff
- Zugriff auf die ePA bereits ab Einweisung oder Überweisung ermöglichen — nicht erst ab erstem institutionellem Kontakt
- Zugriff über das Patientenportal ermöglichen, verknüpft mit Einweisung oder Überweisung

### 4. Stammdaten
- VSDM als Grundlage nutzen und um portalrelevante Felder erweitern (E-Mail, Telefon, Hausarzt inkl. KIM-Adresse)
- Einmalige Stammdatenerfassung als Prozessziel: Daten einmal erheben, sektorenübergreifend nutzen — nicht mehrfach neu eingeben

### 5. Strukturierte Daten und Interoperabilität
- Terminbuchung als Startpunkt des Datenprozesses: erfasste Informationen strukturiert in den weiteren Patientenpfad überführen
- Durchgängige FHIR-Integration zwischen Portal und KIS als Mindeststandard (ISiK Terminplanung)
- Strukturierte Zusendung von Vorbefunden durch Vorbehandler (LOINC, KDL)
- Krankenhaussysteme müssen bereitgestellte strukturierte Informationen automatisch verarbeiten können

### 6. Anamnese als kontinuierlicher Prozess
- Anamnese einmal erheben, sektorenübergreifend verfeinern — nicht an jeder Sektorgrenze neu erzeugen
- Einheitlicher Standard als technische Grundlage (ISiK Formular, FHIR QuestionnaireResponse)
- Anamnesedaten in KIS, ePA und Patientenportalen abrufbar und erweiterbar machen

### 7. Einwilligungs- und Consent-Management
- Einwilligungsmanagement in der ePA verankern — nicht in heterogenen Krankenhaussystemen
- Widerspruch gegen Zugriff und Befüllung der ePA zentral und standardisiert abbilden, nicht an KIS delegieren
- Krankenhausportale als Patientenschnittstelle einbinden: Einwilligungen und Widersprüche über das Portal erteilen und verwalten
- Consent-Abbildung für weitere Anwendungsfälle ermöglichen (Studienteilnahme, Broad-Consent)
- Unabhängige Treuhandstellen als mögliches Modell für Consent-Verwaltung prüfen

---

## Variante B — Fünf Kernforderungen mit Bestandsaufnahme

**1. Patientenidentifikation sektorenübergreifend lösen**
*Was existiert:* VSDM ist funktionierende Infrastruktur für Versichertenstammdaten. ISiK Basismodul und IHE PIX/PDQ sind ausgereifte Standards. Die eGK ist gesetzlich verankert (SGB V § 291).
*Was fehlt:* Portalrelevante Felder im VSDM, durchgängige Nutzung in allen Sektoren.

**2. Elektronische Überweisung als Prozessauslöser etablieren**
*Was existiert:* eÜberweisung (KBV) ist im Aufbau. FHIR ServiceRequest und KBV FHIR-Basisprofile sind technisch vorhanden. Die ePA ist ab erstem institutionellem Kontakt grundsätzlich zugänglich.
*Was fehlt:* Flächendeckende Einführung, Verknüpfung Einweisung → ePA-Zugriff.

**3. Strukturierte Daten statt Dokumente — FHIR als Mindeststandard**
*Was existiert:* ISiK Terminplanung und FHIR Appointment sind spezifiziert. Die Klinische Dokumentenliste (KDL) ist als Kategorisierungsstandard für die ePA vorhanden. ISiK Stufe 6 bringt das Formular-Modul für digitale Anamnese.
*Was fehlt:* Durchgängige, verpflichtende Umsetzung — nicht nur Spezifikation.

**4. Einmal erheben, sektorenübergreifend nutzen**
*Was existiert:* VSDM liefert bereits abrufbare Stammdaten. FHIR QuestionnaireResponse ist ein reifer internationaler Standard. ISiK Stufe 6 Formular ist gezielt auf diesen Anwendungsfall ausgelegt.
*Was fehlt:* Prozesslogik und verbindliche Anforderung zur Weitergabe — nicht das Werkzeug.

**5. Einwilligungsmanagement in der ePA verankern**
*Was existiert:* Der Widerspruch gegen ePA-Befüllung ist gesetzlich vorgesehen (SGB V § 342). HL7 FHIR Consent ist ein reifer Standard. Die gematik ePA-Spezifikation ist technische Infrastruktur.
*Was fehlt:* Zentrale, standardisierte Umsetzung — heute an KIS delegiert, ohne gemeinsame Grundlage.

---

## Variante C — Fließtext (Positionspapier-Stil)

### 1. Patientenidentifikation sektorenübergreifend lösen

Eine eindeutige Patientenidentifikation ist die Voraussetzung für jeden weiteren Datenprozess. Mit dem VSDM existiert bereits eine funktionierende Infrastruktur für Versichertenstammdaten; ISiK Basismodul und IHE PIX/PDQ sind ausgereifte Standards, die eine strukturierte Patientenidentifikation in Portal, KIS und ePA technisch ermöglichen.

Was fehlt, ist die durchgängige Nutzung dieser Grundlagen über alle Sektoren hinweg — und ihre Erweiterung um portalrelevante Felder, die das VSDM heute nicht enthält: E-Mail-Adresse, Telefonnummer und die KIM-Adresse des Hausarztes. Wir fordern, diese Felder im VSDM zu ergänzen und einen einheitlichen Identifikationsstandard verbindlich einzuführen — beginnend mit der Terminbuchung als erstem Kontaktpunkt.

### 2. Elektronische Überweisung als Prozessauslöser etablieren

Die technischen Grundlagen für eine elektronische Überweisung sind vorhanden: Die eÜberweisung der KBV ist im Aufbau, FHIR ServiceRequest und KBV FHIR-Basisprofile bieten eine strukturierte Grundlage. Die ePA ist grundsätzlich ab dem ersten institutionellen Kontakt zugänglich.

Der Regelfall ist heute dennoch Papier, Fax oder PDF — ein Medienbruch, der im weiteren Prozess zu manuellen Übertragungen und Informationsverlusten führt. Wir fordern die flächendeckende Einführung der elektronischen Überweisung als strukturiertes, maschinenlesbares Dokument auf Basis von FHIR ServiceRequest — und ihre Nutzung als Auslöser für den frühzeitigen ePA-Zugriff, der heute erst ab dem ersten institutionellen Kontakt möglich ist.

### 3. Strukturierte Daten statt Dokumente — FHIR als Mindeststandard

Die Spezifikationen sind vorhanden: ISiK Terminplanung und HL7 FHIR Appointment beschreiben den Terminprozess strukturiert. Die Klinische Dokumentenliste (KDL) stellt einen Kategorisierungsstandard für Dokumente in der ePA bereit. ISiK Stufe 6 führt mit dem Formular-Modul einen neuen Standard für die digitale Anamnese ein, der gezielt auf diesen Anwendungsfall zugeschnitten ist.

Was fehlt, ist die verbindliche und flächendeckende Umsetzung — nicht mehr Spezifikation, sondern Anforderung. Wir fordern, die durchgängige FHIR-Integration zwischen Portal, KIS und ePA als Mindeststandard festzuschreiben. Systeme müssen bereitgestellte strukturierte Informationen automatisch verarbeiten können — das Einlesen von PDFs darf kein Regelfall bleiben.

### 4. Einmal erheben, sektorenübergreifend nutzen

Die technischen Werkzeuge für eine sektorenübergreifende Datenweitergabe existieren: Das VSDM liefert bereits heute abrufbare Stammdaten. FHIR QuestionnaireResponse ist ein reifer internationaler Standard für strukturierte Anamnese-Daten. ISiK Stufe 6 ist auf genau diesen Anwendungsfall ausgelegt.

Das eigentliche Problem ist kein technisches — es ist ein Prozessproblem. Stammdaten, Anamnese und Vorbefunde werden an jeder Sektorgrenze neu erhoben, statt weitergegeben und verfeinert zu werden. Patientinnen und Patienten geben dieselben Informationen beim Hausarzt, beim Facharzt und im Krankenhaus wiederholt an. Wir fordern, das Prinzip „einmal erheben, sektorenübergreifend nutzen" als verbindliches Prozessziel zu verankern — und die vorhandenen technischen Standards zu seiner Umsetzung verpflichtend einzusetzen.

### 5. Einwilligungsmanagement in der ePA verankern

Die rechtliche und technische Grundlage ist gelegt: Der Widerspruch gegen Zugriff und Befüllung der ePA ist gesetzlich vorgesehen (SGB V § 342). HL7 FHIR Consent ist ein ausgereifter Standard für die strukturierte Abbildung von Einwilligungen. Die gematik ePA-Spezifikation stellt die technische Infrastruktur bereit.

In der Umsetzung wurde die Verantwortung jedoch an die Krankenhaussysteme delegiert — mit heterogenen, nicht standardisierten Lösungen als Ergebnis. Patientenportale sind in diesen Prozess nicht eingebunden. Wir fordern, das Einwilligungsmanagement zentral in der ePA zu verankern, Patientenportale als primäre Schnittstelle für Einwilligungen und Widersprüche einzubinden und Consent-Modelle von Anfang an so zu gestalten, dass sie auch für weitere Anwendungsfälle — Studienteilnahme, Broad-Consent — tragfähig sind.
