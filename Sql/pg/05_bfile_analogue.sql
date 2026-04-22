-- 05_bfile_analogue.sql: composite type standing in for Oracle BFILE.
-- Oracle source: dbhell.sql:47-50 (CREATE DIRECTORY) and dbhell.sql:174-185
-- (BFILE + bfilename()). Postgres has no external-file pointer; we emulate
-- with a directory-name + file-name composite so downstream consumers can
-- still see the same "where does this live" shape.

SET search_path = dbhell, public;

CREATE TABLE bfile_directory (
    dir_name  text PRIMARY KEY,
    dir_path  text NOT NULL
);
INSERT INTO bfile_directory VALUES
    ('DBHELL_TESTDIR1', '/export/data/testdata/dbhell_testdir1'),
    ('DBHELL_NOEXISTS', '/export/data/testdata/dbhell_nonexists');

CREATE TYPE bfile AS (
    dir_name   text,
    file_name  text
);

CREATE FUNCTION bfilename(p_dir text, p_file text) RETURNS bfile
    LANGUAGE sql IMMUTABLE AS
$$ SELECT ROW(p_dir, p_file)::dbhell.bfile $$;

CREATE TABLE bfile_example (
    name       varchar(256) PRIMARY KEY,
    bfiledata  bfile
);
INSERT INTO bfile_example VALUES
    ('null bfile',                NULL),
    ('test_readable',             bfilename('DBHELL_TESTDIR1', 'test_readable')),
    ('test_unreadble_wrong_case', bfilename('dbhell_testdir1', 'test_readable')),
    ('test_unreadable',           bfilename('DBHELL_TESTDIR1', 'test_unreadable')),
    ('no such file',              bfilename('DBHELL_TESTDIR1', 'no such file')),
    ('invalid directory',         bfilename('DBHELL_NOEXISTS', 'dbhell non exists')),
    ('nterdesk.dmp',              bfilename('DBHELL_TESTDIR1', 'nterdesk.dmp')),
    ('nterdesk.dmp.Z',            bfilename('DBHELL_TESTDIR1', 'nterdesk.dmp.Z'));
