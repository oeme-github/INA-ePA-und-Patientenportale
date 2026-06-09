# Positionspapier: Patientenportale im Zusammenspiel mit Primärsystemen und ePA

**AK Patientenportale | INA gematik**
**Stand: 2026-06-08 | Version 0.4 (Entwurf)**

---

## 1. Executive Summary

*[Platzhalter — wird nach Fertigstellung aller Kapitel zusammengestellt]*

---

## 2. Einleitung

### 2.1 Ziele des Arbeitskreises

*[Platzhalter]*

### 2.2 Begriffsklärungen

*[Platzhalter]*

---

## 3. Methodisches Vorgehen

### 3.1 Grundprinzipien

Der AK Patientenportale hat sich auf einen bewusst prozessgetriebenen Ansatz geeinigt. Ausgangspunkt ist die Überzeugung, dass eine tragfähige Standardisierung des Datenaustauschs im Gesundheitswesen nicht von Systemen ausgehen kann — sie muss vom Prozess her gedacht werden.

Der gewählte Ansatz folgt konsequent dieser Reihenfolge:

> **Erst die Prinzipien — dann der Prozess — dann die Daten.**

Die Systemebene wird zunächst ausgeklammert und erst in einem zweiten Schritt als Mapping auf Prozesse und Daten betrachtet. Das bedeutet nicht, dass bestehende technische Lösungen ignoriert werden. Im Gegenteil: Die Ist-Analyse benennt explizit, was heute bereits existiert und funktioniert — VSDM, ISiK, ePA-Infrastruktur, FHIR-Profile, IHE-Profile. Dieser Bestand ist der Ausgangspunkt. Der Prozessrahmen gibt den Maßstab vor, an dem bestehende Lösungen gemessen und Lücken identifiziert werden.

Daraus leiten sich vier Grundprinzipien ab:

**Prozess vor Daten vor System.**
Systeme unterstützen Prozesse. Prozesse werden von Akteuren ausgeführt und erzeugen, verändern oder löschen Datenobjekte. Die Systemebene ist Mittel zum Zweck — nicht Ausgangspunkt.

**Keine führenden Systeme.**
Es gibt keine primären oder sekundären Systeme. Datenobjekte gehören dem Prozess — und letztlich dem Patienten. Systemgrenzen sind kein strukturgebendes Element.

**Datenobjekte vor Datenflüsse.**
Im Fokus stehen nicht Schnittstellen zwischen Systemen, sondern Datenobjekte: Was wird wann von wem erzeugt, verändert oder gelöscht?

**Strukturierte Datenobjekte vor dokumentenbasierter Darstellung.**
Datenobjekte sollen maschinenlesbar und strukturiert sein. Ein Dokument (z. B. ein PDF) ist dabei selbst ein Datenobjekt in unstrukturierter, menschenlesbarer Repräsentation — kein Gegensatz zum Datenobjekt, sondern dessen Darstellungsform. Die menschenlesbare Darstellung ist Aufgabe der Systeme — ob auf dem Bildschirm, im Ausdruck oder in anderer Form. Strukturierte Datenobjekte ermöglichen Automatisierung, Entscheidungsunterstützung und sektorenübergreifende Weiterverarbeitung. Sie sind das Ziel — nicht die Ausnahme.

Die drei gleichwertigen Elemente des Ansatzes lassen sich in einer Leitformel ausdrücken:

> **Akteur × Prozess → Datenobjekt**

Kein Element kann ohne die anderen beiden gedacht werden. Diese Formel ist der gemeinsame Anker der Gruppe.

---

### 3.2 Prozessmodell

Der Patientenpfad wird in drei temporale Phasen gegliedert:

| Phase | Beschreibung |
|---|---|
| **Vor dem Krankenhaus** | Alles, was zeitlich vor dem stationären oder ambulanten Aufenthalt stattfindet — von der Terminanfrage bis zur Aufnahmevorbereitung |
| **Im Krankenhaus** | Der Aufenthalt selbst, von der Aufnahme bis zur Entlassung — einschließlich Pflege, Diagnostik, Behandlung und Entlassungsplanung |
| **Nach dem Krankenhaus** | Nachsorge und Weiterversorgung — von der Bereitstellung der Entlassdokumente bis zum Abschluss des Behandlungsfalls |

Innerhalb dieser Phasen wurden **25 Prozessschritte** modelliert. Sie repräsentieren die aus Sicht der Arbeitsgruppe zentralen Schritte im Patientenpfad — ohne Anspruch auf Vollständigkeit. Jeder Prozessschritt wird durch drei Dimensionen beschrieben:

- **Akteur** — Wer führt den Schritt aus? (Details siehe Kap. 3.3)
- **Datenobjekt** — Was entsteht, verändert sich oder wird gelöscht?
- **Operation** — Wird das Datenobjekt erzeugt (E), verändert (V) oder gelöscht (G)?

Die Operation ist dabei das Verb des Prozessschritts: Sie konkretisiert, was im Sinne der Leitformel (Kap. 3.1) tatsächlich am Datenobjekt geschieht. Diese Modellierung erlaubt eine systemunabhängige Beschreibung des Patientenpfads. Eine Übersicht der im Rahmen der Unterarbeitsgruppen analysierten Prozessschritte ist in Kapitel 4.3 dargestellt.

Ein Datenobjekt gilt als **erzeugt (E)**, wenn es im Kontext des jeweiligen Prozessschritts erstmalig vorliegt — unabhängig davon, ob es an anderer Stelle bereits existiert. Datenobjekte können **persistent** sein — gespeichert und über den Prozessschritt hinaus verfügbar (z. B. Diagnose, Medikationsplan) — oder **transient** — erzeugt, übermittelt und danach nicht mehr als eigenständiges Objekt vorhanden (z. B. Terminanfrage, Nachricht). Diese Unterscheidung trifft der Prozess — nicht das System.

Neben den explizit modellierten Prozessschritten gibt es **prozessbegleitende Elemente**, die an mehreren Stellen des Patientenpfads auftreten und nicht einem einzelnen Schritt zugeordnet werden können. Dazu gehört die **Patientenberatung und -aufklärung**: Aufklärungsgespräche, Informationsmaterialien und evidenzbasierte Entscheidungshilfen begleiten den Patienten von der Terminvorbereitung über die Einwilligungserteilung bis zur Entlassung. Die dabei entstehenden und eingesetzten Datenobjekte — Aufklärungsbögen, Gesundheitsinformationen, Entscheidungshilfen — sind im Prozessmodell noch nicht explizit abgebildet. Dies ist ein offener Punkt, der einer eigenständigen Modellierung bedarf (vgl. Kap. 4.4, Querschnittsthema).

