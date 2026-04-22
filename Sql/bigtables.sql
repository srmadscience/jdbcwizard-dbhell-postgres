
set echo on
set feedback on
set showmode on

connect system/manager@&1

drop user bigtables cascade;

drop tablespace bigtables including contents;

create tablespace bigtables datafile '/export/data/oradata/&1/bigtables.dbf' size 100M reuse;

grant connect, resource,dba to bigtables identified by bigtables;

connect bigtables/bigtables@&1

create table bigtable1
(privs varchar2(30)
,links number
,fileowner varchar2(30)
,filegroup varchar2(30)
,filesize number
,fileMonth varchar2(30)
,fileDay varchar2(30)
,fileTime varchar2(30)
,fileName varchar2(1000)
,parentFileName varchar2(1000)
,fileType varchar2(300)
,inode number
,dirtype varchar2(1)
,create_date date default sysdate
,fileDate date)
tablespace bigtables;


exit


