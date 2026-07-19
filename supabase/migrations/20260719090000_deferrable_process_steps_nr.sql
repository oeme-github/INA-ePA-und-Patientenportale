-- E08: Drag&Drop für die Reihenfolge der Prozessschritte
--
-- Reihenfolge ändern heißt: mehrere process_steps-Zeilen bekommen in einem
-- Rutsch eine neue nr. Der bestehende unique(workgroup_id, nr)-Constraint
-- (siehe 20260710120000_init_schema.sql) ist NOT DEFERRABLE, d.h. Postgres
-- prüft ihn nach jeder einzelnen Zeile innerhalb eines Statements — bei
-- einem klassischen "zwei Werte tauschen" schlägt das fehl, selbst wenn am
-- Ende des Statements alle nr wieder eindeutig sind (die Zwischen-Nr
-- kollidiert kurzzeitig mit einer noch nicht aktualisierten Zeile).
--
-- Fix: Constraint DEFERRABLE machen. Bei INITIALLY IMMEDIATE (Default) wird
-- er dann statt pro Zeile erst am Ende des jeweiligen Statements geprüft —
-- reicht aus, wenn der Editor die komplette Neusortierung als einen
-- einzigen Bulk-Upsert (POST .../process_steps?on_conflict=id mit
-- Prefer: resolution=merge-duplicates) an PostgREST schickt, was intern ein
-- einzelnes INSERT ... ON CONFLICT DO UPDATE-Statement erzeugt.
--
-- dimension_values.reihenfolge hat keinen entsprechenden Unique-Constraint,
-- dort ist daher keine Migration nötig.

alter table process_steps
  drop constraint process_steps_workgroup_id_nr_key;

alter table process_steps
  add constraint process_steps_workgroup_id_nr_key
  unique (workgroup_id, nr) deferrable initially immediate;
