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

## Java / JDBC test suite (`src/test/java/`)

A Maven project exercises every column in every table of
[`03_core_datatypes.sql`](Sql/pg/03_core_datatypes.sql) through the
PostgreSQL JDBC driver — 142 JUnit 5 tests in total:

| Package                                       | Tests | What it covers                                                 |
|-----------------------------------------------|-------|----------------------------------------------------------------|
| `ie.rolfe.dbhell.postgres.read`               | 69    | Reads every column in all 7 tables; verifies seeded data and NULL handling via `wasNull()`. For the empty `scalar_zoo` table, each test inserts a single-column row and selects it back inside a rolled-back transaction. |
| `ie.rolfe.dbhell.postgres.write` (non-numeric)| 25    | One `@Test` per non-numeric `scalar_zoo` column — strings, temporal, bool/bytea/money/uuid, network, bit strings, ranges. |
| `ie.rolfe.dbhell.postgres.write` (numeric)    | 48    | One file per numeric `scalar_zoo` column (`n_smallint` / `n_int` / `n_bigint` / `n_real` / `n_double` / `n_decimal`), each with 8 `@Test`s — one per JDBC binding: `setByte`, `setShort`, `setInt`, `setLong`, `setFloat`, `setDouble`, `setBigDecimal`, `setString`. |

Every test runs inside a connection that rolls back, so the schema
created by `pg_dbhell.sql` is left untouched.

### Prerequisites

1. PostgreSQL 18 reachable (the tests are verified against Postgres.app 18.3).
2. The `pg_dbhell` corpus loaded into a target database — by default the
   tests look for `pg_dbhell_test`:
   ```bash
   createdb pg_dbhell_test
   psql -v ON_ERROR_STOP=1 -d pg_dbhell_test -f Sql/pg/pg_dbhell.sql
   ```
3. JDK 21+ and Maven 3.9+.

### Running the tests

```bash
mvn test
```

All 142 tests should pass in under 5 seconds. Run a subset by class or
by display-name pattern:

```bash
mvn test -Dtest='NBigintBindingTest'          # every binding for n_bigint
mvn test -Dtest='*ReadTest'                   # all read tests
mvn test -Dtest='ScalarZooNumericBindingTest' # wildcards work
```

### Configuration

Connection settings come from environment variables with local-dev
defaults:

| Variable      | Default                                                                  |
|---------------|--------------------------------------------------------------------------|
| `PG_URL`      | `jdbc:postgresql://localhost:5432/pg_dbhell_test?stringtype=unspecified` |
| `PG_USER`     | the OS user (`user.name`)                                                |
| `PG_PASSWORD` | empty                                                                    |

Point the suite at a different database without editing code:

```bash
PG_URL='jdbc:postgresql://db.example:5432/dbhell?stringtype=unspecified' \
PG_USER=dbhell PG_PASSWORD=secret mvn test
```

The default URL sets `stringtype=unspecified` so `setString("7")`
round-trips to numeric columns — required by the `setString` numeric
binding tests. A real application typically leaves this at the driver
default; the test suite needs it to exercise the full JDBC binding
surface.

## See Also...

* [jdbcwizard-pub](https://github.com/srmadscience/jdbcwizard-pub) - Library this code uses
* [jdbcwizard-dbhell](https://github.com/srmadscience/jdbcwizard-dbhell) - DB Schema Generation Code
* [jdbcwizard-demo](https://github.com/srmadscience/jdbcwizard-demo-code) - Demo Application Code
* [jdbcwizard-test-code](https://github.com/srmadscience/jdbcwizard-test-code) - Examples of code generated during regression testing
