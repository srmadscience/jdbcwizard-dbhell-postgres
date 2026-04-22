
set echo on
set feedback on
set showmode on

connect system/manager@&1



CREATE TABLESPACE example
NOLOGGING
DATAFILE '/export/data/oradata/&1/example_schemas.dbf' SIZE 150M REUSE
AUTOEXTEND ON NEXT 640k
MAXSIZE UNLIMITED
EXTENT MANAGEMENT LOCAL
SEGMENT SPACE MANAGEMENT AUTO;

exit


