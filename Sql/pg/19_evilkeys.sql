-- 19_evilkeys.sql: reserved-word table / column / constraint names.
-- Oracle source: Sql/evilkeys.sql (115 lines of tables whose names are SQL
-- keywords, intended to break careless code generators).

SET search_path = dbhell, public;

CREATE TABLE "select" (
    "from"    integer PRIMARY KEY,
    "where"   text,
    "group"   text,
    "order"   integer,
    "having"  text,
    "values"  text,
    "limit"   integer
);

CREATE TABLE "table" (
    "column" integer PRIMARY KEY,
    "index"  text,
    "view"   text
);

CREATE TABLE "user" (
    "user"    text PRIMARY KEY,
    "current" text,
    "session" text
);

CREATE TABLE "natural" (
    id       bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "join"   text,
    "cross"  text,
    "outer"  text,
    "inner"  text,
    "on"     text,
    "using"  text
);

-- Constraint names that are themselves keywords.
CREATE TABLE evil_constraints (
    id  bigint PRIMARY KEY,
    v   integer NOT NULL,
    CONSTRAINT "check"  CHECK (v > 0),
    CONSTRAINT "unique" UNIQUE (v)
);

INSERT INTO "select" ("from", "where", "group", "order") VALUES
    (1, 'one', 'g1', 10),
    (2, 'two', 'g2', 20);

INSERT INTO "table"    ("column", "index", "view") VALUES (1, 'i1', 'v1');
INSERT INTO "user"     ("user", "current", "session") VALUES ('root', 'yes', 's1');
INSERT INTO "natural"  ("join", "cross") VALUES ('inner', 'left');
INSERT INTO evil_constraints VALUES (1, 1), (2, 2);