---

### 3.3 Datenobjekte, Informationsdomänen, Datenräume und Akteure

#### Datenobjekte

Prozessschritte stehen in Bezug zu Datenobjekten: Manche erzeugen, verändern oder löschen sie (Lebenszyklus), andere stellen sie lediglich bereit, nutzen oder zeigen sie an, ohne den Lebenszyklus zu verändern. Datenobjekte sind die zentralen Informationseinheiten des Modells. Beispiele: Terminanfrage, Überweisung, Anamnese, Diagnose, Medikationsplan, Pflegedokumentation, Arztbrief.

Die Zuordnung der analysierten Prozessschritte zu ihren Datenobjekten ist in Kapitel 4.3 dargestellt.

#### Informationsdomänen

Die Datenobjekte lassen sich zu stabilen **Informationsdomänen** verdichten. Diese Domänen sind systemunabhängig und bilden die Grundlage für eine interoperable Architektur:

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
| Kommunikation | Nachrichten, Rückfragen — unabhängig vom Übertragungsweg |
| Nachsorge | Entlassungsplan, Überleitungsbogen, AHB-Antrag |
| Verlauf | PROMs, Verlaufsdokumentation |
| Dokumente | Arztbrief, Entlassbericht, Gesundheitsinformationen |

#### Datenräume

Die im Prozess entstehenden Datenobjekte können in unterschiedlichen **Datenräumen** auftreten:

| Datenraum | Beschreibung |
|---|---|
| Patientenportal | Patientenzentrierter Zugang zu Informationen und Kommunikation |
| Versorgungssysteme | Systeme der Leistungserbringer — z. B. KIS, PVS |
| ePA | Bundesweite, sektorenübergreifende persönliche Patientenakte |
| EHDS | Europäischer Gesundheitsdatenraum — länderübergreifende Verfügbarkeit und transaktionaler Austausch; Datenobjekte werden hier durchgeleitet, nicht dauerhaft gespeichert (z. B. MyHealth@EU) |

Wie Datenobjekte selbst können auch Datenräume **persistent** oder **transient** sein: Versorgungssysteme und ePA speichern Datenobjekte dauerhaft; der EHDS ist primär ein Transitraum — Daten werden ausgetauscht, nicht gespeichert. Kein Datenraum ist führend. Die Architektur folgt nicht einem Systemfluss, sondern einer Informationsverteilung über Datenräume.

#### Akteure

Folgende Akteure wurden im Prozessmodell identifiziert:

| Akteur | Rolle im Patientenpfad |
|---|---|
| Patient / Angehörige | Zentraler Akteur; erzeugt Datenobjekte, empfängt Informationen, trifft Entscheidungen |
| Krankenhausarzt | Diagnose, Behandlung, Dokumentation, Entlassung |
| Niedergelassener Arzt | Einweisung, Nachversorgung, Kommunikation mit Klinik |
| Therapeuten | Physiotherapie, Ergotherapie, Logopädie und weitere — Behandlung und Dokumentation |
| Pflege (Krankenhaus) | Pflegeassessment, Pflegedokumentation, Entlassungsplanung |
| Pflegeeinrichtung | Nachversorgung, Übernahme aus dem Krankenhaus, Pflegedokumentation |
| Verwaltung | Administrative Prozesse, Fallanlage, Terminmanagement |
| Sozialdienst | Entlassungsplanung, Überleitung, AHB-Beantragung |
| Kostenträger / Krankenkasse | Genehmigung, Abrechnung, Versichertenstammdaten |
| Ersteller von Gesundheitsinformationen | Evidenzbasierte Patienteninformationen zu Diagnosen, Behandlungen und Prozeduren — Entscheidungsunterstützung für Patienten (§ 139a SGB V) |

Die Auflistung ist beispielhaft — weitere Akteure (z. B. Rettungsdienst, Apotheke, EHDS-Teilnehmer) können je nach Prozessschritt relevant sein. Patientenportal und Zuweiserportal adressieren unterschiedliche Akteure und Anwendungsfälle.

---

### 3.4 Entwicklung eines interaktiven Prozessschaubilds

Parallel zur inhaltlichen Arbeit hat die Arbeitsgruppe ein **interaktives Prozessschaubild** entwickelt, das alle 25 Prozessschritte mit ihren Attributen (Phase, Akteure, Datenobjekte, Informationsdomäne, Datenräume, Rechtsgrundlagen, Ist-Analyse) visualisiert und filterbar macht.

Das Tool ist als statische HTML-Anwendung ohne externe Abhängigkeiten realisiert und steht allen AK-Mitgliedern über GitHub Pages zur Verfügung. Die Datenpflege erfolgt über einen integrierten Editor, der Änderungen direkt in das Datenmodell zurückschreiben kann.

Das Schaubild erfüllt zwei Funktionen: Es ist Arbeitswerkzeug für die Gruppe (Ist-Analyse, Lückenidentifikation) und kommunikatives Hilfsmittel für die Präsentation der Ergebnisse nach außen.

---

## 4. Problemstellung und Herausforderungen

### 4.1 Systemrollen und Verantwortlichkeiten

*[Platzhalter — Beschreibung der Rollen von ePA, KIS und Patientenportal gemäß Agenda-Entwurf]*

### 4.2 Internationale Perspektive

*[Platzhalter — EHDS, Portale und ePAs in anderen Ländern, z. B. Dänemark, Estland, Niederlande]*

### 4.3 Prozessüberblick

Die Arbeitsgruppe hat im Rahmen von drei Unterarbeitsgruppen (UAG) — je eine für jede Phase des Patientenpfads — 12 der 25 Prozessschritte im Detail analysiert. Die Prozessschritte wurden nach Relevanz für den Patientenpfad sowie ihrer Abhängigkeit zu Patientenportalen und ePA aus einer ursprünglichen Longlist von über 80 Schritten ausgewählt. Die UAGs haben aus dieser Vorauswahl jeweils eigenständig bestimmt, welche Schritte sie vertieft betrachten — und dabei unterschiedliche Herangehensweisen erprobt: von der schrittweisen 1:1-Analyse über eine methodenkritische Auswahl bis hin zur thematischen Aggregation. Die so gewonnenen Erkenntnisse bilden die Grundlage für die Handlungsempfehlungen in Kapitel 5.

Die folgende Übersicht zeigt die analysierten Prozessschritte mit ihren zentralen Datenobjekten und Akteuren. Die vertiefte Betrachtung mit Ist-Zustand, Lücken und Use Cases folgt in Kapitel 4.4.

