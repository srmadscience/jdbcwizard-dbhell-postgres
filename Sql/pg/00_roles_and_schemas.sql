-- 00_roles_and_schemas.sql: roles and schemas.
--
-- Oracle uses users-as-schemas and tablespaces-as-datafiles; Postgres separates
-- them. We model the original "dbhell", "scott", "nopriv" users as roles that
-- own matching schemas. Tablespaces-as-datafiles are dropped entirely (Postgres
-- tablespaces are directories and add no parser coverage worth emulating).

DROP SCHEMA IF EXISTS dbhell             CASCADE;
DROP SCHEMA IF EXISTS dbhell_scott       CASCADE;
DROP SCHEMA IF EXISTS dbhell_nopriv      CASCADE;
DROP SCHEMA IF EXISTS dbhell_pkg_generic CASCADE;
DROP SCHEMA IF EXISTS dbhell_pkg_datatypes CASCADE;
DROP SCHEMA IF EXISTS dbhell_pkg_overload  CASCADE;
DROP SCHEMA IF EXISTS dbhell_fdw         CASCADE;

DROP ROLE IF EXISTS dbhell;
DROP ROLE IF EXISTS scott;
DROP ROLE IF EXISTS nopriv;

CREATE ROLE dbhell  LOGIN PASSWORD 'dbhell'  CREATEDB CREATEROLE;
CREATE ROLE scott   LOGIN PASSWORD 'tiger';
CREATE ROLE nopriv  LOGIN PASSWORD 'nopriv';

CREATE SCHEMA dbhell             AUTHORIZATION dbhell;
CREATE SCHEMA dbhell_scott       AUTHORIZATION scott;
CREATE SCHEMA dbhell_nopriv      AUTHORIZATION nopriv;
CREATE SCHEMA dbhell_pkg_generic   AUTHORIZATION dbhell;
CREATE SCHEMA dbhell_pkg_datatypes AUTHORIZATION dbhell;
CREATE SCHEMA dbhell_pkg_overload  AUTHORIZATION dbhell;
CREATE SCHEMA dbhell_fdw         AUTHORIZATION dbhell;

GRANT USAGE ON SCHEMA dbhell TO scott, nopriv;

-- Everything below this point creates objects in the dbhell schema by default.
SET search_path = dbhell, public;
