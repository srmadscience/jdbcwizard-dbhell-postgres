-- 04_large_objects.sql: text/bytea analogues of Oracle LOB types.
-- Oracle source: dbhell.sql:147-171 (RAW, LONG RAW, LONG, CLOB, BLOB).
-- In PG, text and bytea auto-TOAST; "LONG" semantics are native.

SET search_path = dbhell, public;

CREATE TABLE raw_example (
    name     varchar(256),
    gifdata  bytea,
    CONSTRAINT raw_example_pk PRIMARY KEY (name)
);
INSERT INTO raw_example VALUES
    ('LESLIE2', decode('6A6B6C', 'hex')),
    ('LESLIE3', NULL);

-- Oracle LONG RAW -> bytea (unlimited).
CREATE TABLE longraw_example (
    name     varchar(256),
    gifdata  bytea,
    CONSTRAINT longraw_example_pk PRIMARY KEY (name)
);
INSERT INTO longraw_example VALUES
    ('LESLIE2', decode('6A6B6C', 'hex')),
    ('LESLIE3', NULL);

-- Oracle LONG -> text (unlimited).
CREATE TABLE long_example (
    name     varchar(256),
    longdata text,
    CONSTRAINT long_example_pk PRIMARY KEY (name)
);
INSERT INTO long_example VALUES
    ('LESLIE2', 'This is a long column'),
    ('LESLIE3', NULL);

-- CLOB -> text.
CREATE TABLE clob_example (
    name     varchar(256),
    clobdata text,
    CONSTRAINT clob_example_pk PRIMARY KEY (name)
);
INSERT INTO clob_example VALUES
    ('LESLIE2', 'This is a long column'),
    ('LESLIE3', NULL);

-- BLOB -> bytea.
CREATE TABLE blob_example (
    name     varchar(256),
    blobdata bytea,
    CONSTRAINT blob_example_pk PRIMARY KEY (name)
);
INSERT INTO blob_example VALUES
    ('LESLIE2', decode('6A6B6C', 'hex')),
    ('LESLIE3', NULL);

-- Large object / OID-based API (pg_largeobject). The lo extension gives
-- cleanup triggers equivalent to Oracle's empty_blob() semantics.
CREATE EXTENSION IF NOT EXISTS lo;
CREATE TABLE lo_example (
    name  varchar(256),
    data  lo
);
CREATE TRIGGER lo_example_cleanup
    BEFORE UPDATE OR DELETE ON lo_example
    FOR EACH ROW EXECUTE FUNCTION lo_manage(data);
