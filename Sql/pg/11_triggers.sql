-- 11_triggers.sql: every trigger flavour.
-- Oracle source: scattered triggers across the corpus. Postgres exposes
-- BEFORE/AFTER/INSTEAD OF, row + statement, TRUNCATE, transition tables,
-- and deferrable constraint triggers.

SET search_path = dbhell, public;

CREATE TABLE audit_log (
    id       bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    at       timestamptz NOT NULL DEFAULT current_timestamp,
    tag      text NOT NULL,
    payload  jsonb
);

CREATE FUNCTION trg_row_audit() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO audit_log (tag, payload)
    VALUES (TG_OP || ':' || TG_TABLE_NAME,
            to_jsonb(COALESCE(NEW, OLD)));
    RETURN COALESCE(NEW, OLD);
END;
$$;

CREATE TABLE tracked (
    id    bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name  text
);

CREATE TRIGGER tracked_before_ins
    BEFORE INSERT ON tracked
    FOR EACH ROW EXECUTE FUNCTION trg_row_audit();

CREATE TRIGGER tracked_after_upd
    AFTER UPDATE ON tracked
    FOR EACH ROW
    WHEN (OLD.name IS DISTINCT FROM NEW.name)
    EXECUTE FUNCTION trg_row_audit();

CREATE TRIGGER tracked_after_del
    AFTER DELETE ON tracked
    FOR EACH ROW EXECUTE FUNCTION trg_row_audit();

-- Statement-level trigger with transition tables.
CREATE FUNCTION trg_stmt_count() RETURNS trigger LANGUAGE plpgsql AS $$
DECLARE
    n_new bigint := 0;
    n_old bigint := 0;
BEGIN
    IF TG_OP IN ('INSERT', 'UPDATE') THEN
        SELECT count(*) INTO n_new FROM new_rows;
    END IF;
    IF TG_OP IN ('UPDATE', 'DELETE') THEN
        SELECT count(*) INTO n_old FROM old_rows;
    END IF;
    INSERT INTO audit_log (tag, payload)
    VALUES ('STMT:' || TG_OP || ':' || TG_TABLE_NAME,
            jsonb_build_object('new', n_new, 'old', n_old));
    RETURN NULL;
END;
$$;

CREATE TRIGGER tracked_stmt_ins
    AFTER INSERT ON tracked
    REFERENCING NEW TABLE AS new_rows
    FOR EACH STATEMENT EXECUTE FUNCTION trg_stmt_count();

CREATE TRIGGER tracked_stmt_upd
    AFTER UPDATE ON tracked
    REFERENCING OLD TABLE AS old_rows NEW TABLE AS new_rows
    FOR EACH STATEMENT EXECUTE FUNCTION trg_stmt_count();

-- TRUNCATE trigger.
CREATE FUNCTION trg_truncate() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO audit_log (tag) VALUES ('TRUNCATE:' || TG_TABLE_NAME);
    RETURN NULL;
END;
$$;
CREATE TRIGGER tracked_truncate
    BEFORE TRUNCATE ON tracked
    FOR EACH STATEMENT EXECUTE FUNCTION trg_truncate();

-- INSTEAD OF trigger on view.
CREATE VIEW tracked_upper AS
SELECT id, upper(name) AS name FROM tracked;

CREATE FUNCTION trg_instead_of_tracked_upper() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO tracked (name) VALUES (NEW.name);
    RETURN NEW;
END;
$$;

CREATE TRIGGER tracked_upper_io
    INSTEAD OF INSERT ON tracked_upper
    FOR EACH ROW EXECUTE FUNCTION trg_instead_of_tracked_upper();

-- Deferrable constraint trigger.
CREATE FUNCTION trg_deferred_noop() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    RETURN COALESCE(NEW, OLD);
END;
$$;
CREATE CONSTRAINT TRIGGER tracked_deferred
    AFTER UPDATE ON tracked
    DEFERRABLE INITIALLY DEFERRED
    FOR EACH ROW EXECUTE FUNCTION trg_deferred_noop();

INSERT INTO tracked (name) VALUES ('one'), ('two');
UPDATE tracked SET name = name || '!' WHERE name = 'one';
DELETE FROM tracked WHERE name = 'two';
INSERT INTO tracked_upper (name) VALUES ('lowercase');
