
set echo on
set feedback on
set showmode on

connect system/manager@&1

alter profile default limit password_life_time unlimited;

drop user longusername_________________X cascade;
drop user longusernameXXXXXXXXXXXXXXXXXX cascade;

drop tablespace longusername including contents;

create tablespace longusername datafile '/export/data/oradata/&1/longusername.dbf' size 1M reuse;


grant connect, resource,dba to longusernameXXXXXXXXXXXXXXXXXX identified by longusername;

connect longusernameXXXXXXXXXXXXXXXXXX/longusername@&1

create table verylongtableXXXXXXXXXXXXXXXXX
(nameXXXXXXXXXXXXXXXXXXXXXXXXXX    varchar2(30)
,a_textcol varchar2(30)
,parent_nameXXXXXXXXXXXXXXXXXXX    varchar2(30)
,fileDate date)
tablespace longusername;


create index vlt_pn on
 verylongtableXXXXXXXXXXXXXXXXX
 verylongtableXXXXXXXXXXXXXXXXX
(parent_nameXXXXXXXXXXXXXXXXXXX)
tablespace longusername;


alter table verylongtableXXXXXXXXXXXXXXXXX
add
(constraint vlt_index0 primary key
(nameXXXXXXXXXXXXXXXXXXXXXXXXXX) using index tablespace longusername);

alter table verylongtableXXXXXXXXXXXXXXXXX
add 
(constraint vlt_vltXXXXXXXXXXXXXXXXXXXXXXX foreign key (parent_nameXXXXXXXXXXXXXXXXXXX) references 
verylongtableXXXXXXXXXXXXXXXXX) ;

insert into verylongtableXXXXXXXXXXXXXXXXX
values
('top','foo',null,sysdate);

insert into verylongtableXXXXXXXXXXXXXXXXX
values
('top2','foo',null,sysdate);

insert into verylongtableXXXXXXXXXXXXXXXXX
values
('a','foo','top',sysdate);

insert into verylongtableXXXXXXXXXXXXXXXXX
values
('b','foo','a',sysdate);

insert into verylongtableXXXXXXXXXXXXXXXXX
values
('c','foo','b',sysdate);

grant all on verylongtableXXXXXXXXXXXXXXXXX to public;

exit
