# CrateDB JDBC binding compatibility — `*BindingTest` results

Captured 2026-04-23 against `jdbc:postgresql://10.13.1.30:5432/crate?stringtype=unspecified`
as `scott/tiger`. CrateDB version: 6.2.4. Postgres JDBC driver: 42.7.4.

The `BindProbe` fixture sleeps 2 s between INSERT and SELECT to clear CrateDB's
default 1 s Lucene refresh interval, so failures here are real binding /
storage gaps rather than read-after-write artefacts. (Local Postgres pays the
same 2 s per test — acceptable for a one-off compatibility scan.)

**Headline:** 75 pass, 40 fail out of 115 tests across 28 binding-test
classes. Each class drives one column type with the JDBC `setX()` setters
appropriate to it.

## Failure categories

| Category | Count | Meaning |
|---|---:|---|
| `MISSING_TYPE` | 27 | `CREATE TABLE ... (the_value <type>)` rejected — CrateDB does not have the type |
| `STORAGE_NOT_SUPPORTED` | 6 | CrateDB recognises the type name but cannot persist it |
| `PARSE_ERROR` | 6 | CrateDB SQL parser rejects the column DDL |
| `BIT_LENGTH_MISMATCH` | 1 | `bit(8)` rejects the wire encoding pgjdbc sends for a `PGobject('bit')` |

## Types CrateDB does not support

| Postgres type | CrateDB error category |
|---|---|
| `date` | `STORAGE_NOT_SUPPORTED` (use `timestamp` instead) |
| `time` | `MISSING_TYPE` |
| `time with time zone` | `STORAGE_NOT_SUPPORTED` |
| `bytea` | `MISSING_TYPE` |
| `money` | `MISSING_TYPE` |
| `bpchar(N)` | `MISSING_TYPE` (use `varchar`) |
| `inet`, `cidr`, `macaddr`, `macaddr8` | `MISSING_TYPE` |
| `int4range`, `numrange`, `tsrange`, `int4multirange` | `MISSING_TYPE` |

Every JDBC setter against a column of one of these types fails identically —
the failure happens at CREATE TABLE, before the binding gets a chance.

## DDL CrateDB cannot parse

| Postgres DDL | CrateDB error |
|---|---|
| `interval year to month` | `mismatched input 'year' expecting {',', ')'}` |
| `interval day to second` | same |
| `bit varying(64)` | `mismatched input 'varying'` |

## Types CrateDB stores cleanly (all setters round-trip)

These columns work end-to-end via every setter the test class exercises:

| Postgres type | Setters that pass |
|---|---|
| `smallint`, `integer`, `bigint` | all 9 (`setByte`/`setShort`/`setInt`/`setLong`/`setFloat`/`setDouble`/`setBigDecimal`/`setString`/`setObject(Integer)`) |
| `real`, `double precision` | all 9 |
| `decimal(20, 6)` | all 9 |
| `text`, `varchar(100)`, `char(10)` | all 3 (`setString`, `setObject(String)`, `setCharacterStream`) |
| `boolean` | all 3 (`setBoolean`, `setObject(Boolean)`, `setString`) |
| `timestamp` | all 3 (`setTimestamp`, `setObject(LocalDateTime)`, `setString`) |
| `timestamp with time zone` | all 3 (`setTimestamp`, `setObject(OffsetDateTime)`, `setString`) |
| `uuid` | both (`setObject(UUID)`, `setString`) |
| `bit(8)` | `setString` only — `setObject(PGobject('bit'))` is mis-encoded over the wire |

## How to reproduce

```sh
PG_URL='jdbc:postgresql://10.13.1.30:5432/crate?stringtype=unspecified' \
  PG_USER=scott PG_PASSWORD=tiger \
  mvn -Dtest='*BindingTest' test
```

Each binding test creates `dbhell.bind_probe (the_value <type>)`, inserts one
row through one JDBC setter, sleeps 2 s, reads it back, drops the table.

## Baseline: same suite against local Postgres 18

For comparison, the identical 115 binding tests run against PostgreSQL 18.3
(Postgres.app, `jdbc:postgresql://localhost:5432/pg_dbhell_test`) on the same
day:

| Result | Count |
|---|---:|
| Pass | **115** |
| Fail | 0 |

Wall time: 3 m 57 s (the 2 s `BindProbe` sleep dominates — actual SQL work
is well under a second per test).

Every column DDL the suite exercises is created cleanly, every JDBC setter
on the agreed menu round-trips, and every getter returns the expected value.
The 40 failures listed above are therefore CrateDB-specific — they are the
delta between PG 18 and CrateDB 6.2.4, not artefacts of the test code.

```sh
mvn -Dtest='*BindingTest' test
```
