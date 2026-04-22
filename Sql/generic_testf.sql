
set echo on
set feedback on
set showmode on
spool generic_testf

PROMPT generic_testf

connect system/manager@&1
REM connect system/zirconium123@&1

drop user generic_testf cascade;

grant connect, resource to generic_testf identified by generic_testf;
alter user generic_testf quota unlimited on users;

connect generic_testf/generic_testf@&1

start oraclearraysPackage

spool off

exit
