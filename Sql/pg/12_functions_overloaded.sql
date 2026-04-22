-- 12_functions_overloaded.sql: function overloading, default args, VARIADIC,
-- SETOF, RETURNS TABLE, polymorphic types, language variants.
-- Oracle source: dbhell.sql:349-407 (overload_test package).

SET search_path = dbhell, public;

-- Overloaded by argument type. Oracle dispatches on numbered arg types too;
-- PG uses full signature (name + types) as the identity.
CREATE FUNCTION overload_test1(a_param numeric) RETURNS void LANGUAGE plpgsql AS
$$ BEGIN NULL; END; $$;

CREATE FUNCTION overload_test1(a_param timestamp) RETURNS void LANGUAGE plpgsql AS
$$ BEGIN NULL; END; $$;

CREATE FUNCTION overload_test1(a_param text) RETURNS void LANGUAGE plpgsql AS
$$ BEGIN NULL; END; $$;

CREATE FUNCTION overload_test1(a_param numeric, b_param numeric) RETURNS void LANGUAGE plpgsql AS
$$ BEGIN NULL; END; $$;

CREATE FUNCTION overload_test1(a_param timestamp, b_param numeric) RETURNS void LANGUAGE plpgsql AS
$$ BEGIN NULL; END; $$;

CREATE FUNCTION overload_test1(a_param text, b_param numeric) RETURNS void LANGUAGE plpgsql AS
$$ BEGIN NULL; END; $$;

-- SQL-language scalar function.
CREATE FUNCTION very_simple_function() RETURNS integer
    LANGUAGE sql IMMUTABLE AS $$ SELECT 42 $$;

-- Defaulted arguments.
CREATE FUNCTION one_param_function(a_param integer DEFAULT 0) RETURNS integer
    LANGUAGE sql IMMUTABLE AS $$ SELECT a_param + 42 $$;

CREATE FUNCTION two_param_function(a_param integer, another_param integer DEFAULT 1) RETURNS integer
    LANGUAGE sql IMMUTABLE AS $$ SELECT a_param + another_param + 42 $$;

-- Polymorphic (anyelement / anyarray).
CREATE FUNCTION first_or_default(a anyarray, d anyelement) RETURNS anyelement
    LANGUAGE sql IMMUTABLE AS
$$ SELECT COALESCE(a[1], d) $$;

-- VARIADIC.
CREATE FUNCTION concat_with(sep text, VARIADIC parts text[]) RETURNS text
    LANGUAGE sql IMMUTABLE AS
$$ SELECT array_to_string(parts, sep) $$;

-- RETURNS SETOF composite (Oracle REF CURSOR analogue by result shape).
CREATE FUNCTION all_emp_in(dept_name text) RETURNS SETOF base_emp
    LANGUAGE sql STABLE AS
$$ SELECT * FROM base_emp WHERE dept = dept_name $$;

-- RETURNS TABLE (inline column list).
CREATE FUNCTION emp_by_salary(min_salary numeric)
    RETURNS TABLE (id bigint, name text, salary numeric)
    LANGUAGE sql STABLE AS
$$ SELECT id, name, salary FROM base_emp WHERE salary >= min_salary $$;

-- Stored PROCEDURE (no return, commit/rollback permitted).
CREATE PROCEDURE do_nothing() LANGUAGE plpgsql AS
$$ BEGIN NULL; END; $$;

CREATE PROCEDURE do_something(a_param numeric) LANGUAGE plpgsql AS
$$ BEGIN NULL; END; $$;

CALL do_nothing();
CALL do_something(1);

-- Language variants.
CREATE FUNCTION sql_only_add(a integer, b integer) RETURNS integer
    LANGUAGE sql IMMUTABLE PARALLEL SAFE LEAKPROOF
    RETURN a + b;
