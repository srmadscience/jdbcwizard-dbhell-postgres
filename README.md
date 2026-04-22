# jdbcwizard-dbhell-postgres

This repository contains two parallel DDL-torture corpora for the same
purpose — exercising everything syntactically possible — one targeted at
Oracle, one at PostgreSQL 18.

## Postgres 18 port (`Sql/pg/`)

The Postgres corpus lives under `Sql/pg/` and is driven by
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

## Oracle corpus (`Sql/`)

* This is a set of Oracle schemas designed to fully exercise what is syntacticly possible
* JDBCWizard can generate Java code to run all the examples here
* The entry point is [dbhel.sql]( https://github.com/srmadscience/jdbcwizard-dbhell/blob/main/Sql/dbhell.sql)
* A good example would be [redcordtest2.sql]( https://github.com/srmadscience/jdbcwizard-dbhell/blob/main/Sql/recordTest2.sql#L209):

The Java to run this is [here](https://github.com/srmadscience/jdbcwizard-test-code/blob/main/generated/ie/rolfe/jdbcwizard/dbhell/plsql/RecordTest28iRt1.java)

```
create or replace package record_test2_8i as
--
TYPE all_8i_datatypes_typ IS REF CURSOR RETURN all_8i_datatypes2%ROWTYPE;  -- strong
--
TYPE GenericCurTyp IS REF CURSOR;  -- weak
--
TYPE recordType IS RECORD (name varchar2(4000)
,name_char char(2000)
,seqno number
,seqno_big number(38,0)
,seqno_small number(2,-28)
, seqno_float float
,date_generic date
,a_raw raw(100)
,a_long_raw long raw
/*,a_long long*/
,a_clob clob
,a_blob blob
,a_bfile bfile);
--
TYPE ANDRecordType IS RECORD (ast all_8i_datatypes%ROWTYPE);
TYPE AND2RecordType IS RECORD (ast all_8i_datatypes%ROWTYPE
                              ,flag VARCHAR2(1)
			      ,msg VARCHAR2(200)
                              ,real_flag boolean
                              ,ast2 recordType
                              ,ast3 record_test2b_8i.recordType8i
			      ,ast4 rectest2_8itype);
--
procedure rt1(p_binary_integer  in binary_integer
             ,p_dec             in dec
             ,p_decimal         in decimal
             ,p_double          in double precision
             ,p_float           in float
             ,p_int             in int
             ,p_integer         in integer
             ,p_natural         in natural
             ,p_naturaln        in naturaln
             ,p_number          in number
             ,p_numeric         in numeric
             ,p_pls_integer     in pls_integer
             ,p_positive        in positive
             ,p_positiven       in positiven
             ,p_real            in real
             ,p_signtype        in signtype
             ,p_smallint        in smallint
             ,p_char            in char
             ,p_character       in character
             ,p_long            in long
             ,p_string          in string
             ,p_varchar         in varchar
             ,p_varchar2        in varchar2
             ,p_boolean         in boolean
             ,p_date            in date
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all_8i_datatypes_typ
	     ,p_clob_in         in clob 
             ,p_blob_in         in blob
             ,p_bfile_in        in bfile
	     ,p_clob_in_out     in out clob 
             ,p_blob_in_out     in out blob
             ,p_bfile_in_out    in out bfile
	     ,p_clob_out        out clob 
             ,p_blob_out         out blob
             ,p_bfile_out        out bfile
	     ,p_package_recordtype1 in     recordType
	     ,p_package_recordtype2 in out recordType
	     ,p_package_recordtype3    out recordType
	     ,p_nonpackage_recordtype1 in     record_test2b_8i.recordType8i
	     ,p_nonpackage_recordtype2 in out record_test2b_8i.recordType8i
	     ,p_nonpackage_recordtype3    out record_test2b_8i.recordType8i
             ,p_rowtype1 in     all_8i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all_8i_datatypes%ROWTYPE
             ,p_rowtype3    out all_8i_datatypes%ROWTYPE
	     ,p_db_recordtype1 in     rectest2_8itype
	     ,p_db_recordtype2 in out rectest2_8itype
	     ,p_db_recordtype3    out rectest2_8itype
             ,p_string2          in string
             );
--
function rt2(p_binary_integer  in binary_integer
             ,p_dec             in dec
             ,p_decimal         in decimal
             ,p_double          in double precision
             ,p_float           in float
             ,p_int             in int
             ,p_integer         in integer
             ,p_natural         in natural
             ,p_naturaln        in naturaln
             ,p_number          in number
             ,p_numeric         in numeric
             ,p_pls_integer     in pls_integer
             ,p_positive        in positive
             ,p_positiven       in positiven
             ,p_real            in real
             ,p_signtype        in signtype
             ,p_smallint        in smallint
             ,p_char            in char
             ,p_character       in character
             ,p_long            in long
             ,p_string          in string
             ,p_varchar         in varchar
             ,p_varchar2        in varchar2
             ,p_boolean         in boolean
             ,p_date            in date
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all_8i_datatypes_typ
             ,p_clob_in         in clob
             ,p_blob_in         in blob
             ,p_bfile_in        in bfile
             ,p_clob_in_out     in out clob
             ,p_blob_in_out     in out blob
             ,p_bfile_in_out    in out bfile
             ,p_clob_out        out clob 
             ,p_blob_out        out blob
             ,p_bfile_out       out bfile
             ,p_package_recordtype1 in     recordType
             ,p_package_recordtype2 in out recordType
             ,p_package_recordtype3    out recordType
             ,p_nonpackage_recordtype1 in     record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype2 in out record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype3    out record_test2b_8i.recordType8i
             ,p_rowtype1 in     all_8i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all_8i_datatypes%ROWTYPE
             ,p_rowtype3    out all_8i_datatypes%ROWTYPE
             ,p_db_recordtype1 in     rectest2_8itype
             ,p_db_recordtype2 in out rectest2_8itype
             ,p_db_recordtype3    out rectest2_8itype
             ,p_string2          in string) RETURN recordType;
--
function rt3(p_binary_integer  in binary_integer
             ,p_dec             in dec
             ,p_decimal         in decimal
             ,p_double          in double precision
             ,p_float           in float
             ,p_int             in int
             ,p_integer         in integer
             ,p_natural         in natural
             ,p_naturaln        in naturaln
             ,p_number          in number
             ,p_numeric         in numeric
             ,p_pls_integer     in pls_integer
             ,p_positive        in positive
             ,p_positiven       in positiven
             ,p_real            in real
             ,p_signtype        in signtype
             ,p_smallint        in smallint
             ,p_char            in char
             ,p_character       in character
             ,p_long            in long
             ,p_string          in string
             ,p_varchar         in varchar
             ,p_varchar2        in varchar2
             ,p_boolean         in boolean
             ,p_date            in date
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all_8i_datatypes_typ
             ,p_clob_in         in clob
             ,p_blob_in         in blob
             ,p_bfile_in        in bfile
             ,p_clob_in_out     in out clob
             ,p_blob_in_out     in out blob
             ,p_bfile_in_out    in out bfile
             ,p_clob_out        out clob 
             ,p_blob_out        out blob
             ,p_bfile_out       out bfile
             ,p_package_recordtype1 in     recordType
             ,p_package_recordtype2 in out recordType
             ,p_package_recordtype3    out recordType
             ,p_nonpackage_recordtype1 in     record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype2 in out record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype3    out record_test2b_8i.recordType8i
             ,p_rowtype1 in     all_8i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all_8i_datatypes%ROWTYPE
             ,p_rowtype3    out all_8i_datatypes%ROWTYPE
             ,p_db_recordtype1 in     rectest2_8itype
             ,p_db_recordtype2 in out rectest2_8itype
             ,p_db_recordtype3    out rectest2_8itype
             ,p_string2          in string) RETURN record_test2b_8i.recordType8i;
--
function rt4(p_binary_integer  in binary_integer
             ,p_dec             in dec
             ,p_decimal         in decimal
             ,p_double          in double precision
             ,p_float           in float
             ,p_int             in int
             ,p_integer         in integer
             ,p_natural         in natural
             ,p_naturaln        in naturaln
             ,p_number          in number
             ,p_numeric         in numeric
             ,p_pls_integer     in pls_integer
             ,p_positive        in positive
             ,p_positiven       in positiven
             ,p_real            in real
             ,p_signtype        in signtype
             ,p_smallint        in smallint
             ,p_char            in char
             ,p_character       in character
             ,p_long            in long
             ,p_string          in string
             ,p_varchar         in varchar
             ,p_varchar2        in varchar2
             ,p_boolean         in boolean
             ,p_date            in date
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all_8i_datatypes_typ
             ,p_clob_in         in clob
             ,p_blob_in         in blob
             ,p_bfile_in        in bfile
             ,p_clob_in_out     in out clob
             ,p_blob_in_out     in out blob
             ,p_bfile_in_out    in out bfile
             ,p_clob_out       out clob 
             ,p_blob_out       out blob
             ,p_bfile_out       out bfile
             ,p_package_recordtype1 in     recordType
             ,p_package_recordtype2 in out recordType
             ,p_package_recordtype3    out recordType
             ,p_nonpackage_recordtype1 in     record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype2 in out record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype3    out record_test2b_8i.recordType8i
             ,p_rowtype1 in     all_8i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all_8i_datatypes%ROWTYPE
             ,p_rowtype3    out all_8i_datatypes%ROWTYPE
             ,p_db_recordtype1 in     rectest2_8itype
             ,p_db_recordtype2 in out rectest2_8itype
             ,p_db_recordtype3    out rectest2_8itype
             ,p_string2          in string) RETURN dbhell.all_8i_datatypes%ROWTYPE;
--
function rt5(p_binary_integer  in binary_integer
             ,p_dec             in dec
             ,p_decimal         in decimal
             ,p_double          in double precision
             ,p_float           in float
             ,p_int             in int
             ,p_integer         in integer
             ,p_natural         in natural
             ,p_naturaln        in naturaln
             ,p_number          in number
             ,p_numeric         in numeric
             ,p_pls_integer     in pls_integer
             ,p_positive        in positive
             ,p_positiven       in positiven
             ,p_real            in real
             ,p_signtype        in signtype
             ,p_smallint        in smallint
             ,p_char            in char
             ,p_character       in character
             ,p_long            in long
             ,p_string          in string
             ,p_varchar         in varchar
             ,p_varchar2        in varchar2
             ,p_boolean         in boolean
             ,p_date            in date
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all_8i_datatypes_typ
             ,p_clob_in         in clob
             ,p_blob_in         in blob
             ,p_bfile_in        in bfile
             ,p_clob_in_out     in out clob
             ,p_blob_in_out     in out blob
             ,p_bfile_in_out    in out bfile
             ,p_clob_out        out clob 
             ,p_blob_out        out blob
             ,p_bfile_out       out bfile
             ,p_package_recordtype1 in     recordType
             ,p_package_recordtype2 in out recordType
             ,p_package_recordtype3    out recordType
             ,p_nonpackage_recordtype1 in     record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype2 in out record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype3    out record_test2b_8i.recordType8i
             ,p_rowtype1 in     all_8i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all_8i_datatypes%ROWTYPE
             ,p_rowtype3    out all_8i_datatypes%ROWTYPE
             ,p_db_recordtype1 in     rectest2_8itype
             ,p_db_recordtype2 in out rectest2_8itype
             ,p_db_recordtype3    out rectest2_8itype
             ,p_string2          in string) RETURN rectest2_8itype;
--
function rtol(p_binary_integer  in binary_integer
             ,p_dec             in dec
             ,p_decimal         in decimal
             ,p_double          in double precision
             ,p_float           in float
             ,p_int             in int
             ,p_integer         in integer
             ,p_natural         in natural
             ,p_naturaln        in naturaln
             ,p_number          in number
             ,p_numeric         in numeric
             ,p_pls_integer     in pls_integer
             ,p_positive        in positive
             ,p_positiven       in positiven
             ,p_real            in real
             ,p_signtype        in signtype
             ,p_smallint        in smallint
             ,p_char            in char
             ,p_character       in character
             ,p_long            in long
             ,p_string_or_number in string
             ,p_varchar         in varchar
             ,p_varchar2        in varchar2
             ,p_boolean         in boolean
             ,p_date            in date
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all_8i_datatypes_typ
             ,p_clob_in         in clob
             ,p_blob_in         in blob
             ,p_bfile_in        in bfile
             ,p_clob_in_out     in out clob
             ,p_blob_in_out     in out blob
             ,p_bfile_in_out    in out bfile
             ,p_clob_out        out clob
             ,p_blob_out        out blob
             ,p_bfile_out       out bfile
             ,p_package_recordtype1 in     recordType
             ,p_package_recordtype2 in out recordType
             ,p_package_recordtype3    out recordType
             ,p_nonpackage_recordtype1 in     record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype2 in out record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype3    out record_test2b_8i.recordType8i
             ,p_rowtype1 in     all_8i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all_8i_datatypes%ROWTYPE
             ,p_rowtype3    out all_8i_datatypes%ROWTYPE
             ,p_db_recordtype1 in     rectest2_8itype
             ,p_db_recordtype2 in out rectest2_8itype
             ,p_db_recordtype3    out rectest2_8itype
             ,p_string2          in string) RETURN rectest2_8itype;
--
function rtol(p_binary_integer  in binary_integer
             ,p_dec             in dec
             ,p_decimal         in decimal
             ,p_double          in double precision
             ,p_float           in float
             ,p_int             in int
             ,p_integer         in integer
             ,p_natural         in natural
             ,p_naturaln        in naturaln
             ,p_number          in number
             ,p_numeric         in numeric
             ,p_pls_integer     in pls_integer
             ,p_positive        in positive
             ,p_positiven       in positiven
             ,p_real            in real
             ,p_signtype        in signtype
             ,p_smallint        in smallint
             ,p_char            in char
             ,p_character       in character
             ,p_long            in long
             ,p_string_or_number in number
             ,p_varchar         in varchar
             ,p_varchar2        in varchar2
             ,p_boolean         in boolean
             ,p_date            in date
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all_8i_datatypes_typ
             ,p_clob_in         in clob
             ,p_blob_in         in blob
             ,p_bfile_in        in bfile
             ,p_clob_in_out     in out clob
             ,p_blob_in_out     in out blob
             ,p_bfile_in_out    in out bfile
             ,p_clob_out        out clob
             ,p_blob_out        out blob
             ,p_bfile_out       out bfile
             ,p_package_recordtype1 in     recordType
             ,p_package_recordtype2 in out recordType
             ,p_package_recordtype3    out recordType
             ,p_nonpackage_recordtype1 in     record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype2 in out record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype3    out record_test2b_8i.recordType8i
             ,p_rowtype1 in     all_8i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all_8i_datatypes%ROWTYPE
             ,p_rowtype3    out all_8i_datatypes%ROWTYPE
             ,p_db_recordtype1 in     rectest2_8itype
             ,p_db_recordtype2 in out rectest2_8itype
             ,p_db_recordtype3    out rectest2_8itype
             ,p_string2          in string) RETURN rectest2_8itype;
--
end;
```

## See Also...

* [jdbcwizard-pub](https://github.com/srmadscience/jdbcwizard-pub) - Library this code uses
* [jdbcwizard-dbhell](https://github.com/srmadscience/jdbcwizard-dbhell) - DB Schema Generation Code
* [jdbcwizard-demo](https://github.com/srmadscience/jdbcwizard-demo-code) - Demo Application Code
* [jdbcwizard-test-code](https://github.com/srmadscience/jdbcwizard-test-code) - Examples of code generated during regression testing
