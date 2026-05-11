# Anleitung: Editor mit GitHub-Speicherung nutzen

Diese Anleitung richtet sich an Personen, die den Patientenpfad-Editor nutzen und Änderungen direkt ins gemeinsame Repository speichern möchten.

---

## Einmaliges Setup (~5 Minuten)

### Schritt 1: GitHub-Account

Du brauchst einen GitHub-Account. Falls noch keiner vorhanden:
→ https://github.com/signup

Teile danach deinen GitHub-Benutzernamen mit dem Repository-Inhaber (`oeme-github`), damit du als Contributor eingetragen werden kannst.

---

### Schritt 2: Personal Access Token erstellen

Der Token ist wie ein Passwort für den Editor – er erlaubt dem Browser, direkt in das Repository zu schreiben.

1. Auf GitHub einloggen
2. Oben rechts auf dein **Profilbild** klicken → **Settings**
3. Links in der Seitenleiste ganz unten: **Developer settings**
4. Links: **Personal access tokens** → **Fine-grained tokens**
5. Klick auf **Generate new token**

**Token-Einstellungen:**

| Feld | Wert |
|---|---|
| Token name | `Patientenpfad Editor` (oder beliebig) |
| Expiration | z.B. 90 Tage oder 1 Jahr |
| Resource owner | `oeme-github` |
| Repository access | **Only select repositories** → `INA-ePA-und-Patientenportale` |

Unter **Permissions** → **Repository permissions**:

| Berechtigung | Wert |
|---|---|
| Contents | **Read and write** |

6. Klick auf **Generate token**
7. Den angezeigten Token **sofort kopieren** – er wird nur einmal angezeigt!

---

### Schritt 3: Token im Editor hinterlegen

1. Den Editor öffnen: [patientenpfad_editor.html](https://oeme-github.github.io/INA-ePA-und-Patientenportale/patientenpfad_editor.html)
2. Oben in der Leiste auf **⚙ GitHub** klicken
3. Den kopierten Token in das Eingabefeld einfügen
4. Auf **Token speichern** klicken

Der Token wird nur in deinem Browser gespeichert (localStorage) – er verlässt deinen Computer nur in Richtung GitHub-API.

---

## Arbeiten mit dem Editor

### Änderungen speichern

1. Im Editor die gewünschten Felder bearbeiten (Schritt öffnen → Formular ausfüllen → **Speichern**)
2. Wenn alle Änderungen fertig sind: oben auf **↑ In GitHub speichern** klicken
3. Kurze Wartezeit (~2 Sekunden)
4. Bestätigung: **✓ In GitHub gespeichert**

Die Änderungen sind sofort für alle sichtbar, die den Viewer aufrufen.

### Was passiert technisch?

Der Editor schreibt die Datei `patientenpfad_data.js` direkt per GitHub API als neuen Commit in den `main`-Branch. Es entsteht ein normaler Git-Commit mit der Nachricht `Daten: Prozessschritte aktualisiert (Editor)`.

---

## Häufige Fragen

**Der Token ist abgelaufen – was tun?**
Einen neuen Token erstellen (Schritt 2 wiederholen) und im Editor hinterlegen (Schritt 3). Der alte Token wird automatisch überschrieben.

**Ich habe den Browser-Cache geleert – Token weg?**
Ja, der Token wird im localStorage gespeichert. Nach einem Cache-Löschen muss der Token erneut eingegeben werden. Falls der ursprüngliche Token noch gilt, kann er direkt wieder eingetragen werden – er muss nicht neu erstellt werden.

**Fehlermeldung „403 Forbidden"?**
Der Token hat keine ausreichenden Berechtigungen oder ist abgelaufen. Neuen Token mit den Berechtigungen aus Schritt 2 erstellen.

**Fehlermeldung „404 Not Found"?**
Der Token wurde möglicherweise für das falsche Repository erstellt. In den GitHub-Einstellungen prüfen, ob `INA-ePA-und-Patientenportale` ausgewählt ist.

**Kann ich parallel mit jemandem bearbeiten?**
Besser nicht gleichzeitig – beim Speichern wird die aktuell im Repository liegende Version überschrieben. Abstimmen, wer gerade bearbeitet.

---

## Lokal ohne GitHub nutzen

Wer den Editor lokal nutzen möchte (ohne GitHub-Token), kann weiterhin **↓ Lokal exportieren** verwenden. Die heruntergeladene `patientenpfad_data.js` muss dann manuell als Commit eingecheckt werden.