#### Phase 1: Vor dem Krankenhaus

| Nr. | Prozessschritt | Akteur(e) | Datenobjekt | Forderungsbezug |
|---|---|---|---|---|
| 1 | Termin anfragen / buchen | Patient, Verwaltung | Terminanfrage / Terminbestätigung | Verzeichnisdienst / Findbarkeit |
| 2 | Überweisung / Einweisung bereitstellen | Niedergelassener Arzt, Patient | Überweisung / Einweisung | Elektronische Einweisung (eEinweisung) |
| 3 | Stammdaten erfassen / aktualisieren | Patient, Verwaltung | Patientenstammdaten | Gesundheits-ID / EUDI-Wallet |
| 4 | Vorbefunde bereitstellen | Patient, Niedergelassener Arzt | Vorbefunde / Fremdbefunde | TI-Zugriff / PoPP-Modul |
| 5 | Anamnesebogen ausfüllen | Patient | Anamnese | Anamnesedaten strukturiert in ePA (ePKA) |
| 6 | Einwilligungen erteilen | Patient | Einwilligungserklärung / Widerspruch | Consent Management / QES |

#### Phase 2: Im Krankenhaus

| Nr. | Prozessschritt | Akteur(e) | Datenobjekt | Forderungsbezug |
|---|---|---|---|---|
| 7 | Digitaler Check-in | Patient, Verwaltung | Check-in Bestätigung | ISiK-Schnittstellen / Portalintegration |
| 8 | Administrative Aufnahme | Verwaltung | Patientenfall / Fallakte | ISiK-Schnittstellen / ePA-Portal-Integration |
| 13 | Bereitstellung ausgewählter Informationen im Portal | Krankenhausarzt, Verwaltung | Laborwerte / Befunde im Portal | Strukturierte Daten / Kritische Informationen |

#### Phase 3: Nach dem Krankenhaus

| Nr. | Prozessschritt | Akteur(e) | Datenobjekt | Forderungsbezug |
|---|---|---|---|---|
| 19 | Bereitstellung Entlassdokumente | Krankenhausarzt, Verwaltung | Arztbrief / Entlassbericht | Portal-Differenzierung (Patienten- vs. Zuweiserportal) |
| 20 | Bereitstellung Medikationsplan | Krankenhausarzt | Medikationsplan | Medikation: verbindlicher Referenzdatensatz |
| 21 | Bereitstellung Dokumente für ePA | Arzt, Verwaltung | Strukturierte Datenobjekte in der ePA | Konsequente ePA-Befüllung / EEHRxF |

### 4.4 Prozesse mit TI-Beteiligung — Ist-Analyse und Use Cases

Für die in Kapitel 4.3 ausgewiesenen Prozessschritte wurde eine strukturierte Ist-Analyse durchgeführt: Was existiert heute? Wo liegen die Lücken? Jede Analyse wird durch einen Use Case untermauert — eine konkrete Situation aus dem Versorgungsalltag, die zeigt, wo standardisiertes Handeln heute fehlt oder scheitert. Ein Use Case ist kein Prozessschritt: Der Prozessschritt beschreibt das Modell — der Use Case illustriert an einem konkreten Beispiel, wo und warum Handlungsbedarf besteht. Die Use Cases sind die Grundlage für die in Kapitel 5 formulierten Handlungsempfehlungen.

---

#### Schritt 1: Termin anfragen / buchen

**Ist-Zustand**

Krankenhausportale bieten heute Terminbuchungsfunktionen an — teils als eigenständige Lösungen, teils über Terminservicedienste. Mit ISiK Terminplanung und HL7 FHIR Appointment existieren Standards für die strukturierte Abbildung von Terminen. Diese sind jedoch nicht flächendeckend implementiert und werden teils nur gegen hohen Aufpreis angeboten. In einigen Häusern ist die Integration zwischen Portal und KIS bereits umgesetzt.

**Lücke**

Die Lücke liegt in der Identifikation: Der Patient ist beim Termin noch nicht eindeutig identifiziert — eine Verknüpfung mit bestehenden Stammdaten oder der ePA ist zu diesem Zeitpunkt nicht möglich. Beim Termin erfasste Informationen (Grund, Vorgeschichte) werden nicht strukturiert in den weiteren Prozess überführt.

**Use Case**

Ein Patient bucht über das Portal einen Termin für eine geplante Hüftoperation. Das System kennt ihn nicht — er muss sich erneut registrieren und seine Daten eingeben, obwohl er zwei Jahre zuvor Patient desselben Hauses war. Die beim Termin erfasste Beschwerdeschilderung landet nirgends strukturiert: sie taucht weder im KIS noch in der ePA auf. Beim nächsten Prozessschritt beginnt alles von vorn.

**Forderung**

Gesundheits-ID (inkl. EUDI-Wallet) als frühzeitige Identifikation; erfasste Informationen strukturiert in den weiteren Patientenpfad überführen; durchgängige FHIR-Integration zwischen Portal und KIS als Mindeststandard (ISiK Terminplanung) (→ Kap. 5, kurzfristig)

---

#### Schritt 2: Überweisung / Einweisung bereitstellen

**Ist-Zustand**

Die Überweisung und Einweisung existieren heute überwiegend als Papier oder PDF — ein klassischer Medienbruch. Mit der eÜberweisung (KBV) ist ein erster elektronischer Standard im Aufbau. HL7 FHIR ServiceRequest und KBV FHIR-Basisprofile bieten eine strukturierte Grundlage.

**Lücke**

Die Einweisung löst keinen automatischen Zugriff auf die ePA aus. Enthaltene strukturierte Informationen (Diagnose, Fragestellung) erreichen das Krankenhaus nicht maschinenlesbar und müssen manuell ins KIS übertragen werden.

**Use Case**

Der Hausarzt stellt eine Einweisung aus und druckt sie aus. Der Patient bringt das Papier ins Krankenhaus. Die Verwaltung tippt die ICD-Diagnose manuell ins KIS ab — Übertragungsfehler inklusive. Das Krankenhaus hat keinen Zugriff auf die ePA des Patienten, weil die Einweisung keinen automatischen Berechtigungsauslöser darstellt. Vorbefunde, die im Haus des Hausarztes digital vorliegen, bleiben unzugänglich.

**Forderung**

Elektronische Einweisung (eEinweisung); ePA-Zugriff ab Einweisung; Auffindbarkeit von Leistungserbringern im VZD verbessern — einschl. Verweis auf bestehende sektorale Arbeitsgruppen der gematik (→ Kap. 5, mittelfristig)

