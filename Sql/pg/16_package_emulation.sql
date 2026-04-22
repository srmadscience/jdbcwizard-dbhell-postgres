-- 16_package_emulation.sql: Oracle PACKAGE -> Postgres schema-of-functions.
-- Oracle source: dbhell.sql:253-316 (generic_package), dbhell.sql:349-407
-- (overload_test), datatypes.sql (datatype_test).
--
-- Idiom: one schema per package, functions inside it. Name resolution via
-- search_path replaces Oracle package-qualified calls.

-- ------------------------------------------------------------
-- Package: dbhell_pkg_generic  (Oracle: generic_package)
-- ------------------------------------------------------------
SET search_path = dbhell_pkg_generic, dbhell, public;

CREATE PROCEDURE generic_package() LANGUAGE plpgsql AS $$ BEGIN NULL; END; $$;
CREATE PROCEDURE step_1()          LANGUAGE plpgsql AS $$ BEGIN NULL; END; $$;
CREATE PROCEDURE do_something(a_param numeric) LANGUAGE plpgsql AS
$$ BEGIN NULL; END; $$;
CREATE FUNCTION very_simple_function() RETURNS numeric LANGUAGE plpgsql AS
$$ BEGIN RETURN 42; END; $$;
CREATE FUNCTION one_param_function(a_param numeric) RETURNS numeric LANGUAGE plpgsql AS
$$ BEGIN RETURN a_param + 42; END; $$;
CREATE FUNCTION two_param_function(a_param numeric, another_param numeric) RETURNS numeric LANGUAGE plpgsql AS
$$ BEGIN RETURN a_param + 42; END; $$;

-- ------------------------------------------------------------
-- Package: dbhell_pkg_datatypes (Oracle: datatype_test)
-- One round-trip function per scalar type.
-- ------------------------------------------------------------
SET search_path = dbhell_pkg_datatypes, dbhell, public;

CREATE FUNCTION number_func   (in_param numeric)  RETURNS numeric  LANGUAGE sql IMMUTABLE AS $$ SELECT in_param $$;
CREATE FUNCTION date_func     (in_param date)     RETURNS date     LANGUAGE sql IMMUTABLE AS $$ SELECT in_param $$;
CREATE FUNCTION integer_func  (in_param integer)  RETURNS integer  LANGUAGE sql IMMUTABLE AS $$ SELECT in_param $$;
CREATE FUNCTION bigint_func   (in_param bigint)   RETURNS bigint   LANGUAGE sql IMMUTABLE AS $$ SELECT in_param $$;
CREATE FUNCTION real_func     (in_param real)     RETURNS real     LANGUAGE sql IMMUTABLE AS $$ SELECT in_param $$;
CREATE FUNCTION double_func   (in_param double precision) RETURNS double precision LANGUAGE sql IMMUTABLE AS $$ SELECT in_param $$;
CREATE FUNCTION text_func     (in_param text)     RETURNS text     LANGUAGE sql IMMUTABLE AS $$ SELECT in_param $$;
CREATE FUNCTION varchar_func  (in_param varchar)  RETURNS varchar  LANGUAGE sql IMMUTABLE AS $$ SELECT in_param $$;
CREATE FUNCTION char_func     (in_param char)     RETURNS char     LANGUAGE sql IMMUTABLE AS $$ SELECT in_param $$;
CREATE FUNCTION boolean_func  (in_param boolean)  RETURNS boolean  LANGUAGE sql IMMUTABLE AS $$ SELECT in_param $$;
CREATE FUNCTION ts_func       (in_param timestamp) RETURNS timestamp LANGUAGE sql IMMUTABLE AS $$ SELECT in_param $$;
CREATE FUNCTION tstz_func     (in_param timestamptz) RETURNS timestamptz LANGUAGE sql IMMUTABLE AS $$ SELECT in_param $$;
CREATE FUNCTION bytea_func    (in_param bytea)    RETURNS bytea    LANGUAGE sql IMMUTABLE AS $$ SELECT in_param $$;
CREATE FUNCTION uuid_func     (in_param uuid)     RETURNS uuid     LANGUAGE sql IMMUTABLE AS $$ SELECT in_param $$;
CREATE FUNCTION json_func     (in_param jsonb)    RETURNS jsonb    LANGUAGE sql IMMUTABLE AS $$ SELECT in_param $$;

-- ------------------------------------------------------------
-- Package: dbhell_pkg_overload  (Oracle: overload_test)
-- Shows same-named functions dispatched by signature across a package.
-- ------------------------------------------------------------
SET search_path = dbhell_pkg_overload, dbhell, public;

CREATE FUNCTION op(a numeric)             RETURNS text LANGUAGE sql IMMUTABLE AS $$ SELECT 'num'   $$;
CREATE FUNCTION op(a text)                RETURNS text LANGUAGE sql IMMUTABLE AS $$ SELECT 'text'  $$;
CREATE FUNCTION op(a timestamp)           RETURNS text LANGUAGE sql IMMUTABLE AS $$ SELECT 'ts'    $$;
CREATE FUNCTION op(a numeric, b numeric)  RETURNS text LANGUAGE sql IMMUTABLE AS $$ SELECT 'num2'  $$;
CREATE FUNCTION op(a text,    b numeric)  RETURNS text LANGUAGE sql IMMUTABLE AS $$ SELECT 'text2' $$;
CREATE FUNCTION op(a timestamp, b numeric) RETURNS text LANGUAGE sql IMMUTABLE AS $$ SELECT 'ts2'   $$;

-- Reset search_path to the default for subsequent files.
SET search_path = dbhell, public;
