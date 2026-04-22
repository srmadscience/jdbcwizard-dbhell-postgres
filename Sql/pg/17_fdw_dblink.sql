-- 17_fdw_dblink.sql: postgres_fdw + dblink analogues of Oracle DB links.
-- Oracle source: Sql/dblinks.sql.
-- Guarded by \if :{?postgres_fdw} in pg_dbhell.sql.

SET search_path = dbhell_fdw, dbhell, public;

CREATE EXTENSION IF NOT EXISTS postgres_fdw;
CREATE EXTENSION IF NOT EXISTS dblink;

-- Loopback server pointing at the same cluster. Downstream consumers just
-- need the DDL shape; they don't have to actually connect through it.
-- FDW option values must be string literals (no expressions), so the dbname
-- is hard-coded to match the test database used by pg_dbhell.sql.
CREATE SERVER IF NOT EXISTS loopback
    FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host 'localhost', dbname 'pg_dbhell_test', port '5432');

CREATE USER MAPPING IF NOT EXISTS FOR CURRENT_USER
    SERVER loopback
    OPTIONS (user 'dbhell', password 'dbhell');

CREATE FOREIGN TABLE remote_base_emp (
    id     bigint,
    name   text,
    salary numeric(10, 2),
    dept   text
)
SERVER loopback
OPTIONS (schema_name 'dbhell', table_name 'base_emp');

-- IMPORT FOREIGN SCHEMA is a legal statement to emit, even if the remote
-- server isn't reachable during code generation.
-- IMPORT FOREIGN SCHEMA dbhell LIMIT TO (base_emp) FROM SERVER loopback INTO dbhell_fdw;

-- Reset for subsequent files.
SET search_path = dbhell, public;
