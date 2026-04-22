-- 10_views_and_matviews.sql: views, updatable views (synonym analogue),
-- materialized views, and SECURITY BARRIER/INVOKER.
-- Oracle sources: views/synonyms are scattered (dbhell_syns.sql, synuser_syns.sql).

SET search_path = dbhell, public;

CREATE TABLE base_emp (
    id       bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name     text NOT NULL,
    salary   numeric(10, 2) NOT NULL,
    dept     text NOT NULL
);
INSERT INTO base_emp (name, salary, dept) VALUES
    ('Alice', 50000, 'eng'),
    ('Bob',   60000, 'eng'),
    ('Cara',  55000, 'ops');

-- Plain view.
CREATE VIEW emp_public AS
SELECT id, name, dept FROM base_emp;

-- Updatable view (Oracle private-synonym analogue).
CREATE VIEW emp_eng AS
SELECT * FROM base_emp WHERE dept = 'eng'
WITH CHECK OPTION;

-- Security-barrier view.
CREATE VIEW emp_secure WITH (security_barrier = true) AS
SELECT id, name FROM base_emp WHERE dept = 'eng';

-- security_invoker (PG 15+) view.
CREATE VIEW emp_invoker WITH (security_invoker = true) AS
SELECT id, name, salary FROM base_emp;

-- Recursive view.
CREATE RECURSIVE VIEW integers_1_to_10 (n) AS
    SELECT 1
    UNION ALL
    SELECT n + 1 FROM integers_1_to_10 WHERE n < 10;

-- Materialized view with index.
CREATE MATERIALIZED VIEW emp_salary_summary AS
SELECT dept, count(*) AS headcount, sum(salary) AS total
FROM base_emp
GROUP BY dept
WITH DATA;
CREATE UNIQUE INDEX emp_salary_summary_dept ON emp_salary_summary (dept);
REFRESH MATERIALIZED VIEW CONCURRENTLY emp_salary_summary;
