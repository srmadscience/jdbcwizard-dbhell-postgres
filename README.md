# jdbcwizard-dbhell-postgres

A PostgreSQL 18 DDL-torture corpus: a single schema that exercises as
much of the Postgres parser, catalog, and planner surface as possible,
so downstream code generators and static analysers have one artefact
to test against. Ported from the Oracle
[jdbcwizard-dbhell](https://github.com/srmadscience/jdbcwizard-dbhell)
corpus.

## Running it (`Sql/pg/`)

The corpus is driven by
[`pg_dbhell.sql`](Sql/pg/pg_dbhell.sql), which `\i`-includes 26 feature
files in order. Run it against a fresh database with:

```bash
createdb pg_dbhell_test
psql -v ON_ERROR_STOP=1 -d pg_dbhell_test -f Sql/pg/pg_dbhell.sql
```

Optional extensions are guarded by `psql` conditionals:

```bash
psql -v ON_ERROR_STOP=1 -v postgis=1 -v postgres_fdw=1 \
     -d pg_dbhell_test -f Sql/pg/pg_dbhell.sql
```

Mapping from Oracle features that have no Postgres equivalent:

| Oracle construct                  | Postgres treatment                            |
|-----------------------------------|-----------------------------------------------|
| `NUMBER(p,s)`                     | `numeric(p,s)`                                |
| `VARCHAR2`, `CHAR`                | `varchar`, `char`                             |
| `LONG`, `LONG RAW`, `CLOB`, `BLOB`| `text`, `bytea`                               |
| `BFILE` + `DIRECTORY`             | composite `(dir_name text, file_name text)`   |
| `ROWID`, `UROWID`                 | `tid` column + surrogate `bigint` identity    |
| `XMLTYPE`                         | native `xml`                                  |
| `SDO_GEOMETRY`                    | PostGIS `geometry` (optional)                 |
| Packages                          | dedicated schema of functions                 |
| Synonyms                          | updatable views                               |
| DB links                          | `postgres_fdw` + `dblink` extensions          |
| `NATURAL` / `POSITIVE` / `SIGNTYPE` subtypes | `CREATE DOMAIN` with `CHECK`        |
| Nested tables, VARRAYs            | PG arrays and composite types                 |

The corpus also exercises Postgres-18-specific surface that has no Oracle
analogue at all: virtual generated columns, `PRIMARY KEY … WITHOUT
OVERLAPS`, temporal `FOREIGN KEY … PERIOD`, `uuidv7()`, `MERGE …
RETURNING`, `NOT NULL … NOT VALID` with `VALIDATE CONSTRAINT`, the
builtin collation provider, row-level security with `FORCE`,
RANGE/LIST/HASH/sub-partitioning with `ATTACH`/`DETACH`, and
`EXCLUDE` constraints via `btree_gist`. See
[`21_pg18_new_features.sql`](Sql/pg/21_pg18_new_features.sql).

Verified on Postgres 18.3 with `ON_ERROR_STOP=1` — 630 top-level
statements, 0 errors; final inventory is 83 tables, 78 indexes, 12
views, 1 materialized view, 42 sequences, 6 partitioned indexes, 5
partitioned tables, 7 composite types, 1 foreign table.

## See Also...

* [jdbcwizard-pub](https://github.com/srmadscience/jdbcwizard-pub) - Library this code uses
* [jdbcwizard-dbhell](https://github.com/srmadscience/jdbcwizard-dbhell) - DB Schema Generation Code
* [jdbcwizard-demo](https://github.com/srmadscience/jdbcwizard-demo-code) - Demo Application Code
* [jdbcwizard-test-code](https://github.com/srmadscience/jdbcwizard-test-code) - Examples of code generated during regression testing
