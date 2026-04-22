-- pg_dbhell.sql: Postgres 18 DDL-torture corpus, entry point.
--
-- Usage:
--   createdb pg_dbhell_test
--   psql -v ON_ERROR_STOP=1 -d pg_dbhell_test -f Sql/pg/pg_dbhell.sql
--
-- Optional extensions:
--   -v postgis=1          enable 07_postgis_geometry.sql
--   -v postgres_fdw=1     enable 17_fdw_dblink.sql
--
-- Each include is self-contained; failure halts the script at the offending
-- statement. A successful run prints a final "OK" line.

\set ON_ERROR_STOP on
\set ECHO queries

\echo === 00_roles_and_schemas ===
\i 00_roles_and_schemas.sql
\echo === 01_sequences_and_identity ===
\i 01_sequences_and_identity.sql
\echo === 02_reserved_word_names ===
\i 02_reserved_word_names.sql
\echo === 03_core_datatypes ===
\i 03_core_datatypes.sql
\echo === 04_large_objects ===
\i 04_large_objects.sql
\echo === 05_bfile_analogue ===
\i 05_bfile_analogue.sql
\echo === 06_xml_and_json ===
\i 06_xml_and_json.sql

\if :{?postgis}
  \echo === 07_postgis_geometry ===
  \i 07_postgis_geometry.sql
\else
  \echo === 07_postgis_geometry SKIPPED (pass -v postgis=1 to enable) ===
\endif

\echo === 08_arrays_and_composites ===
\i 08_arrays_and_composites.sql
\echo === 09_constraints ===
\i 09_constraints.sql
\echo === 10_views_and_matviews ===
\i 10_views_and_matviews.sql
\echo === 11_triggers ===
\i 11_triggers.sql
\echo === 12_functions_overloaded ===
\i 12_functions_overloaded.sql
\echo === 13_plpgsql_refcursor ===
\i 13_plpgsql_refcursor.sql
\echo === 14_plpgsql_records ===
\i 14_plpgsql_records.sql
\echo === 15_plpgsql_subtypes ===
\i 15_plpgsql_subtypes.sql
\echo === 16_package_emulation ===
\i 16_package_emulation.sql

\if :{?postgres_fdw}
  \echo === 17_fdw_dblink ===
  \i 17_fdw_dblink.sql
\else
  \echo === 17_fdw_dblink SKIPPED (pass -v postgres_fdw=1 to enable) ===
\endif

\echo === 18_exotic_names ===
\i 18_exotic_names.sql
\echo === 19_evilkeys ===
\i 19_evilkeys.sql
\echo === 20_null_and_size ===
\i 20_null_and_size.sql
\echo === 21_pg18_new_features ===
\i 21_pg18_new_features.sql
\echo === 22_grants_and_security ===
\i 22_grants_and_security.sql
\echo === 23_partitioning ===
\i 23_partitioning.sql
\echo === 24_generated_columns ===
\i 24_generated_columns.sql
\echo === 25_demo_data ===
\i 25_demo_data.sql

\echo
\echo === Object-count sanity check ===
SELECT n.nspname,
       c.relkind,
       count(*) AS n
FROM pg_class c
JOIN pg_namespace n ON n.oid = c.relnamespace
WHERE n.nspname LIKE 'dbhell%'
GROUP BY 1, 2
ORDER BY 1, 2;

\echo
\echo pg_dbhell: OK