---

#### Schritt 3: Stammdaten erfassen / aktualisieren

**Ist-Zustand**

Mit dem VSDM existiert eine funktionierende Infrastruktur für Versichertenstammdaten. Meldeadresse und Versicherungsstatus sind über die Gesundheitskarte abrufbar. ISiK Basismodul und IHE PIX/PDQ bieten Standards für die strukturierte Patientenidentifikation.

**Lücke**

Angaben am Aufnahmeschalter stimmen häufig nicht mit den Daten auf der Gesundheitskarte überein — eine automatische Aktualisierung des Stammsatzes findet nicht statt. Für die Portalnutzung relevante Felder fehlen im VSDM: E-Mail, Telefon, Hausarzt inkl. KIM-Adresse. Der Patient wird an mehreren Stellen neu erfasst, statt auf einen gemeinsamen Datensatz zuzugreifen.

**Use Case**

Eine Patientin ist umgezogen. Die Gesundheitskarte enthält noch die alte Adresse. Die Verwaltung korrigiert die Anschrift im KIS manuell. Das Patientenportal hat weiterhin die alte Adresse — beide Systeme sind nicht synchronisiert. Beim nächsten Kontakt gibt es erneut Inkonsistenz. Die E-Mail-Adresse, über die das Portal kommuniziert, ist im VSDM nicht vorgesehen.

**Forderung**

Gesundheits-ID / EUDI-Wallet; einmalige Stammdatenerfassung (→ Kap. 5, kurzfristig)

---

#### Schritt 4: Vorbefunde bereitstellen

**Ist-Zustand**

Mit VSDM++ (Entitlement per SMC-B-signiertem VSDM-Prüfnachweis) ist die ePA ab dem ersten institutionellen Kontakt grundsätzlich zugänglich; perspektivisch wird dieser Nachweis durch PoPP (Proof of Patient Presence) abgelöst. Patientenportale bieten Upload-Funktionen für Dokumente. Für die Kategorisierung von Dokumenten in der ePA sind IHE class code und type code verpflichtend; die Klinische Dokumentenliste (KDL) bietet darüber hinaus eine detailliertere Klassifikation, ist aber bisher optional — die Mapping-Tabellen im ePA-ILF sind Empfehlungen, keine Pflicht.

**Lücke**

Der Zugriff auf die ePA ist erst ab dem ersten institutionellen Kontakt möglich — nicht bereits bei Einweisung oder Überweisung. PoPP (Proof of Patient Presence) könnte im Kontext von Patientenportalen einen früheren Zugriff ermöglichen, ist aber noch nicht etabliert. Bereitgestellte Dokumente liegen überwiegend unstrukturiert vor (PDF).

**Use Case**

Ein Patient hat letzte Woche beim Kardiologen ein EKG machen lassen. Das Ergebnis liegt beim Kardiologen als PDF. Das aufnehmende Krankenhaus kann noch nicht auf die ePA zugreifen — der erste institutionelle Kontakt findet erst beim Check-in statt. Der Patient bringt einen Ausdruck mit, der gescannt und als weiteres PDF abgelegt wird. Die darin enthaltenen Messwerte stehen für eine automatisierte Auswertung nicht zur Verfügung. Dabei gilt: Wäre ein ePA-Zugriff bereits möglich, könnten Dokumente und strukturierte Datenobjekte, die dort bereits vorliegen, direkt abgerufen werden — ein nochmaliger Upload via Portal wäre nicht nötig.

**Forderung**

PoPP-Modul im Portal; frühzeitiger ePA-Zugriff (→ Kap. 5, kurzfristig)

---

#### Schritt 5: Anamnesebogen ausfüllen

**Ist-Zustand**

ISiK Stufe 6 führt mit dem Formular-Modul einen Standard für digitale Anamnese ein. HL7 FHIR QuestionnaireResponse ist ein reifer internationaler Standard. In der Praxis findet die Anamnese heute überwiegend in der medizinischen Aufnahme statt — digital in KIS-Systemen oder auf Papier.

**Lücke**

Der Anamneseprozess beginnt an jeder Sektorgrenze neu: Patientinnen und Patienten geben dieselben Informationen beim Hausarzt, beim Facharzt und im Krankenhaus wiederholt an. Das Datenobjekt „Anamnese" wird nicht weitergereicht und verfeinert, sondern bei jedem Akteur neu erzeugt.

**Use Case**

Eine Patientin füllt vor der stationären Aufnahme digital einen Anamnesebogen im Patientenportal aus. Drei Wochen zuvor hat sie denselben Prozess beim einweisenden Facharzt durchlaufen — ähnliche Fragen, anderes System, keine Verbindung. Das Krankenhaus kann den Facharzt-Bogen nicht lesen, weil kein gemeinsamer Standard genutzt wird. Das Ergebnis: doppelte Arbeit, mögliche Widersprüche, Zeitverlust bei der Aufnahme.

**Forderung**

Anamnesedaten als strukturiertes Datenobjekt in der ePA — nicht als Dokument, sondern abrufbar, bestätigbar, erweiterbar; einmal erheben, sektorenübergreifend verfeinern (→ Kap. 5, mittelfristig/langfristig)

---

#### Schritt 6: Einwilligungen erteilen

**Ist-Zustand**

Einwilligung und Widerspruch sind eigenständige Datenobjekte mit unterschiedlicher rechtlicher Wirkung. Es gibt zwei Arten, die das Patientenportal berühren: erstens die datenschutzrechtliche Einwilligung bzw. der Widerspruch — gegen Zugriff und Befüllung der ePA — der Upload-Widerspruch in der Leistungserbringereinrichtung ergibt sich aus §§ 347/348 SGB V, der Widerspruch gegenüber der Krankenkasse aus § 342 SGB V; die Umsetzung des Upload-Widerspruchs wurde an die Krankenhaussysteme (KIS) delegiert — gegen Sekundärnutzung (z. B. MII Broad Consent für Forschungszwecke), gegen Datenweitergabe an einzelne Leistungserbringer oder Datenkategorien. Zweitens die medizinrechtliche Einwilligung in Behandlungsmaßnahmen — Aufklärungsbögen und Behandlungsverträge, die das Portal dem Patienten bereits vor dem Krankenhausbesuch zur Verfügung stellen kann, damit er sie in Ruhe liest und vorbereitet. Die Finalisierung und Unterschrift erfolgt dann bei der Aufnahme (vgl. Schritt 8). HL7 FHIR Consent ist als Standard für strukturierte Einwilligungsdaten vorhanden, wird aber nicht durchgängig eingesetzt.

