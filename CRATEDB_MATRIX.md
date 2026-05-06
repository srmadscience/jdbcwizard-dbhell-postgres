# CrateDB JDBC binding compatibility — `*BindingTest` results

Captured against `jdbc:postgresql://10.13.1.30:5432/crate?stringtype=unspecified`
as `scott/tiger`. CrateDB version: 6.2.4. Postgres JDBC driver: 42.7.4.

- 2026-04-23 — `*BindingTest` compatibility scan (sections below through "Baseline").
- 2026-05-06 — randomised numeric round-trip scans added (`*#randomThousand`).

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

The `double precision` and `decimal(20, 6)` "all 9 setters pass" results above
come from the curated values inside `NDoubleBindingTest` / `NDecimalBindingTest`.
Random sweeps across the full BigDecimal range tell a different story — see
the next section.

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

## Randomised BigDecimal round-trip scans (2026-05-06)

Two `#randomThousand` tests feed 1 000 BigDecimals from a seeded `Random` (seed
`0xC0FFEE`) through `setBigDecimal`, then read each row back and check it
against the locally-computed expected value. Each input row is tagged with
an `id` column so output can be matched to input even when individual inserts
are rejected; per-row `SQLException`s are captured rather than aborting the
batch.

Run both with:

```sh
PG_URL='jdbc:postgresql://10.13.1.30:5432/crate?stringtype=unspecified' \
  PG_USER=scott PG_PASSWORD=tiger \
  mvn -Dtest='BigDecimalToDoubleTest#randomThousand+Numeric72BigDecimalTest#randomThousand' test
```

### `numeric(7, 2)` — 1000/1000 OK

`Numeric72BigDecimalTest#randomThousand` generates random unscaled values
(1–26 bits) and scales 0–6, deliberately straddling the `numeric(7, 2)`
±99 999.99 boundary. CrateDB:

- Round-trips every input whose `setScale(2, HALF_UP)` fits the precision.
- Rejects every input whose rounded value overflows 5 integer digits, with a
  proper error rather than silent truncation.

No surprises here.

### `double precision` — only ~38/1000 round-trip cleanly

`BigDecimalToDoubleTest#randomThousand` generates 1–80 bit unscaled values
with scales in `[-300, 300]`, covering most of the BigDecimal range.

| Outcome | Count |
|---|---:|
| Round-tripped (`Double.compare(input.doubleValue(), stored) == 0`) | ~38 |
| Rejected by server | **469** |
| Stored but value wrong | **493** |

Two distinct failure modes:

**1. Positive-scale inputs (very small numbers) are rejected**

Every rejected row has a positive scale large enough that `toPlainString()`
contains many leading zeros, e.g. `0.0000…0190487833519`. CrateDB returns:

```
ERROR: Character array is missing "e" notation exponential mark.
```

The pgjdbc driver is sending the value in plain-decimal form; the CrateDB
Postgres-protocol parser refuses to parse a numeric literal of that shape and
demands scientific notation. The same input via `setString("1.9e-150")` would
be accepted — it's a wire-format mismatch, not a magnitude issue.

**2. Negative-scale inputs (very large numbers) lose their exponent**

Every silent mismatch has a negative scale. The unscaled mantissa is stored
faithfully but the scale information is dropped on the way in:

| Input (BigDecimal) | scale | Expected `double` | Actual `double` |
|---|---:|---|---|
| `2 051 888 × 10^36` | -36 | `2.051888E42` | `2 051 888.0` |
| `5.178…E113` (mantissa × 10^100) | -100 | `5.1785980564086E113` | `5.1785980564086E13` |
| `5.261…E64` | -54 | `5.2611749411E64` | `5.2611749411E12` |
| `3.591…E291` | -276 | `3.591270108898102E291` | `3.591270108898102E15` |
| `6.335…E234` | -224 | `6.3353910625E234` | `6.3353910625E10` |
| `-3.736E122` | -119 | `-3.736E122` | `-3 736 000.0` |

The "actual" looks like the value is being interpreted with the negative scale
truncated/clamped — the caller's intended exponent never reaches the column.

### Practical safe range

For `setBigDecimal` against a CrateDB `double precision` column on this build,
inputs whose `scale` lies roughly in `[0, ~30]` round-trip. Outside that band
you either get the *"missing 'e' notation"* error (large positive scale) or a
silently truncated magnitude (negative scale).

Workarounds when you cannot constrain the producer:

- Send via `setObject(value, Types.DOUBLE)` or `setDouble(value.doubleValue())`
  — does the BigDecimal → double conversion client-side, so CrateDB only sees
  the already-collapsed `double` and never has to parse the BigDecimal text.
- Or normalise to scientific notation client-side, e.g.
  `ps.setString(i, value.toEngineeringString())` (combined with the
  `stringtype=unspecified` URL parameter the suite already uses).

The 1000 inputs are reproducible — same seed yields the same set every run, so
this table can be re-derived against future CrateDB versions to track when the
BigDecimal wire-parser is fixed.
