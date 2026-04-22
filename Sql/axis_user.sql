set echo on
set feedback on
set showmode on

connect system/manager@&1

drop user axistest cascade;

drop tablespace axistest including contents;
create tablespace axistest datafile '/export/data/oradata/&1/axistest.dbf' size 100M reuse;

drop tablespace axistest_sort including contents;
create tablespace axistest_sort datafile '/export/data/oradata/&1/axistest_sort.dbf' size 100M reuse;

alter tablespace axistest_sort_temp add datafile '/export/data/oradata/&1/axistest_sort_2.dbf' size 300M reuse;

drop tablespace axistest_sort_temp including contents;
create temporary tablespace axistest_sort_temp tempfile '/export/data/oradata/&1/axistest_sort_temp.dbf' size 100M reuse;

alter tablespace axistest_sort_temp add tempfile '/export/data/oradata/&1/axistest_sort_temp_2.dbf' size 300M reuse;

drop tablespace axistest_lob including contents;
create tablespace axistest_lob datafile '/export/data/oradata/&1/axistest_lob.dbf' size 100M reuse
default storage (initial 1M next 5M pctincrease 0);

alter tablespace axistest_lob add datafile '/export/data/oradata/&1/axistest_lob_2.dbf' size 200M reuse;

alter tablespace axistest_lob add datafile '/export/data/oradata/&1/axistest_lob_3.dbf' size 200M reuse;

grant connect, resource,dba to axistest identified by axistest;

alter user axistest default tablespace axistest temporary tablespace axistest_sort_temp;
alter user axistest default tablespace axistest temporary tablespace axistest_sort;

connect axistest/axistest@&1


drop directory dbhell_testdir2;
create directory dbhell_testdir2 as '/export/data/testdata/&1/dbhell_testdir2';


@axis_ddl

exit