**Lücke**

Ein einrichtungsübergreifendes, standardisiertes Consent-Management fehlt. Die verschiedenen Widerspruchsformen sind heute nicht einheitlich abgebildet: Widersprüche gegen den ePA-Zugriff sind zentral im Aktensystem implementiert; in der Leistungserbringereinrichtung sind lediglich Upload-Widersprüche sowie die explizite Einwilligung zur Übermittlung von Ergebnissen gendiagnostischer Untersuchungen (GenDG) relevant. Krankenhausportale sind in diesen Prozess nicht eingebunden, obwohl sie die natürliche Schnittstelle für das Einwilligungs- und Widerspruchsmanagement des Patienten wären — sowohl für die datenschutzrechtliche als auch für die medizinrechtliche Dimension.

**Use Case**

Eine Patientin möchte vor ihrer geplanten stationären Aufnahme ihren ePA-Zugriff regeln: Sie möchte das aufnehmende Krankenhaus berechtigen, aber eine bestimmte Datenkategorie sperren. Das Portal bietet keine entsprechende Funktion. Sie wird an den Aufnahmeschalter verwiesen — dort kennt die Verwaltung den Vorgang nicht, verweist ans KIS-System, das nur vor Ort bedienbar ist. Die Einwilligung wird handschriftlich auf einem Formular festgehalten. Beim nächsten Aufenthalt beginnt der Prozess von vorn.

**Forderung**

Einheitliches Consent Management für datenschutzrechtliche und medizinrechtliche Einwilligungen; Portal als Schnittstelle für den Patienten; QES über EUDI-Wallet oder GesundheitsID (→ Kap. 5, kurzfristig/langfristig)

---

#### Schritt 7: Digitaler Check-in

**Ist-Zustand**

Krankenhäuser bieten zunehmend digitale Check-in-Möglichkeiten über das Portal an — Bestätigung der Anwesenheit, Aktualisierung von Stammdaten, Übergabe vorbereiteter Unterlagen. Mit HL7 FHIR Encounter und ISiK Basismodul existieren Standards für die Fallanlage und Patientenidentifikation. In einigen Häusern ist der digitale Check-in bereits mit dem KIS verbunden.

**Lücke**

Die Integration zwischen Portal-Check-in und KIS-Fallanlage ist nicht standardisiert. Der Check-in im Portal hat häufig keinen direkten Effekt auf den Verwaltungsprozess — eine parallele Erfassung am Schalter bleibt erforderlich. Beim Check-in könnten bereits vorbereitete Einwilligungen und Anamnesedaten übergeben werden; dieser Übergang ist heute nicht strukturiert geregelt.

**Use Case**

Ein Patient checkt über das Portal ein und bestätigt seine Anwesenheit digital. Das Portal zeigt eine Bestätigungsseite — aber das KIS weiß davon nichts. Die Verwaltung erfasst die Ankunft manuell am Schalter, weil die Systeme nicht integriert sind. Der digitale Check-in ist aus Sicht des Patienten vorhanden, hat aber keinen Effekt auf den Verwaltungsprozess.

**Forderung**

ISiK Basismodul als Standard für die Portal-KIS-Integration beim Check-in; FHIR-Integration als Vergabe- und Zulassungskriterium (→ Kap. 5, kurzfristig)

---

#### Schritt 8: Administrative Aufnahme

**Ist-Zustand**

Die administrative Aufnahme umfasst die Finalisierung von Einwilligungen und Behandlungsverträgen, die vor dem Besuch im Portal vorbereitet wurden (vgl. Schritt 6). Digitale Aufklärungsprozesse sind in Krankenhäusern vorhanden, häufig über spezialisierte Drittsysteme. Einige Häuser ermöglichen bereits die digitale Unterzeichnung von Aufklärungsbögen. Die relevanten Rechtsgrundlagen sind bekannt und werden umgesetzt.

**Lücke**

Einwilligungsdokumente sind nicht standardisiert. Drittsysteme verursachen hohe Kosten. Die erzeugten Dokumente sind meist PDFs — keine strukturierten, maschinenlesbaren Daten. Aufklärungsbögen und Informationsmaterialien, die im Kontext der Einwilligungserteilung eingesetzt werden, liegen nicht als strukturierte Datenobjekte vor — weder in der ePA verfügbar noch für Folgesysteme zugänglich.

**Use Case**

Bei der Aufnahme unterschreibt ein Patient einen Behandlungsvertrag auf einem Tablet. Das Drittsystem des Krankenhauses speichert das Ergebnis als PDF im KIS. Das nächste Krankenhaus nutzt ein anderes System — neue Formulare, neue Unterschriften. Die strukturierten Informationen aus der Einwilligung (welche Eingriffe, welche Bedingungen) stehen keinem Folgesystem zur Verfügung.

**Forderung**

Einheitlicher technischer Standard für Einwilligungsdokumente; QES als Zielstandard (→ Kap. 5, kurzfristig/mittelfristig)

---

#### Schritt 13: Bereitstellung ausgewählter Informationen im Portal

**Ist-Zustand**

Im heutigen Ist-Zustand gilt das KIS als führendes System für medizinische Dokumentation; von dort werden Daten an Portal, ePA und Archiv weitergeleitet. Für Labordaten existieren etablierte Standards (HL7v2, FHIR, LOINC). Patientenportale stellen heute Befunde und Berichte bereit, häufig als PDF.

**Lücke**

Doppelte Datenbereitstellung in Portal und ePA erzeugt Redundanz und Inkonsistenz: Dieselben Befunde werden parallel in zwei Systemen abgelegt, ohne dass eine gemeinsame Quelle existiert. Die ePA-Versionierung für vorläufige Dokumente ist unzureichend — welche Version aktuell gilt, ist für alle Beteiligten unklar.

Daneben fehlt eine Workflow-Steuerung für ethisch sensible Informationen. Bei lebensverändernden Diagnosen darf eine automatische Bereitstellung nicht ohne vorheriges Arzt-Patienten-Gespräch erfolgen — heute gibt es dafür keinen standardisierten Mechanismus. Laborwerte und Befunde werden zudem ohne kontextuelle Einordnung bereitgestellt; evidenzbasierte Gesundheitsinformationen, die Patienten bei der Interpretation unterstützen könnten (z. B. LOINC-verknüpfte Patientenmerkblätter), sind nicht Teil des Datenobjekts. Beide Lücken — fehlende Konsistenz und fehlende Workflow-Steuerung — verhindern die Automatisierung: Digitalisierung ohne strukturierte Prozesslogik erzeugt wenig Effizienzgewinn.

