# Rolle von Patientenportalen im Zusammenspiel mit Primärsystemen und ePA
### Standardisierung des Datenaustauschs im Patientenpfad

**Version 3 | Stand: 2026-04-24**

---

## 1. Einführung des Vorgehens

Ziel des **AK Patientenportale** ([ina.gematik.de](https://www.ina.gematik.de/mitwirken/arbeitskreise/rolle-von-patientenportalen-im-zusammenspiel-mit-primaersystemen-und-epa-1)) ist die Entwicklung eines Plans, wie der Datenaustausch zwischen einrichtungsspezifischen Patientenportalen, einrichtungsspezifischen Primärsystemen und der bundesweiten ePA künftig standardisiert stattfinden sollte – inklusive der Aufnahme von Impulsen aus dem Ausland.

Im Rahmen des AK wurde eine Unterarbeitsgruppe gegründet, die sich mit dem Patientenpfad und den Prozessen vor, im und nach dem Krankenhaus beschäftigt.

Der gewählte Ansatz folgt bewusst dieser Reihenfolge:

**Erst die Prinzipien – dann der Prozess – dann die Daten.**

Die Systemebene wird zunächst ausgeklammert und erst später als Mapping auf Prozesse und Daten betrachtet.

---

## 2. These & Grundprinzipien

**These:** Eine tragfähige Standardisierung des Datenaustauschs im Gesundheitswesen kann nicht von Systemen ausgehen. Sie muss vom Prozess her gedacht werden.

Daraus folgen vier Grundprinzipien:

**Prozess vor Daten vor System.**
Systeme unterstützen Prozesse. Prozesse werden von Akteuren ausgeführt und erzeugen, verändern oder löschen Daten. Die Systemebene ist Mittel zum Zweck – nicht Ausgangspunkt.

**Keine führenden Systeme.**
Es gibt keine primären oder sekundären Systeme. Daten gehören dem Prozess – und letztlich dem Patienten. Systemgrenzen sind kein strukturgebendes Element.

**Datenobjekte vor Datenflüsse.**
Im Fokus stehen nicht Schnittstellen zwischen Systemen, sondern Datenobjekte: Was wird wann von wem erzeugt, verändert oder gelöscht?

**Strukturierte Daten vor Dokumenten.**
Datenobjekte sollen maschinenlesbar und strukturiert sein. Strukturierte Datenobjekte ermöglichen Automatisierung, Entscheidungsunterstützung und sektorenübergreifende Weiterverarbeitung. Sie sind das Ziel – nicht die Ausnahme. Die menschenlesbare Darstellung ist Aufgabe der Systeme – ob auf dem Bildschirm, im Ausdruck oder in anderer Form.

Die drei gleichwertigen Elemente lassen sich in einer einfachen Formel ausdrücken:

> **Akteur × Prozess → Datenobjekt**

Kein Element kann ohne die anderen beiden gedacht werden.

---

## 3. Prozessmodell

Der Patientenpfad wird in drei temporale Phasen gegliedert:

- **Vor dem Krankenhaus** – Alles was zeitlich vor dem stationären oder ambulanten Aufenthalt stattfindet
- **Im Krankenhaus** – Der Aufenthalt selbst, von Aufnahme bis Entlassung
- **Nach dem Krankenhaus** – Die Nachsorge und Weiterversorgung

| Phase | Prozessschritt | Kurzbeschreibung | Akteur |
|---|---|---|---|
| Vor dem Krankenhaus | Termin anfragen / buchen | Terminvereinbarung für ambulante Vorstellung oder stationäre Aufnahme | Patient, Verwaltung |
| Vor dem Krankenhaus | Überweisung / Einweisung bereitstellen | Überweisung oder Einweisung wird übermittelt | Niedergelassener Arzt, Patient |
| Vor dem Krankenhaus | Stammdaten erfassen / aktualisieren | Kontaktdaten, Versicherungsdaten | Patient, Verwaltung |
| Vor dem Krankenhaus | Vorbefunde bereitstellen | Upload oder Zugriff auf vorhandene Dokumente | Patient, Niedergelassener Arzt |
| Vor dem Krankenhaus | Anamnesebogen ausfüllen | Digitale medizinische Vorgeschichte | Patient |
| Vor dem Krankenhaus | Einwilligungen erteilen | Datenschutz, Behandlungseinwilligung | Patient |
| Im Krankenhaus | Digitaler Check-in | Bestätigung der Anwesenheit | Patient, Verwaltung |
| Im Krankenhaus | Administrative Aufnahme | Fallanlage und administrative Aufnahme | Verwaltung |
| Im Krankenhaus | Pflegeassessment | Erfassung des pflegerischen Bedarfs bei Aufnahme | Pflege |
| Im Krankenhaus | Durchführung diagnostischer Maßnahmen | Untersuchungen und Diagnostik | Arzt, Pflege |
| Im Krankenhaus | Dokumentation medizinischer Ergebnisse | Befunde, Diagnosen | Arzt |
| Im Krankenhaus | Pflegedokumentation | Laufende Dokumentation von Pflegemaßnahmen, Vitalwerten und Verlauf | Pflege |
| Im Krankenhaus | Bereitstellung ausgewählter Informationen im Portal | z. B. Laborwerte | Arzt, Verwaltung |
| Im Krankenhaus | Kommunikation mit Behandlungsteam | Nachrichten, Rückfragen | Patient, Arzt, Pflege |
| Im Krankenhaus | Entlassungsvorbereitung | Organisation der Entlassung | Arzt, Verwaltung, Sozialdienst |
| Im Krankenhaus | Pflegerische Entlassungsplanung | Pflegerische Bedarfserfassung und Weitergabe an nachversorgende Einrichtungen | Pflege, Sozialdienst |
| Im Krankenhaus | Pflegeüberleitung | Bedarfserfassung und Organisation der pflegerischen Weiterversorgung | Sozialdienst, Pflege |
| Im Krankenhaus | Anschlussheilbehandlung (AHB) / Reha beantragen | Antragstellung und Weiterleitung an Kostenträger | Arzt, Sozialdienst |
| Nach dem Krankenhaus | Bereitstellung Entlassdokumente | Arztbrief, Befunde | Arzt, Verwaltung |
| Nach dem Krankenhaus | Bereitstellung Medikationsplan | Aktuelle Medikation | Arzt |
| Nach dem Krankenhaus | Bereitstellung Dokumente für ePA | Upload oder Bereitstellung für ePA | Arzt, Verwaltung |
| Nach dem Krankenhaus | Nachsorgetermin vereinbaren | Terminplanung | Patient, Verwaltung |
| Nach dem Krankenhaus | Digitale Verlaufserfassung | z. B. Fragebögen oder PROMs | Patient |
| Nach dem Krankenhaus | Kommunikation mit Klinik | Rückfragen nach Entlassung | Patient, Arzt |
| Nach dem Krankenhaus | Abschluss der Behandlung | Behandlungsfall abgeschlossen | Arzt, Verwaltung |

---

Jeder Prozessschritt erzeugt, verändert oder löscht Daten. Der Prozessschritt **„Anamnesebogen ausfüllen"** erzeugt ein Datenobjekt – die **Anamnese**. Dieses Objekt kann im weiteren Verlauf durch den Arzt ergänzt, durch neue Befunde aktualisiert oder nach Abschluss der Behandlung archiviert werden.

Im folgenden Abschnitt modellieren wir für jeden Prozessschritt die zugehörigen Datenobjekte.

---

## 4. Datenmodell

Jeder Prozessschritt erzeugt, verändert oder löscht mindestens ein Datenobjekt. Die folgende Übersicht ordnet den Prozessschritten ihre zentralen Datenobjekte zu und beschreibt die jeweilige Operation.

Die möglichen Operationen sind:

- **E** – Erzeugt
- **V** – Verändert
- **G** – Gelöscht

Ein Datenobjekt gilt als erzeugt **(E)**, wenn es im Kontext des jeweiligen Prozessschritts erstmalig vorliegt – unabhängig davon, ob es an anderer Stelle bereits existiert.

| Phase | Prozessschritt | Akteur | Datenobjekt | Operation |
|---|---|---|---|---|
| Vor dem Krankenhaus | Termin anfragen / buchen | Patient, Verwaltung | Terminanfrage / Terminbestätigung | E |
| Vor dem Krankenhaus | Überweisung / Einweisung bereitstellen | Niedergelassener Arzt, Patient | Überweisung / Einweisung | E |
| Vor dem Krankenhaus | Stammdaten erfassen / aktualisieren | Patient, Verwaltung | Patientenstammdaten | E, V |
| Vor dem Krankenhaus | Vorbefunde bereitstellen | Patient, Niedergelassener Arzt | Vorbefunde / Fremdbefunde | E |
| Vor dem Krankenhaus | Anamnesebogen ausfüllen | Patient | Anamnese | E |
| Vor dem Krankenhaus | Einwilligungen erteilen | Patient | Einwilligungserklärung | E |
| Vor dem Krankenhaus | Einwilligungen erteilen | Patient | Widerspruch | E |
| Im Krankenhaus | Digitaler Check-in | Patient, Verwaltung | Check-in Bestätigung | E |
| Im Krankenhaus | Administrative Aufnahme | Verwaltung | Patientenfall / Fallakte | E |
| Im Krankenhaus | Pflegeassessment | Pflege | Pflegeassessment | E |
| Im Krankenhaus | Durchführung diagnostischer Maßnahmen | Arzt, Pflege | Untersuchungsergebnisse / Befunde | E |
| Im Krankenhaus | Dokumentation medizinischer Ergebnisse | Arzt | Diagnose / Befunddokumentation | E, V |
| Im Krankenhaus | Pflegedokumentation | Pflege | Pflegedokumentation / Vitalwerte | E, V |
| Im Krankenhaus | Bereitstellung ausgewählter Informationen im Portal | Arzt, Verwaltung | Laborwerte / Befunde im Portal | E |
| Im Krankenhaus | Kommunikation mit Behandlungsteam | Patient, Arzt, Pflege | Nachricht / Rückfrage | E |
| Im Krankenhaus | Entlassungsvorbereitung | Arzt, Verwaltung, Sozialdienst | Entlassungsplan | E |
| Im Krankenhaus | Pflegerische Entlassungsplanung | Pflege, Sozialdienst | Pflegerischer Überleitungsbogen | E |
| Im Krankenhaus | Pflegeüberleitung | Sozialdienst, Pflege | Pflegeüberleitungsdokument | E |
| Im Krankenhaus | Anschlussheilbehandlung (AHB) / Reha beantragen | Arzt, Sozialdienst | AHB / Reha-Antrag | E |
| Nach dem Krankenhaus | Bereitstellung Entlassdokumente | Arzt, Verwaltung | Arztbrief / Entlassbericht | E |
| Nach dem Krankenhaus | Bereitstellung Medikationsplan | Arzt | Medikationsplan | E |
| Nach dem Krankenhaus | Bereitstellung Dokumente für ePA | Arzt, Verwaltung | Strukturierte Datenobjekte in der ePA | E |
| Nach dem Krankenhaus | Nachsorgetermin vereinbaren | Patient, Verwaltung | Nachsorgetermin | E |
| Nach dem Krankenhaus | Digitale Verlaufserfassung | Patient | Verlaufsdokumentation / PROMs | E |
| Nach dem Krankenhaus | Kommunikation mit Klinik | Patient, Arzt | Nachricht / Rückfrage | E, V |
| Nach dem Krankenhaus | Abschluss der Behandlung | Arzt, Verwaltung | Abschlussdokumentation / Fallabschluss | E |

---

## 5. Informationsdomänen

Die im Prozessmodell identifizierten Datenobjekte lassen sich zu stabilen Informationsdomänen verdichten. Diese Domänen sind unabhängig von konkreten Systemen und bilden die Grundlage für eine interoperable Architektur.

| Informationsdomäne | Beispiele |
|---|---|
| Patient | Stammdaten, Identität |
| Termin | Terminanfrage, Terminbestätigung |
| Überweisung | Überweisung, Einweisung |
| Einwilligung | Einwilligungserklärung, Widerspruch |
| Anamnese | Anamnesebogen, medizinische Vorgeschichte |
| Befunde | Laborwerte, Bildgebung, Untersuchungsergebnisse |
| Diagnosen | Medizinische Bewertung, Befunddokumentation |
| Behandlung | Therapien, Prozeduren |
| Medikation | Verordnungen, Medikationsplan |
| Pflege | Pflegeassessment, Pflegedokumentation, Vitalwerte |
| Kommunikation | Nachrichten, Rückfragen – unabhängig vom Übertragungsweg |
| Nachsorge | Entlassungsplan, Überleitungsbogen, AHB-Antrag |
| Verlauf | PROMs, Verlaufsdokumentation |
| Dokumente | Arztbrief, Entlassbericht |

---

## 6. Datenräume im Patientenpfad

Die im Prozess entstehenden Datenobjekte können in unterschiedlichen Datenräumen vorliegen.

| Datenraum | Beschreibung |
|---|---|
| Versorgungssysteme | Systeme der Leistungserbringer – z. B. KIS, PVS |
| Patientenportal | Patientenzentrierter Zugang zu Informationen und Kommunikation |
| ePA | Bundesweite, sektorenübergreifende persönliche Patientenakte |
| EHDS | Europäischer Gesundheitsdatenraum – länderübergreifende Verfügbarkeit von Gesundheitsdaten |

Diese Datenräume erfüllen unterschiedliche Funktionen – sind aber gleichwertig. Kein Datenraum ist führend. Die Architektur folgt nicht einem Systemfluss, sondern einer Informationsverteilung über Datenräume. Kommunikation findet dabei über alle Datenräume hinweg statt – unabhängig vom genutzten Übertragungsweg.

---

## 7. Verteilung der Informationsdomänen über die Datenräume

| Informationsdomäne | Patientenportal | Versorgungssysteme | ePA | EHDS |
|---|---|---|---|---|
| Patient | ✓ | ✓ | ✓ | ✓ |
| Termin | ✓ | ✓ | | |
| Überweisung | ✓ | ✓ | ✓ | |
| Einwilligung | ✓ | ✓ | ✓ | ✓ |
| Anamnese | ✓ | ✓ | ✓ | |
| Befunde | ✓ | ✓ | ✓ | ✓ |
| Diagnosen | | ✓ | ✓ | ✓ |
| Behandlung | | ✓ | ✓ | ✓ |
| Medikation | ✓ | ✓ | ✓ | ✓ |
| Pflege | | ✓ | ✓ | |
| Kommunikation | ✓ | ✓ | ✓ | |
| Nachsorge | ✓ | ✓ | ✓ | |
| Verlauf | ✓ | ✓ | ✓ | |
| Dokumente | ✓ | ✓ | ✓ | ✓ |

*Die Verteilung der Informationsdomänen über die Datenräume ist beispielhaft und erhebt keinen Anspruch auf Vollständigkeit. Sie dient als Ausgangspunkt für die weitere Diskussion in der Arbeitsgruppe.*

---

## 8. Systemebene

### 8.1 Beispielhafte Ist-Analyse

**Beispiel 1: Überweisung / Einweisung**

| | |
|---|---|
| **Prozessschritt** | Überweisung / Einweisung bereitstellen |
| **Akteur** | Niedergelassener Arzt, Patient |
| **Datenobjekt** | Überweisung / Einweisung |
| **Ist-Zustand** | Die Überweisung wird heute überwiegend als Papier oder PDF übermittelt – per Fax, Post oder durch den Patienten selbst. Im Krankenhaus wird sie manuell in das KIS übertragen. |
| **Lücke** | Das Datenobjekt ist nicht strukturiert. Die enthaltenen Informationen – Diagnose, Fragestellung, Vorbehandlung – müssen manuell erfasst werden. Dabei entstehen Medienbrüche, Übertragungsfehler und Zeitverlust. |
| **Konsequenz** | Der Prozess wird verlangsamt. Informationen gehen verloren oder werden falsch übertragen. Eine automatisierte Weiterverarbeitung ist nicht möglich. |

**Beispiel 2: Medikationsplan**

| | |
|---|---|
| **Prozessschritt** | Bereitstellung Medikationsplan |
| **Akteur** | Arzt |
| **Datenobjekt** | Medikationsplan |
| **Ist-Zustand** | Der Medikationsplan existiert heute an mehreren Stellen parallel – beim niedergelassenen Arzt, im Krankenhaus, in der Pflege und in der Apotheke. Er wird bei Übergängen oft neu erstellt oder manuell abgeglichen. |
| **Lücke** | Es gibt kein konsistentes, strukturiertes Datenobjekt das sektorenübergreifend gepflegt wird. Die ePA bietet zwar einen Medikationsplan – aber er wird heute nicht zuverlässig befüllt oder aktualisiert. |
| **Konsequenz** | Mehrfachmedikationen, Wechselwirkungen und Dosierungsfehler entstehen, weil Akteure mit unterschiedlichen oder veralteten Versionen arbeiten. |

---

### 8.2 Anforderungen

Aus der Ist-Analyse lassen sich direkt Anforderungen ableiten:

**A1 – Strukturierte Übergabe**
Datenobjekte müssen strukturiert übermittelt werden – unabhängig vom übertragenden System. Papier und PDF sind keine akzeptablen Formate für prozessrelevante Datenobjekte.

**A2 – Eindeutigkeit**
Jedes Datenobjekt existiert genau einmal. Kopien sind Darstellungen – keine eigenständigen Datenobjekte. Systeme greifen auf das gemeinsame Datenobjekt zu, anstatt eigene Versionen zu führen.

**A3 – Aktualität**
Veränderungen an einem Datenobjekt sind sofort für alle berechtigten Akteure sichtbar – unabhängig vom System, das die Änderung vorgenommen hat.

---

## 9. Ausblick

### 9.1 Ziel

Das Ziel ist ein standardisierter, prozessgetriebener Datenaustausch, bei dem strukturierte Datenobjekte sektorenübergreifend, eindeutig und aktuell vorliegen – unabhängig vom System. Akteure können sich auf die Versorgung konzentrieren, weil Daten dort sind, wo sie gebraucht werden.

Die erarbeiteten Prozesse und Datenobjekte sind die Grundlage dafür, wie Patientenportale und ePA künftig zusammenspielen sollen. Nicht die Systeme bestimmen den Datenaustausch – sondern Prozesse und Datenobjekte definieren, was Patientenportale leisten müssen und was in der ePA vorliegen soll.

Patientenportale sind die primäre Schnittstelle zum Patienten. Die ePA ist der sektorenübergreifende Datenspeicher. Beide müssen strukturierte Datenobjekte erzeugen, verarbeiten und bereitstellen – nicht Dokumente.

### 9.2 Nächste Schritte

**Standards prüfen**
Welche bestehenden Standards – FHIR, IHE, HL7 – erfüllen die formulierten Anforderungen bereits? Wo gibt es Lücken, die eine Weiterentwicklung oder neue Festlegungen erfordern?

**Impulse aus dem Ausland**
Wie haben andere Länder vergleichbare Probleme gelöst? Welche Ansätze – etwa aus Dänemark, Estland oder den Niederlanden – lassen sich auf den deutschen Kontext übertragen?

**Pilotprozesse definieren**
Welche zwei oder drei Prozessschritte eignen sich für eine erste modellhafte Umsetzung? Ziel ist ein konkreter Proof of Concept, der die Prinzipien in die Praxis überführt.

---

## Anhang: Vollständiger Prozessblumenstrauß

### Vor dem Krankenhaus

| Prozessschritt | Kurzbeschreibung |
|---|---|
| Krankenhaus / Fachabteilung recherchieren | Patient informiert sich über Behandlungsangebote |
| Termin anfragen / buchen | Terminvereinbarung für ambulante Vorstellung oder stationäre Aufnahme |
| Überweisung / Einweisung bereitstellen | Überweisung oder Einweisung wird übermittelt |
| Patientenkonto im Portal anlegen | Registrierung im Patientenportal |
| Stammdaten erfassen / aktualisieren | Kontaktdaten, Versicherungsdaten |
| Versicherungsinformationen übermitteln | eGK-Daten oder Versicherungsnachweis |
| Vorbefunde bereitstellen | Upload oder Zugriff auf vorhandene Dokumente |
| Anamnesebogen ausfüllen | Digitale medizinische Vorgeschichte |
| Fragebögen ausfüllen | z. B. PROMs, Risikoabfragen |
| Aufklärungsmaterial bereitstellen | Informationsmaterial zur Behandlung |
| Einwilligungen erteilen | Datenschutz, Behandlungseinwilligung |
| Aufnahme vorbereiten | Administrative Vorbereitung |
| Terminbestätigung erhalten | Bestätigung inkl. organisatorischer Hinweise |
| Erinnerungen erhalten | Terminerinnerungen |

### Im Krankenhaus

| Prozessschritt | Kurzbeschreibung |
|---|---|
| Digitaler Check-in | Bestätigung der Anwesenheit |
| Administrative Aufnahme | Fallanlage und administrative Aufnahme |
| Aktualisierung Stammdaten | Überprüfung der Patientendaten |
| Bereitstellung zusätzlicher Informationen | Ergänzung medizinischer Angaben |
| Durchführung diagnostischer Maßnahmen | Untersuchungen und Diagnostik |
| Durchführung therapeutischer Maßnahmen | Operationen, Therapien |
| Kommunikation mit Behandlungsteam | Nachrichten, Rückfragen |
| Patienteninformation zum Behandlungsverlauf | Informationen über geplante Maßnahmen |
| Dokumentation medizinischer Ergebnisse | Befunde, Diagnosen |
| Bereitstellung ausgewählter Informationen im Portal | z. B. Laborwerte |
| Erteilung weiterer Einwilligungen | z. B. Studien, Zusatzleistungen |
| Entlassungsvorbereitung | Organisation der Entlassung |
| Planung der Nachversorgung | Terminplanung oder Weiterbehandlung |

### Nach dem Krankenhaus

| Prozessschritt | Kurzbeschreibung |
|---|---|
| Bereitstellung Entlassdokumente | Arztbrief, Befunde |
| Bereitstellung Medikationsplan | Aktuelle Medikation |
| Übermittlung relevanter Dokumente an weiterbehandelnde Ärzte | Informationsweitergabe |
| Bereitstellung Dokumente im Patientenportal | Zugriff für Patient |
| Bereitstellung Dokumente für ePA | Upload oder Bereitstellung für ePA |
| Nachsorgetermin vereinbaren | Terminplanung |
| Digitale Verlaufserfassung | z. B. Fragebögen oder PROMs |
| Kommunikation mit Klinik | Rückfragen nach Entlassung |
| Upload externer Befunde | Dokumente von anderen Ärzten |
| Anpassung Therapie / Medikation | Anpassung nach Rückmeldung |
| Abschluss der Behandlung | Behandlungsfall abgeschlossen |
