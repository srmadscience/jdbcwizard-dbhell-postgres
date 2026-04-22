-- 21_pg18_new_features.sql: surface new in Postgres 18.
-- Requires server version >= 18. The opening DO block fails fast otherwise.

SET search_path = dbhell, public;

DO $$
BEGIN
    IF current_setting('server_version_num')::int < 180000 THEN
        RAISE EXCEPTION 'pg_dbhell 21_pg18_new_features requires PG 18+, got %',
            current_setting('server_version');
    END IF;
END;
$$;

-- ---- uuidv7() built-in ---------------------------------------------------
CREATE TABLE pg18_uuidv7 (
    id       uuid PRIMARY KEY DEFAULT uuidv7(),
    created  timestamptz NOT NULL DEFAULT current_timestamp,
    label    text
);
INSERT INTO pg18_uuidv7 (label) VALUES ('a'), ('b'), ('c');

-- ---- Virtual generated columns ------------------------------------------
-- PG 12+ added STORED; PG 18 adds VIRTUAL (computed at read time).
CREATE TABLE pg18_virtual_gen (
    id       bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first    text NOT NULL,
    last     text NOT NULL,
    full_v   text GENERATED ALWAYS AS (first || ' ' || last) VIRTUAL,
    full_s   text GENERATED ALWAYS AS (first || ' ' || last) STORED
);
INSERT INTO pg18_virtual_gen (first, last) VALUES ('Ada', 'Lovelace');

-- ---- Temporal PRIMARY KEY … WITHOUT OVERLAPS and temporal FK ------------
CREATE TABLE pg18_employment (
    emp_id   bigint NOT NULL,
    valid    tsrange NOT NULL,
    dept     text NOT NULL,
    CONSTRAINT pg18_employment_pk
        PRIMARY KEY (emp_id, valid WITHOUT OVERLAPS)
);

CREATE TABLE pg18_employment_event (
    id         bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    emp_id     bigint NOT NULL,
    occurred   tsrange NOT NULL,
    note       text,
    CONSTRAINT pg18_employment_event_fk
        FOREIGN KEY (emp_id, PERIOD occurred)
        REFERENCES pg18_employment (emp_id, PERIOD valid)
);

INSERT INTO pg18_employment VALUES
    (1, '[2020-01-01, 2022-01-01)', 'eng'),
    (1, '[2022-01-01, 2024-01-01)', 'ops'),
    (2, '[2021-06-01, 2025-01-01)', 'eng');

-- ---- NOT NULL NOT VALID + VALIDATE CONSTRAINT ---------------------------
CREATE TABLE pg18_notvalid (
    id  bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    v   integer
);
INSERT INTO pg18_notvalid (v) VALUES (1), (2);
ALTER TABLE pg18_notvalid
    ADD CONSTRAINT v_notnull CHECK (v IS NOT NULL) NOT VALID;
ALTER TABLE pg18_notvalid VALIDATE CONSTRAINT v_notnull;

-- ---- MERGE … RETURNING ---------------------------------------------------
CREATE TABLE pg18_merge_target (
    k  text PRIMARY KEY,
    v  integer NOT NULL
);
INSERT INTO pg18_merge_target VALUES ('a', 1), ('b', 2);

CREATE TABLE pg18_merge_source (
    k  text PRIMARY KEY,
    v  integer NOT NULL
);
INSERT INTO pg18_merge_source VALUES ('b', 20), ('c', 30);

CREATE TABLE pg18_merge_audit (
    op    text,
    k     text,
    old_v integer,
    new_v integer
);

MERGE INTO pg18_merge_target t
USING pg18_merge_source s ON s.k = t.k
WHEN MATCHED THEN
    UPDATE SET v = s.v
WHEN NOT MATCHED THEN
    INSERT (k, v) VALUES (s.k, s.v)
RETURNING merge_action() AS op, s.k, t.v AS new_v;

-- ---- Builtin collation provider ------------------------------------------
CREATE COLLATION pg18_builtin_cuf8 (provider = builtin, locale = 'C.UTF-8');
CREATE TABLE pg18_collated (
    s text COLLATE pg18_builtin_cuf8
);

-- ---- Extended statistics ------------------------------------------------
CREATE STATISTICS pg18_emp_stats (ndistinct, dependencies, mcv)
    ON dept, salary FROM base_emp;
ANALYZE base_emp;
