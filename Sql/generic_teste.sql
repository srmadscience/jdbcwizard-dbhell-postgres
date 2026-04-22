
set echo on
set feedback on
set showmode on
spool generic_teste

PROMPT generic_teste

connect system/manager@&1
REM connect system/zirconium123@&1

drop user generic_teste cascade;

grant connect, resource to generic_teste identified by generic_teste;

alter user generic_teste quota unlimited on users;

connect generic_teste/generic_teste@&1

start oraclearraysPackage

spool off

exit