**Use Case**

Ein Patient sieht im Portal seinen aktuellen Laborbefund — und gleichzeitig in der ePA eine ältere Version desselben Werts. Welche stimmt? Darunter findet sich ein grenzwertiger Befund, der ein Gespräch erfordert. Das System kennt keinen kontrollierten Bereitstellungsprozess: entweder die Werte gehen sofort ins Portal, oder gar nicht. Der Arzt wählt „gar nicht" — der Patient wartet und fragt nach. Beide Probleme — Inkonsistenz zwischen den Systemen und fehlende Workflow-Steuerung — treffen hier gleichzeitig auf.

**Forderung**

Strukturierte Daten in Portal und ePA; Workflow-Steuerung für kritische Befunde; Gesundheitsinformationen als kontextuelle Datenobjekte (LOINC-Verknüpfung) (→ Kap. 5, mittelfristig)

---

#### Schritt 19: Bereitstellung Entlassdokumente

**Ist-Zustand**

Arztbrief und Befunde werden nach Entlassung über ePA, Portal und ggf. Post/KIM bereitgestellt. Technische Standards für die ePA sind definiert (IHE XDS). Das Portal ist herstellerabhängig umgesetzt.

**Lücke**

Es fehlt eine verbindliche Vorgabe, welches Dokument in welchem Zustand (vorläufig / final) wohin gehört. Der Lebenszyklus von Dokumenten — wann wird ein vorläufiger Arztbrief durch den finalen ersetzt, wer wird informiert — ist nicht geregelt. Ergänzende Gesundheitsinformationen — etwa zu Diagnosen oder Verhaltensempfehlungen nach der Entlassung — sind kein Bestandteil des standardisierten Entlassdatensatzes.

**Use Case**

Ein Patient erhält nach der Entlassung einen vorläufigen Arztbrief im Portal. Zehn Tage später ist der finale Arztbrief fertig. Er liegt in der ePA — aber nicht mehr im Portal. Der Hausarzt hat eine Version per KIM bekommen, der Kardiologe eine andere. Keine der vier Parteien kann sicher sein, mit der aktuellen Version zu arbeiten.

**Forderung**

Verpflichtende ePA-Portal-Integration; Vorgaben zu Dokumentenstatus und -ablage (→ Kap. 5, kurzfristig/mittelfristig)

---

#### Schritt 20: Bereitstellung Medikationsplan

**Ist-Zustand**

Medikationsplan und elektronische Medikationsliste (eML) existieren in der ePA und als Ausdruck. Die ePA kann als PDF/A oder XHTML abgerufen werden sowie per FHIR API. Standards sind vorhanden (KBV Medikationsplan, FHIR MedicationStatement). Das KIS führt eine eigene Medikationsliste.

**Lücke**

Es fehlt eine Harmonisierung über Systeme und Sektoren hinweg. Übertragungswege, die eine automatisierte Verarbeitung ermöglichen, sind nicht durchgängig etabliert. Welche Version des Medikationsplans die aktuell gültige ist, bleibt unklar.

**Use Case**

Ein Patient verlässt das Krankenhaus mit einem aktualisierten Medikationsplan. Der Hausarzt hat seine eigene Version aus dem letzten Quartal. Die Apotheke hat eine dritte, die ePA eine vierte. Alle vier Versionen weichen voneinander ab. Niemand hat die Autorität — und kein System hat die Logik — eine davon als verbindlich zu erklären. Das Risiko von Wechselwirkungen und Dosierungsfehlern ist real.

**Forderung**

Medikation als verbindlicher Referenzdatensatz mit klarer Autorenschaft; laut GeDIG-Referentenentwurf künftig nur noch ein FHIR-basierter eMP in der ePA — für Versicherte ohne ePA muss der eMP als strukturiertes Datenobjekt übermittelt werden können (z. B. per KIM oder TI-Messenger); europaweit einheitliche strukturierte Medikationsliste (→ Kap. 5, kurzfristig/mittelfristig)

---

#### Schritt 21: Bereitstellung Dokumente für ePA

**Ist-Zustand**

Die ePA 3.0 ist technisch verfügbar. Spezifikationen für Dokumente und Medikationsliste sowie der gesetzliche Rahmen sind vorhanden. FHIR und IHE-Standards sind definiert. In der Praxis werden Krankenhäuser zunehmend verpflichtet, Daten in die ePA einzustellen.

**Lücke**

Was eingestellt wird, sind überwiegend Dokumente — PDFs, Scans, unstrukturierte Berichte. Strukturierte Datenobjekte, die maschinenlesbar und automatisiert weiterverarbeitbar wären, sind die Ausnahme. Die vorhandenen Standards (FHIR, IHE) werden nicht flächendeckend genutzt, weil KIS-Systeme die entsprechenden Exportformate nicht oder nur gegen Aufpreis unterstützen. Das Versprechen der ePA — strukturierte, sektorenübergreifend nutzbare Daten — wird damit nicht eingelöst. Fragen des Consent-Managements beim ePA-Zugriff sowie der Umgang mit ethisch sensiblen Befunden sind eigenständige Herausforderungen, die in den Schritten 6 und 13 behandelt werden.

**Use Case**

Ein Krankenhaus möchte nach der Entlassung den Befundbericht strukturiert in die ePA schreiben — als FHIR-Ressource, nicht als PDF. Das KIS-System unterstützt den FHIR-Export zwar grundsätzlich, aber nicht in dem von der ePA erwarteten Profil. Der IT-Dienstleister nennt eine Umsetzungszeit von sechs Monaten und einen fünfstelligen Betrag. Das Krankenhaus stellt stattdessen wieder ein PDF ein. Der Patient hat seine Daten in der ePA — aber nicht als Daten.

**Forderung**

Konsequenter Ausbau strukturierter Datenformate in der ePA auf Basis von FHIR und EEHRxF; verbindliche Profilierungen für KIS-Hersteller; strukturierte ePA-Befüllung als Vergabe- und Zulassungskriterium (→ Kap. 5, mittelfristig)

---

#### Querschnittsthema: Patientenberatung und Gesundheitsinformationen

*Hinweis: Das IQWiG hat im Rahmen der Konsultation darauf hingewiesen, dass Patientenberatung und -aufklärung im aktuellen Modell unterbelichtet sind. Die folgende Darstellung ordnet das Thema in den methodischen Rahmen des AK ein. Eine Entscheidung über die weitere Behandlung — insbesondere die Frage der Modellierung als eigenständiger Prozessschritt — obliegt dem Plenum (vgl. Plenum-Hinweis am Ende dieses Abschnitts).*

