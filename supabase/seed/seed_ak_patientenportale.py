#!/usr/bin/env python3
"""Seed: heutige patientenpfad_data.js als erste Workgroup 'ak-patientenportale'.

Migriert meta.{domaenen,akteure,datenobjekte,standards,rechtsgrundlagen} zu
dimensions/dimension_values und jeden Prozessschritt aus `data` zu
process_steps/process_step_values. Phase und Datenraum (dr) werden dabei zu
zwei weiteren Dimensionen (keine Sonderfälle mehr), siehe KONTEXT.md,
"Architekturentscheidung Multi-User-Web-Tool".

Idempotent: kann beliebig oft erneut laufen (z.B. nachdem die AG über den
bestehenden Editor weiter an patientenpfad_data.js gearbeitet hat) und
gleicht Dimensionen/Werte/Prozessschritte immer auf den aktuellen Stand der
Datei ab. Liest patientenpfad_data.js live über extract_data_js.mjs ein,
hält also keine eigene Kopie der Inhalte.

Verwendung:
    python3 seed_ak_patientenportale.py
Erwartet den laufenden Stack aus ../docker-compose.yml (db auf localhost:5432)
und liest das DB-Passwort aus ../.env.
"""
import json
import os
import subprocess
import sys
from pathlib import Path

import psycopg

HERE = Path(__file__).parent
ENV_PATH = HERE.parent / ".env"
EXTRACT_SCRIPT = HERE / "extract_data_js.mjs"

WORKGROUP_KEY = "ak-patientenportale"
WORKGROUP_NAME = "AK Patientenportale"


def load_env(path: Path) -> dict:
    env = {}
    for line in path.read_text().splitlines():
        line = line.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        key, _, value = line.partition("=")
        env[key.strip()] = value.strip()
    return env


def load_source_data() -> dict:
    result = subprocess.run(
        ["node", str(EXTRACT_SCRIPT)], capture_output=True, text=True, check=True
    )
    return json.loads(result.stdout)


# (dimension_key, label, typ, ist_navigationsachse, reihenfolge, values)
# values: Liste von (wert_key, label) in Anzeigereihenfolge, oder None
# (dann aus meta[meta_key] übernommen, values = Text selbst als key).
def build_dimension_specs(meta: dict) -> list:
    def from_meta(meta_key):
        return [(v, v) for v in meta[meta_key]]

    return [
        ("phase", "Phase", "single_select", True, 1, [
            ("vor", "Vor dem Krankenhaus"),
            ("im", "Im Krankenhaus"),
            ("nach", "Nach dem Krankenhaus"),
        ]),
        ("datenraum", "Datenraum", "multi_select", True, 2, [
            ("portal", "Patientenportal"),
            ("versorgung", "Versorgungssysteme (KIS/PVS)"),
            ("epa", "elektronische Patientenakte (ePA)"),
            ("ehds", "European Health Data Space (EHDS)"),
        ]),
        ("domaene", "Domäne", "single_select", False, 3, from_meta("domaenen")),
        ("akteur", "Akteur", "multi_select", False, 4, from_meta("akteure")),
        ("objekt", "Datenobjekt", "multi_select", False, 5, from_meta("datenobjekte")),
        ("operation", "Operation", "multi_select", False, 6, [
            ("E", "Erzeugt"),
            ("V", "Verändert"),
            ("G", "Gelöscht"),
        ]),
        ("gesetz", "Rechtsgrundlage", "multi_select", False, 7, from_meta("rechtsgrundlagen")),
        ("standard", "Standard", "multi_select", False, 8, from_meta("standards")),
        ("struktur", "Struktur", "single_select", False, 9, [
            ("unstrukturiert", "Unstrukturiert"),
            ("teilstrukturiert", "Teilstrukturiert"),
            ("strukturiert", "Strukturiert"),
        ]),
        ("detail", "Detail", "text", False, 10, None),
        ("ist", "Ist-Zustand", "text", False, 11, None),
        ("luecke", "Lücke", "text", False, 12, None),
        ("forderungen", "Forderung", "text", False, 13, None),
    ]


def upsert_workgroup(cur) -> str:
    cur.execute(
        """
        insert into workgroups (key, name) values (%s, %s)
        on conflict (key) do update set name = excluded.name
        returning id
        """,
        (WORKGROUP_KEY, WORKGROUP_NAME),
    )
    return cur.fetchone()[0]


def upsert_dimensions(cur, workgroup_id: str, specs: list) -> dict:
    """Legt Dimensionen + Werte an, gibt {dimension_key: {"id": ..., "values": {wert_key: id}}} zurück."""
    result = {}
    for key, label, typ, nav, reihenfolge, values in specs:
        cur.execute(
            """
            insert into dimensions (workgroup_id, key, label, typ, ist_navigationsachse, reihenfolge)
            values (%s, %s, %s, %s, %s, %s)
            on conflict (workgroup_id, key) do update
                set label = excluded.label, typ = excluded.typ,
                    ist_navigationsachse = excluded.ist_navigationsachse,
                    reihenfolge = excluded.reihenfolge
            returning id
            """,
            (workgroup_id, key, label, typ, nav, reihenfolge),
        )
        dim_id = cur.fetchone()[0]
        value_ids = {}
        if values:
            for i, (v_key, v_label) in enumerate(values, start=1):
                cur.execute(
                    """
                    insert into dimension_values (dimension_id, key, label, reihenfolge)
                    values (%s, %s, %s, %s)
                    on conflict (dimension_id, key) do update
                        set label = excluded.label, reihenfolge = excluded.reihenfolge
                    returning id
                    """,
                    (dim_id, v_key, v_label, i),
                )
                value_ids[v_key] = cur.fetchone()[0]
        result[key] = {"id": dim_id, "values": value_ids}
    return result


