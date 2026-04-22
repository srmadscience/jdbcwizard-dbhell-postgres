-- 02_reserved_word_names.sql: reserved-word and whitespace identifiers.
-- Oracle source: dbhell.sql:61-73 creates "from" and " a b c" tables to
-- stress code generators that don't quote identifiers.

SET search_path = dbhell, public;

CREATE TABLE "from" (
    "where" varchar(1)
);
INSERT INTO "from" ("where") VALUES ('a');

CREATE TABLE " a b c" (
    " " varchar(1)
);
INSERT INTO " a b c" (" ") VALUES ('a');

-- U&"..." Unicode identifier (SQL standard, PG supported).
CREATE TABLE U&"caf\00e9" (
    U&"n\00e4me" text
);
INSERT INTO U&"caf\00e9" VALUES ('espresso');
