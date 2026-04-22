-- 13_plpgsql_refcursor.sql: weak and strong refcursors, cursor FOR loops.
-- Oracle source: Sql/refcursors.sql, Sql/evilRefcursors.sql.
-- PG uses a single refcursor type; "strong typing" is enforced at OPEN time.

SET search_path = dbhell, public;

-- Weak cursor returning arbitrary shape.
CREATE FUNCTION weak_cursor(p_min integer)
    RETURNS refcursor LANGUAGE plpgsql AS
$$
DECLARE
    c refcursor;
BEGIN
    OPEN c FOR SELECT id, name FROM base_emp WHERE salary >= p_min;
    RETURN c;
END;
$$;

-- "Strong" cursor: the query is pinned at CREATE time via the function body.
CREATE FUNCTION strong_cursor_emp(p_dept text)
    RETURNS refcursor LANGUAGE plpgsql AS
$$
DECLARE
    c refcursor;
BEGIN
    OPEN c FOR SELECT * FROM base_emp WHERE dept = p_dept;
    RETURN c;
END;
$$;

-- Cursor FOR loop.
CREATE FUNCTION cursor_for_loop_sum() RETURNS numeric LANGUAGE plpgsql AS
$$
DECLARE
    total numeric := 0;
    r     base_emp%ROWTYPE;
BEGIN
    FOR r IN SELECT * FROM base_emp LOOP
        total := total + r.salary;
    END LOOP;
    RETURN total;
END;
$$;

-- Scrollable cursor with MOVE / FETCH.
CREATE FUNCTION scroll_emp_names() RETURNS TABLE (name text) LANGUAGE plpgsql AS
$$
DECLARE
    c SCROLL CURSOR FOR SELECT e.name FROM base_emp e ORDER BY e.id;
    r record;
BEGIN
    OPEN c;
    LOOP
        FETCH c INTO r;
        EXIT WHEN NOT FOUND;
        name := r.name;
        RETURN NEXT;
    END LOOP;
    CLOSE c;
END;
$$;

-- Consume a refcursor returned from another function (common JDBC pattern).
DO $$
DECLARE
    c refcursor;
    r record;
BEGIN
    c := dbhell.strong_cursor_emp('eng');
    LOOP
        FETCH c INTO r;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'engineer: %', r.name;
    END LOOP;
    CLOSE c;
END;
$$;