Patientenberatung und Aufklärung sind keine isolierten Ereignisse, sondern begleiten den gesamten Patientenpfad: vor der Einwilligung, bei der Befundübergabe, im Entlassungsgespräch. Die dabei eingesetzten Datenobjekte — Aufklärungsbögen, evidenzbasierte Patienteninformationen, Entscheidungshilfen — sind heute nicht strukturiert abgebildet.

**Ist-Zustand**

Aufklärungsunterlagen existieren in Krankenhäusern überwiegend als Papierformulare oder unstrukturierte PDFs. Evidenzbasierte Gesundheitsinformationen — z. B. von gesundheitsinformation.de (IQWiG, § 139a SGB V) — stehen zwar öffentlich zur Verfügung, sind aber weder mit Diagnosen und Befunden verknüpft noch in der ePA verfügbar. Eine LOINC-basierte Verknüpfung von Laborwerten mit kontextuellen Patienteninformationen ist technisch möglich, aber nicht etabliert.

**Lücke**

Gesundheitsinformationen und Entscheidungshilfen sind nicht als Datenobjekte im Sinne des Prozessmodells definiert. Sie werden weder in der ePA gespeichert noch als Teil des Entlassdatensatzes übergeben. Der Patient erhält sie situativ — aber nicht strukturiert, nicht nachvollziehbar dokumentiert und nicht mit seinen medizinischen Daten verknüpft.

**Use Case**

Eine Patientin erhält im Portal ihre Laborbefunde — darunter ein erhöhter TSH-Wert. Die Zahl erscheint ohne Kontext. Im Portal gibt es keinen Link zu einer verständlichen Erläuterung, keine Einordnung in Normwerte, keinen Hinweis auf nächste Schritte. Die Patientin googelt — und landet auf einer kommerziellen Seite. Eine LOINC-verknüpfte, evidenzbasierte Information des IQWiG wäre verfügbar — aber nicht eingebunden.

**Forderung**

Gesundheitsinformationen als strukturierte Datenobjekte definieren; LOINC-basierte Verknüpfung mit Befunden und Diagnosen; Verfügbarkeit in der ePA und im Portal (→ Kap. 5, mittelfristig)

---

> **Hinweis für das Plenum — Option: Eigenständiger Prozessschritt**
>
> Das IQWiG schlägt vor, „Patient beraten und aufklären, Informationen zur Verfügung stellen" als expliziten Schritt in das Prozessmodell aufzunehmen. Da Beratung und Aufklärung phasenübergreifend stattfinden, wäre entweder ein wiederholter Schritt je Phase oder ein phasenunabhängiger Querschnittsschritt denkbar. Eine solche Aufnahme würde eine Ergänzung des Datenmodells (`patientenpfad_data.js`) erfordern und ggf. eine Renummerierung der betroffenen Schritte nach sich ziehen. Das Plenum wird gebeten zu entscheiden, ob und in welcher Form dieser Schritt modelliert werden soll.

---

## 5. Zentrale Handlungsempfehlungen

*Dieser Abschnitt enthält einen Vorschlag der Unterarbeitsgruppe für die Diskussion im Plenum des AK Patientenportale. Die Handlungsempfehlungen sind nach Zeithorizont gegliedert und beruhen auf der in Kapitel 4.4 dargelegten Ist-Analyse.*

### 5.1 Kurzfristig — Verbesserungen im bestehenden System

Diese Maßnahmen sind ohne grundlegende strukturelle Änderungen umsetzbar und adressieren unmittelbare Hürden im heutigen Betrieb.

- **Frühzeitige Identifikation über Gesundheits-ID ermöglichen** — einschließlich Unterstützung des EUDI-Wallet für eine sichere, einrichtungsübergreifende Anmeldung im Portal.

- **Schneller TI-Zugriff über das Patientenportal** — Integration eines PoPP-Moduls (Proof of Patient Presence) in das Portal, um den Prozess der Anwesenheitsbestätigung auszulösen. Empfang des PoPP-Tokens und der daraus resultierende Zugriff auf TI-Fachdienste (insbesondere ePA, aber auch eRezept und VSDM) erfolgen weiterhin über das KIS.

- **ISiK-Schnittstellen konsequent umsetzen** — ISiK ist als Mindeststandard bereits gesetzlich verankert. Die Umsetzung in der Fläche fehlt: Definierte Schnittstellen auf Basis von ISiK für den modularen Einsatz von Krankenhausportalen — schnellere Einführung, weniger Aufwand, herstellerunabhängig und austauschbar.

- **Konsequente ePA-Befüllung** — Alle für die medizinische Versorgung relevanten Informationen sollen in die ePA eingestellt werden — bevorzugt in strukturierter Form; wo strukturierte Formate noch fehlen, übergangsweise als PDF. Besonderes Augenmerk: Medikation. Es darf nur einen verbindlichen, aktuellen Referenzdatensatz geben.

- **Keine kommerzielle Sekundärnutzung und keine proprietäre Bindung** — Patientendaten, die über Krankenhausportale verarbeitet werden, sind keine Handelsware. Das Krankenhaus bleibt als DSGVO-Verantwortlicher für ihre ordnungsgemäße Verarbeitung zuständig — die Hoheit liegt beim Patienten. Daraus folgt zweierlei: Portal-Anbieter dürfen Patientendaten nicht für eigene Zwecke (Analysen, Benchmarking, kommerzielle Weiterverarbeitung) nutzen — entsprechende Klauseln in Verträgen sind nicht akzeptabel. Portaldaten dürfen zudem nicht in proprietären Systemen eingeschlossen werden — Datenportabilität und Interoperabilität sind Mindestanforderungen an jeden Anbieter.

  > *Hinweis an die AG: Bitte prüfen, ob der Sachverhalt so getroffen wird.*

### 5.2 Mittelfristig — Strukturelle Verbesserungen (2–5 Jahre)

Diese Maßnahmen erfordern Abstimmung zwischen mehreren Akteuren oder Anpassungen an bestehenden Systemen und Standards.

- **Elektronische Einweisung (eEinweisung)** — Umsetzung der eEinweisung analog zur gesetzlich vorgesehenen eÜberweisung: strukturierte Daten, klare Identifikation des auslösenden Leistungserbringers. Die Einweisung soll automatisch einen ePA-Zugriff des aufnehmenden Krankenhauses ermöglichen — ohne weitere Patienteninteraktion.

