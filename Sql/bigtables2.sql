
connect bigtables/bigtables@&1

alter table bigtable1 drop constraint bt1_bti;
alter table bigtable1 drop constraint bt1_btf;
drop index bt1_fs;
drop index bt1_fo;
drop index bt1_in;
drop table bigtable_inodes;
drop table bigtable_fileowner;

create index bt1_fs on
bigtable1(filesize)
tablespace bigtables;

create index bt1_fo on
bigtable1(fileowner)
tablespace bigtables;

create index bt1_in on
bigtable1(inode)
tablespace bigtables;

create table bigtable_inodes
(inode number not null
,howmany number)
tablespace bigtables;

alter table bigtable_inodes 
add
(constraint bti_index0 primary key
(inode) using index tablespace bigtables);

create table bigtable_fileowner
(fileowner varchar2(30) not null
,howmany number)
tablespace bigtables;

alter table bigtable_fileowner
add
(constraint bf0_index0 primary key
(fileowner) using index tablespace bigtables);

insert into bigtable_inodes
select inode, count(*)
from bigtable1
group by inode;

insert into bigtable_fileowner
select fileowner, count(*)
from bigtable1
group by fileowner;

alter table bigtable1
add 
(constraint bt1_bti foreign key (inode) references bigtable_inodes ) ;

alter table bigtable1
add 
(constraint bt1_btf foreign key (fileowner) references bigtable_fileowner) ;


grant select on bigtable1 to public;
create public synonym pub_bigtable1 for bigtable1;

grant select on bigtable_inodes to public;
create public synonym pub_bigtable_inodes for bigtable_inodes;

grant select on bigtable_fileowner to public;
create public synonym pub_bigtable_fileowner for bigtable_fileowner;



exit
