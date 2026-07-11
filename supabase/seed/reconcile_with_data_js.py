#!/usr/bin/env python3
"""T11-Vorbereitung: Datenabgleich DB (Workgroup 'ak-patientenportale') gegen
den aktuellen Stand von patientenpfad_data.js.

Zweck: Vor einem Cutover (T11) muss geprüft werden, dass die Datenbank exakt
denselben Inhalt zeigt wie die AG heute über den bestehenden Editor pflegt —
NICHT nur den Stand von T03 zum damaligen Migrationszeitpunkt. Dieses Skript
führt KEINE Schreiboperationen aus (reiner Vergleich/Report) und nimmt keine
Änderung an patientenpfad_interaktiv.html/editor.html/data.js vor.

Verwendung:
    python3 reconcile_with_data_js.py

Exit-Code 0: DB und patientenpfad_data.js sind inhaltlich identisch.
Exit-Code 1: mindestens eine Abweichung gefunden (siehe Report auf stdout).

Falls Abweichungen gefunden werden, weil die AG zwischenzeitlich über den
bestehenden Editor weitergepflegt hat: `seed_ak_patientenportale.py` erneut
laufen lassen, um die DB auf den aktuellen Stand zu bringen, dann hier
erneut prüfen.
"""
import sys
from pathlib import Path

import psycopg

sys.path.insert(0, str(Path(__file__).parent))
from seed_ak_patientenportale import ENV_PATH, WORKGROUP_KEY, as_list, load_env, load_source_data  # noqa: E402

# Zuordnung: Feld in patientenpfad_data.js -> (Dimension-Key in der DB, Vergleichsart)
MULTI_SELECT_FIELDS = {
    "dr": "datenraum",
    "akteur": "akteur",
    "objekt": "objekt",
    "gesetze": "gesetz",
    "standards": "standard",
}
SINGLE_SELECT_FIELDS = {
    "phase": "phase",
    "domäne": "domaene",
    "struktur": "struktur",
}
TEXT_FIELDS = {
    "detail": "detail",
    "ist": "ist",
    "luecke": "luecke",
    "forderungen": "forderungen",
}


def fetch_db_steps(cur, workgroup_id: str) -> dict:
    """Liefert {nr: {"titel": ..., "values": {dimension_key: [wert_key, ...] | text}}}."""
    cur.execute(
        """
        select p.nr, p.titel, d.key as dim_key, d.typ, dv.key as value_key, psv.text_value
        from process_steps p
        left join process_step_values psv on psv.process_step_id = p.id
        left join dimensions d on d.id = psv.dimension_id
        left join dimension_values dv on dv.id = psv.dimension_value_id
        where p.workgroup_id = %s
        """,
        (workgroup_id,),
    )
    steps = {}
    for nr, titel, dim_key, typ, value_key, text_value in cur.fetchall():
        step = steps.setdefault(nr, {"titel": titel, "values": {}})
        if dim_key is None:
            continue
        if typ == "text":
            step["values"][dim_key] = text_value or ""
        else:
            step["values"].setdefault(dim_key, set()).add(value_key)
    return steps


def op_codes(op_value) -> set:
    return set(as_list(op_value))


def diff_step(nr: int, source: dict, db_step: dict) -> list:
    problems = []

    if source["titel"] != db_step["titel"]:
        problems.append(f"titel: data.js={source['titel']!r} vs. DB={db_step['titel']!r}")

    for field, dim_key in MULTI_SELECT_FIELDS.items():
        expected = set(as_list(source.get(field)))
        actual = db_step["values"].get(dim_key, set())
        if expected != actual:
            problems.append(f"{field}: data.js={sorted(expected)} vs. DB={sorted(actual)}")

    expected_ops = op_codes(source.get("op"))
    actual_ops = db_step["values"].get("operation", set())
    if expected_ops != actual_ops:
        problems.append(f"op: data.js={sorted(expected_ops)} vs. DB={sorted(actual_ops)}")

    for field, dim_key in SINGLE_SELECT_FIELDS.items():
        expected = source.get(field) or None
        actual_set = db_step["values"].get(dim_key, set())
        actual = next(iter(actual_set)) if actual_set else None
        if expected != actual:
            problems.append(f"{field}: data.js={expected!r} vs. DB={actual!r}")

    for field, dim_key in TEXT_FIELDS.items():
        expected = source.get(field) or ""
        actual = db_step["values"].get(dim_key, "")
        if expected != actual:
            problems.append(f"{field}: unterschiedlich (data.js {len(expected)} Zeichen, DB {len(actual)} Zeichen)")

    return problems


def main():
    env = load_env(ENV_PATH)
    source = load_source_data()
    data = source["data"]

    db_port = env.get("DB_PORT", "5435")
    dsn = f"postgresql://postgres:{env['POSTGRES_PASSWORD']}@localhost:{db_port}/postgres"

    with psycopg.connect(dsn) as conn:
        with conn.cursor() as cur:
            cur.execute("select id from workgroups where key = %s", (WORKGROUP_KEY,))
            row = cur.fetchone()
            if not row:
                print(f"FEHLER: Workgroup '{WORKGROUP_KEY}' existiert nicht in der DB.", file=sys.stderr)
                return 1
            workgroup_id = row[0]
            db_steps = fetch_db_steps(cur, workgroup_id)

    source_by_nr = {s["nr"]: s for s in data}
    only_in_source = sorted(set(source_by_nr) - set(db_steps))
    only_in_db = sorted(set(db_steps) - set(source_by_nr))

    total_problems = 0
    for nr in sorted(set(source_by_nr) & set(db_steps)):
        problems = diff_step(nr, source_by_nr[nr], db_steps[nr])
        if problems:
            total_problems += 1
            print(f"\nSchritt #{nr} ({source_by_nr[nr]['titel']}):")
            for p in problems:
                print(f"  - {p}")

    if only_in_source:
        total_problems += len(only_in_source)
        print(f"\nNur in patientenpfad_data.js, fehlt in DB: {only_in_source}")
    if only_in_db:
        total_problems += len(only_in_db)
        print(f"\nNur in DB, fehlt in patientenpfad_data.js: {only_in_db}")

    if total_problems == 0:
        print(f"Abgleich OK: {len(data)} Prozessschritte in DB und patientenpfad_data.js sind identisch.")
        return 0

    print(f"\n{total_problems} Abweichung(en) gefunden. "
          f"Falls die AG zwischenzeitlich über den bestehenden Editor gepflegt hat: "
          f"seed_ak_patientenportale.py erneut laufen lassen und danach erneut prüfen.")
    return 1


if __name__ == "__main__":
    sys.exit(main())
