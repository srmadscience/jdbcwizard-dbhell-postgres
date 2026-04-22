-- 18_exotic_names.sql: long names, unicode, $, quoted keywords.
-- Oracle sources: Sql/longname.sql, Sql/dollersign.sql.
-- Postgres NAMEDATALEN = 64 → 63 bytes of identifier.

SET search_path = dbhell, public;

-- 63-character identifier (at the edge of NAMEDATALEN-1).
CREATE TABLE a_table_name_of_exactly_sixty_three_characters_to_test_limit (
    id  bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY
);

-- $ in identifier (PG allows, but not as first char; leading $ must be quoted).
CREATE TABLE dollar$table (
    a$b        integer,
    "$leading" text
);

-- Unicode column name + escape syntax.
CREATE TABLE unicode_cols (
    "café"                    text,
    U&"na\00efve"             text
);

-- Delimited keyword columns.
CREATE TABLE delimited_keywords (
    "select"   integer,
    "from"     integer,
    "where"    integer,
    "group"    integer,
    "order"    integer,
    "union"    integer,
    "natural"  integer,
    "using"    integer,
    "returning" integer
);
INSERT INTO delimited_keywords DEFAULT VALUES;