def upsert_process_step(cur, workgroup_id: str, nr: int, titel: str) -> str:
    cur.execute(
        """
        insert into process_steps (workgroup_id, nr, titel)
        values (%s, %s, %s)
        on conflict (workgroup_id, nr) do update
            set titel = excluded.titel, updated_at = now()
        returning id
        """,
        (workgroup_id, nr, titel),
    )
    return cur.fetchone()[0]


def as_list(value) -> list:
    if value is None:
        return []
    if isinstance(value, list):
        return value
    return [v.strip() for v in str(value).split(",") if v.strip()]


def resolve_or_create_value(cur, dim: dict, dim_key: str, wert_key: str, nr: int) -> str:
    """Wert in einer Auswahllisten-Dimension nachschlagen; falls er in `meta` fehlt
    (z.B. Tippfehler/Sonderfall in patientenpfad_data.js), wird er automatisch
    ergänzt statt Daten stillschweigend zu verlieren – nur mit Warnung."""
    value_id = dim["values"].get(wert_key)
    if value_id is not None:
        return value_id
    print(f"  HINWEIS: Wert '{wert_key}' fehlte in meta-Auswahlliste der Dimension "
          f"'{dim_key}' (Schritt nr={nr}) — als zusätzlicher Wert ergänzt", file=sys.stderr)
    cur.execute(
        """
        insert into dimension_values (dimension_id, key, label, reihenfolge)
        values (%s, %s, %s, coalesce((select max(reihenfolge) + 1 from dimension_values where dimension_id = %s), 1))
        on conflict (dimension_id, key) do update set label = excluded.label
        returning id
        """,
        (dim["id"], wert_key, wert_key, dim["id"]),
    )
    value_id = cur.fetchone()[0]
    dim["values"][wert_key] = value_id
    return value_id


def seed_process_step_values(cur, step_id: str, dims: dict, step: dict):
    cur.execute("delete from process_step_values where process_step_id = %s", (step_id,))

    multi_select_fields = {
        "datenraum": as_list(step.get("dr")),
        "akteur": as_list(step.get("akteur")),
        "objekt": as_list(step.get("objekt")),
        "operation": as_list(step.get("op")),
        "gesetz": as_list(step.get("gesetze")),
        "standard": as_list(step.get("standards")),
    }
    single_select_fields = {
        "phase": step.get("phase"),
        "domaene": step.get("domäne"),
        "struktur": step.get("struktur"),
    }
    text_fields = {
        "detail": step.get("detail"),
        "ist": step.get("ist"),
        "luecke": step.get("luecke"),
        "forderungen": step.get("forderungen"),
    }

    for dim_key, wert_keys in multi_select_fields.items():
        dim = dims[dim_key]
        for wert_key in wert_keys:
            value_id = resolve_or_create_value(cur, dim, dim_key, wert_key, step["nr"])
            cur.execute(
                """
                insert into process_step_values (process_step_id, dimension_id, dimension_value_id)
                values (%s, %s, %s)
                """,
                (step_id, dim["id"], value_id),
            )

    for dim_key, wert_key in single_select_fields.items():
        if not wert_key:
            continue
        dim = dims[dim_key]
        value_id = resolve_or_create_value(cur, dim, dim_key, wert_key, step["nr"])
        cur.execute(
            """
            insert into process_step_values (process_step_id, dimension_id, dimension_value_id)
            values (%s, %s, %s)
            """,
            (step_id, dim["id"], value_id),
        )

    for dim_key, text in text_fields.items():
        if not text:
            continue
        dim = dims[dim_key]
        cur.execute(
            """
            insert into process_step_values (process_step_id, dimension_id, text_value)
            values (%s, %s, %s)
            """,
            (step_id, dim["id"], text),
        )


def main():
    env = load_env(ENV_PATH)
    source = load_source_data()
    meta, data = source["meta"], source["data"]

    dsn = f"postgresql://postgres:{env['POSTGRES_PASSWORD']}@localhost:5432/postgres"
    with psycopg.connect(dsn) as conn:
        with conn.cursor() as cur:
            workgroup_id = upsert_workgroup(cur)
            specs = build_dimension_specs(meta)
            dims = upsert_dimensions(cur, workgroup_id, specs)

            for step in data:
                step_id = upsert_process_step(cur, workgroup_id, step["nr"], step["titel"])
                seed_process_step_values(cur, step_id, dims, step)

        conn.commit()

    print(f"Seed abgeschlossen: Workgroup '{WORKGROUP_KEY}', {len(data)} Prozessschritte, "
          f"{len(specs)} Dimensionen.")


if __name__ == "__main__":
    main()
