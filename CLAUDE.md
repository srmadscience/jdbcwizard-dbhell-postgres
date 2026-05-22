# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Two artefacts that live together:

1. **`Sql/pg/`** — a PostgreSQL 18 DDL-torture corpus. `pg_dbhell.sql` `\i`-includes 26 numbered feature files (`00_*` through `25_*`) in dependency order. Each include is self-contained; `ON_ERROR_STOP=1` halts on the first failure. Ported from an Oracle equivalent (`jdbcwizard-dbhell`) — see `README.md` for the Oracle→Postgres type/feature mapping. `21_pg18_new_features.sql` exercises Postgres-18 surface that has no Oracle analogue (virtual generated columns, `PRIMARY KEY ... WITHOUT OVERLAPS`, temporal `FOREIGN KEY ... PERIOD`, `uuidv7()`, `MERGE ... RETURNING`, partitioning with `ATTACH`/`DETACH`, etc.).
2. **`src/test/java/ie/rolfe/dbhell/postgres/`** — a Maven JUnit 5 suite that exercises the schema through the PostgreSQL JDBC driver. 142 tests, expected to pass in ~5 s against a populated database.

The Java tests **depend on the SQL corpus already being loaded** into the target database — they don't create the schema themselves (read tests) or only stage temporary tables (write tests).

## Loading the SQL corpus

```bash
createdb pg_dbhell_test
psql -v ON_ERROR_STOP=1 -d pg_dbhell_test -f Sql/pg/pg_dbhell.sql
```

Optional extensions are gated by `psql` `\if :{?var}` conditionals — pass `-v postgis=1` and/or `-v postgres_fdw=1` to enable `07_postgis_geometry.sql` and `17_fdw_dblink.sql`. Verified on Postgres 18.3: 630 statements, 0 errors.

## Running the JDBC tests

```bash
mvn test
mvn test -Dtest='NBigintBindingTest'          # single class
mvn test -Dtest='*ReadTest'                   # wildcards work
mvn test -Dtest='ScalarZooNumericBindingTest'
```

JDK 21+ and Maven 3.9+ required (`maven.compiler.source=21`).

### Connection config

Env vars override the localhost defaults (see `testkit/DbConfig.java`):

| Var | Default |
|---|---|
| `PG_URL` | `jdbc:postgresql://localhost:5432/pg_dbhell_test?stringtype=unspecified` |
| `PG_USER` | OS user (`user.name`) |
| `PG_PASSWORD` | empty |

**Keep `stringtype=unspecified` in the test URL.** Without it, the `setString` numeric-binding tests (e.g. `setString("7")` bound to a numeric column) fail at the server with "expression is of type character varying". A real application typically leaves it at the driver default; the test suite needs it to exercise the full JDBC binding surface.

## Test architecture

Three packages under `ie.rolfe.dbhell.postgres`:

- **`testkit/`** — shared fixtures, no `@Test` methods.
  - `DbConfig.open()` — opens a connection with `autoCommit=false`.
  - `DbFixture.withRollback(...)` — runs a body inside a connection that **always rolls back**. Read tests use this to leave the corpus untouched.
  - `BindProbe.bindAndCheck(colDdl, binder, reader, expected)` — write-side fixture. Creates `dbhell.bind_probe (the_value <colDdl>)` in **autocommit** mode (DDL can't be rolled back the way DML can), binds one row, sleeps 2 s, reads it back, drops the table in a `finally`. The 2 s delay is there so the same test suite can run against CrateDB (Lucene refresh interval is 1 s); Postgres pays the cost too — accepted trade-off. See `CRATEDB_MATRIX.md` for the CrateDB compatibility scan results that motivated the design.
- **`read/`** (69 tests) — selects every column of all 7 seeded tables in `03_core_datatypes.sql`, asserts seeded values and `wasNull()` for NULL handling. For the empty `scalar_zoo` table, each read test inserts a row and selects it back inside a `withRollback`.
- **`write/`** (73 tests) — one binding test per non-numeric `scalar_zoo` column, plus 6 numeric columns × 8 JDBC setters (`setByte`/`setShort`/`setInt`/`setLong`/`setFloat`/`setDouble`/`setBigDecimal`/`setString`) = 48 numeric binding tests. The value `7` is used everywhere because it fits in `byte` while still round-tripping through every other numeric setter. `NumericBindingFixture` wraps `BindProbe` with a `BigDecimal.compareTo`-based asserter so `7`, `7.0`, `7.00` all compare equal across return types.

When adding a new binding test, follow the existing pattern: declare the column DDL inline, write one `@Test` per JDBC setter, and let `BindProbe` handle the staging table lifecycle. Don't fold multiple types into one staging table — each call gets its own so a type the server can't store fails in isolation.

## Package note

Java code lives under `ie.rolfe.dbhell.postgres.*` (renamed from `io.dbhell.*` in commit `76cf745`). Match this package when adding new tests.