- **Verzeichnisdienst (VZD) nutzergerecht gestalten** — Abbildung fachlicher Untergruppen in klaren, einheitlichen Strukturen; Findbarkeit so gestalten, dass Nutzerinnen und Nutzer ohne technisches Wissen navigieren können — einschließlich der Adressierbarkeit über den TI-Messenger (TIM) und Kommunikation im Medizinwesen (KIM). Für die Weiterentwicklung des VZD empfiehlt sich die Einbeziehung bestehender sektoraler Arbeitsgruppen und Workshops der gematik.

- **Medizinische Basisinformationen strukturiert in der ePA** — Anamnesedaten und weitere medizinische Basisinformationen sollen als elektronische Patientenkurzakte (ePKA) strukturiert in der ePA verfügbar sein: abrufbar, bestätigbar, erweiterbar — sektorenübergreifend.

- **Strukturierte Datenformate in der ePA ausbauen** — Konsequenter Ausbau strukturierter Datenformate und -services in der ePA, insbesondere auf Basis von FHIR und dem European Electronic Health Record Exchange Format (EEHRxF). Die verwendeten Formate sollen explizit benannt und verbindlich festgelegt werden. Dies schließt evidenzbasierte Gesundheitsinformationen ein, die strukturiert mit Diagnosen, Befunden und Prozeduren verknüpft werden können — z. B. über LOINC-Codes (§ 395 SGB V i. V. m. § 139a SGB V).

- **ePA und Portal nutzerfreundlich ins KIS integrieren** — Keine doppelten Aktionen: Einstellung von Daten in ePA und Portal soll über einen gemeinsamen Workflow erfolgen, nicht als separate Schritte.

- **Workflow-Steuerung für kritische Informationen** — Automatische Bereitstellung bestimmter Informationen (z. B. lebensverändernde Diagnosen, Gendiagnostik) darf nur nach vorherigem Arzt-Patienten-Gespräch erfolgen. Hierfür sind system- und prozessübergreifende Workflow-Mechanismen erforderlich.

- **Patientenportal, Zuweiserportal und Entlassmanagement integriert denken** — Eine separate, isolierte Behandlung dieser drei Bereiche ist nicht sachgerecht. Die Integration der Systeme muss möglich sein und muss als Anforderung in Ausschreibungen und Standards verankert werden.

- **Strukturierte Daten als Übergabeformat etablieren** — Alle Player im Anschluss an eine Behandlung sollen strukturierte Datenobjekte empfangen und verarbeiten können — auch ohne ePA als Zwischenspeicher.

- **QES für Behandlungsverträge und Einwilligungen** — Qualifizierte elektronische Signaturen (QES) sollen für Unterschriften unter Behandlungsverträge und Einwilligungserklärungen nutzbar sein — über EUDI-Wallet, GesundheitsID oder BundID, im Portal ebenso wie vor Ort.

### 5.3 Langfristig — Strukturelle Weiterentwicklung

Diese Maßnahmen erfordern grundlegende Änderungen an Infrastrukturen, Gesetzen oder übergreifenden Konzepten.

- **Übergreifendes Consent Management** — Ein einrichtungs- und sektorenübergreifendes Consent Management soll geschaffen werden — idealerweise als eigenständiger Fachdienst, der alle relevanten Einwilligungen und Widersprüche zentral verwaltet. Bestehende Ansätze wie der Broad Consent der Medizininformatik-Initiative (MII) können als Grundlage dienen.

- **Anamnesedaten als strukturierter Service in der ePA** — Anamnesedaten sollen als aktiver Service in der ePA verfügbar sein: auslesen, bestätigen, ändern — durch Patienten und berechtigte Leistungserbringer gleichermaßen. Die Anamnese wird einmal erhoben und sektorenübergreifend verfeinert, nicht neu erzeugt.

---

## 6. Ausblick

*Dieser Abschnitt enthält einen Vorschlag der Unterarbeitsgruppe für die weitere Arbeit des AK Patientenportale. Die Priorisierung und Beauftragung obliegt dem Plenum.*

### 6.1 Weiterentwicklung des interaktiven Prozessschaubilds

Das interaktive Prozessschaubild ist ein lebendiges Arbeitsinstrument. Es kann in weiteren Schritten ausgebaut werden:

- **Vollständige Ist-Analyse** — Die verbleibenden 13 Prozessschritte (Nr. 9–12, 14–18, 22–25) sind methodisch vorbereitet, aber noch nicht mit Ist-Zustand, Lücken und Forderungen befüllt.
- **Standards-Mapping** — Für jeden Prozessschritt soll geprüft werden, welche bestehenden Standards (FHIR, IHE, HL7) die formulierten Anforderungen bereits erfüllen und wo Lücken bestehen.
- **Differenzierung Patientenportal / Zuweiserportal** — Der AK empfiehlt, den Datenraum „Portal" weiter zu differenzieren (vgl. Kap. 3.3).

### 6.2 Offene Punkte

- **Internationale Perspektive vertiefen** — Wie haben andere Länder (Dänemark, Estland, Niederlande) vergleichbare Herausforderungen gelöst? Welche Ansätze sind auf den deutschen Kontext übertragbar?
- **Pilotprozesse definieren** — Zwei bis drei Prozessschritte für eine modellhafte Umsetzung identifizieren, die die erarbeiteten Prinzipien in einen konkreten Proof of Concept überführen.
- **Lebenszyklus von Datenobjekten** — Die Frage, wann ein Datenobjekt als abgeschlossen gilt, wer es archiviert und wer es löscht, wurde bewusst ausgeklammert. Sie ist für eine vollständige Architektur jedoch relevant und sollte in einer späteren Phase adressiert werden.

---

## Änderungshistorie

| Version | Datum | Änderungen |
|---|---|---|
| v0.1 | 2026-06-03 | Grundstruktur; Kap. 3 und 4 ausgearbeitet |
| v0.2 | 2026-06-03 | IQWiG-Feedback eingearbeitet (Patientenberatung, Querschnittsthema, § 395 SGB V) |
| v0.3 | 2026-06-08 | HO-Feedback eingearbeitet (ISiK-Durchsetzung, Ist-Kontext Schritt 13, PDF-Übergangslösung, Datensouveränität neu gefasst) |
| v0.4 | 2026-06-08 | msusky-Feedback eingearbeitet: Grundprinzipien terminologisch geschärft (Datenobjekte, Lebenszyklus, Darstellungsform), Kap. 3.3 Überschrift ergänzt, Auswahlkriterien Prozessschritte neu begründet, einheitliche Zwischenüberschriften Kap. 4.4, Schritt 6 auf Consent Management fokussiert, Schritt 13 zwei Probleme getrennt, Schritt 21 Redundanzen entfernt |
