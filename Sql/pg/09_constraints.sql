-- 09_constraints.sql: every constraint flavour Postgres supports.
-- Oracle source: dbhell.sql:148, plus scattered ALTER TABLE ADD CONSTRAINT
-- statements across the corpus.

SET search_path = dbhell, public;

CREATE TABLE parent_tbl (
    id       bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code     text NOT NULL,
    CONSTRAINT parent_code_uq UNIQUE (code)
);

CREATE TABLE child_restrict (
    id         bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    parent_id  bigint NOT NULL,
    CONSTRAINT child_restrict_fk FOREIGN KEY (parent_id)
        REFERENCES parent_tbl (id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE child_cascade (
    id         bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    parent_id  bigint NOT NULL,
    CONSTRAINT child_cascade_fk FOREIGN KEY (parent_id)
        REFERENCES parent_tbl (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE child_setnull (
    id         bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    parent_id  bigint,
    CONSTRAINT child_setnull_fk FOREIGN KEY (parent_id)
        REFERENCES parent_tbl (id) ON DELETE SET NULL
);

CREATE TABLE child_setdefault (
    id          bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    parent_id   bigint DEFAULT NULL,
    CONSTRAINT child_setdefault_fk FOREIGN KEY (parent_id)
        REFERENCES parent_tbl (id) ON DELETE SET DEFAULT
);

-- Deferrable FK (the referenced PK must stay non-deferrable in PG).
CREATE TABLE deferred_parent (
    id  bigint PRIMARY KEY
);
CREATE TABLE deferred_child (
    id         bigint PRIMARY KEY,
    parent_id  bigint,
    CONSTRAINT deferred_child_fk FOREIGN KEY (parent_id)
        REFERENCES deferred_parent (id)
        DEFERRABLE INITIALLY DEFERRED
);

-- Deferrable standalone UNIQUE (not referenced by any FK, so it is allowed).
CREATE TABLE deferred_unique (
    id  bigint,
    CONSTRAINT deferred_unique_uq UNIQUE (id) DEFERRABLE INITIALLY DEFERRED
);

-- CHECK + composite UNIQUE + partial unique index.
CREATE TABLE check_example (
    id         bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    a          integer NOT NULL,
    b          integer NOT NULL,
    status     text,
    CONSTRAINT check_ab CHECK (a < b),
    CONSTRAINT check_status CHECK (status IS NULL OR status IN ('ok', 'bad')),
    CONSTRAINT check_unique_ab UNIQUE (a, b)
);
CREATE UNIQUE INDEX check_example_active_uq
    ON check_example (a) WHERE status = 'ok';

-- EXCLUDE constraint (no Oracle analogue at all). Needs btree_gist to allow
-- integer equality alongside a range-overlap condition.
CREATE EXTENSION IF NOT EXISTS btree_gist;
CREATE TABLE meeting_room (
    room_id   integer NOT NULL,
    during    tsrange NOT NULL,
    EXCLUDE USING gist (room_id WITH =, during WITH &&)
);

-- NOT NULL added later with NOT VALID then validated (PG 18 surface).
CREATE TABLE notnull_valid_example (
    id  bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    v   integer
);
INSERT INTO notnull_valid_example (v) VALUES (1), (2), (3);
ALTER TABLE notnull_valid_example ALTER COLUMN v SET NOT NULL;
