-- 22_grants_and_security.sql: GRANT/REVOKE, RLS, column privileges, default
-- privileges. Oracle source: scattered GRANT statements across the corpus.

SET search_path = dbhell, public;

-- Standard grants.
GRANT SELECT                         ON base_emp TO scott;
GRANT SELECT (id, name)              ON base_emp TO nopriv;
GRANT INSERT, UPDATE                 ON base_emp TO scott;
GRANT EXECUTE ON FUNCTION very_simple_function() TO scott;
GRANT USAGE   ON SCHEMA dbhell_pkg_datatypes TO scott;

-- Revoke, then re-grant with WITH GRANT OPTION.
REVOKE INSERT ON base_emp FROM scott;
GRANT  INSERT ON base_emp TO scott WITH GRANT OPTION;

-- Default privileges: future tables owned by dbhell granted automatically.
ALTER DEFAULT PRIVILEGES FOR ROLE dbhell IN SCHEMA dbhell
    GRANT SELECT ON TABLES TO scott;

-- Row-level security.
CREATE TABLE salary_sensitive (
    id         bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    owner      text NOT NULL,
    salary     numeric(10, 2) NOT NULL
);
INSERT INTO salary_sensitive (owner, salary) VALUES
    ('scott',  60000),
    ('dbhell', 99999);

ALTER TABLE salary_sensitive ENABLE ROW LEVEL SECURITY;
ALTER TABLE salary_sensitive FORCE ROW LEVEL SECURITY;

CREATE POLICY salary_owner_select ON salary_sensitive
    FOR SELECT USING (owner = current_user);

CREATE POLICY salary_owner_modify ON salary_sensitive
    FOR ALL USING (owner = current_user)
    WITH CHECK (owner = current_user);

-- Restricted "nopriv" role.
REVOKE ALL ON ALL TABLES    IN SCHEMA dbhell FROM nopriv;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA dbhell FROM nopriv;
GRANT  USAGE                ON SCHEMA dbhell TO nopriv;
