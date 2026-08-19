// Liest patientenpfad_data.js (const meta = {...}; const data = [...];) ein und
// gibt {meta, data} als JSON auf stdout aus. Läuft die Datei als echtes JS aus
// (per vm-Modul), statt sie mit Regex zu parsen — robust gegenüber Kommentaren,
// Umlauten in Keys, mehrzeiligen Strings etc. Wird von seed_ak_patientenportale.py
// aufgerufen, damit die Migration immer den aktuellen Stand von
// patientenpfad_data.js abbildet (auch nach weiterer AG-Pflege über den
// bestehenden Editor).
import { readFileSync } from "node:fs";
import vm from "node:vm";
import path from "node:path";
import { fileURLToPath } from "node:url";

const here = path.dirname(fileURLToPath(import.meta.url));
const dataJsPath = path.join(here, "..", "..", "patientenpfad_data.js");
const source = readFileSync(dataJsPath, "utf-8");

const sandbox = {};
vm.createContext(sandbox);
vm.runInContext(source + "\nthis.__result = { meta, data };", sandbox);

process.stdout.write(JSON.stringify(sandbox.__result));
