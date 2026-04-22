set echo on
set feedback on
set showmode on

connect system/manager@&1

drop user dbhell cascade;
drop user scott cascade;
drop user nopriv cascade;

drop tablespace dbhell including contents;
create tablespace dbhell datafile 'C:\oracle\ora90\oradata\DB920A21\dbhell.dbf' size 100M reuse;

drop tablespace dbhell_sort including contents;
create tablespace dbhell_sort datafile 'C:\oracle\ora90\oradata\DB920A21\dbhell_sort.dbf' size 100M reuse;

drop tablespace dbhell_lob including contents;
create tablespace dbhell_lob datafile 'C:\oracle\ora90\oradata\DB920A21\dbhell_lob.dbf' size 100M reuse;

alter tablespace dbhell_lob add datafile 'C:\oracle\ora90\oradata\DB920A21\dbhell_lob_2.dbf' size 200M reuse;

grant connect               to nopriv identified by nopriv;
grant connect, resource     to scott  identified by tiger;
grant connect, resource,dba to dbhell identified by dbhell;

alter user scott quota unlimited on users;

alter user dbhell default tablespace dbhell temporary tablespace dbhell_sort;

connect dbhell/dbhell@&1


alter rollback segment r01 online;
alter rollback segment r02 online;
alter rollback segment r03 online;
alter rollback segment r04 online;

drop directory dbhell_testdir1;
drop directory dbhell_nonexists;
create directory dbhell_testdir1 as 'C:\oracle\ora90\oradata\testdata\dbhell_testdir1';
create directory dbhell_nonexists as 'C:\oracle\ora90\oradata\testdata\dbhell_nonexists';

create sequence dbhell.test_seq_1;
create sequence dbhell.test_seq_2 start with 1000;
create sequence dbhell.test_seq_3 increment by 37 start with 1000;
create sequence dbhell."test seq 4" maxvalue 2 nocycle;
create sequence dbhell.test_seq_5 start with 9223372036854775806 /* Long.MAX_VALUE -1 */
				maxvalue 200000000000000000000000  
                                increment by  1;


create table dbhell."from"
("where" varchar(1));

insert into dbhell."from"
values
('a');

create table dbhell." a b c"
(" " varchar(1));

insert into dbhell." a b c"
values
('a');

create table dbhell.all_normal_datatypes
(name varchar2(4000)
,name_char char(2000)
,seqno number
,seqno_big number(38,0)
,seqno_small number(2,-28)
, seqno_float float
,date_generic date 
);

insert into dbhell.all_normal_datatypes
(name)
values
('all null');


insert into dbhell.all_normal_datatypes
(name, name_char, seqno, seqno_big, seqno_small, seqno_float,date_generic)
values
('42','42',99999999999999999999999999999999999999,99999999999999999999999999999999999999 ,42,42,sysdate);



create table dbhell.all_normal_datatypes_9i
(name varchar2(4000)
,date_generic date 
,timestamp_generic timestamp
,timestamp_tz timestamp with time zone
,timestamp_local_tz timestamp with local time zone
,date_year_2_month interval year (2) to month
,date_day_2_second interval day (6) to second
,a_rowid rowid
,a_u_rowid urowid
);

insert into dbhell.all_normal_datatypes_9i
(name)
values
('all null');

insert into dbhell.all_normal_datatypes_9i
(name, timestamp_generic)
values
('all null execept timestamp',sysdate);

insert into dbhell.all_normal_datatypes_9i
(name, timestamp_tz)
values
('all null execept timestamp_tz',sysdate);

insert into dbhell.all_normal_datatypes_9i
(name, timestamp_local_tz)
values
('all null execept timestamp_local_tz',sysdate);


/* Long and longraw tables... */
create table dbhell.raw_example (NAME varchar2 (256), GIFDATA raw(200));
insert into dbhell.raw_example values ('LESLIE2', hextoraw('6A')||hextoraw('6B')||hextoraw('6C'));
insert into dbhell.raw_example values ('LESLIE3',null);

create table dbhell.longraw_example (NAME varchar2 (256), GIFDATA long raw);
insert into dbhell.longraw_example values ('LESLIE2', hextoraw('6A')||hextoraw('6B')||hextoraw('6C'));
insert into dbhell.longraw_example values ('LESLIE3',null);

create table dbhell.long_example (NAME varchar2 (256), LONGDATA long );
insert into dbhell.long_example values ('LESLIE2', 'This is a long column');
insert into dbhell.long_example values ('LESLIE3',NULL); 

/* blob and clob tables... */
create table dbhell.clob_example (NAME varchar2 (256), CLOBDATA CLOB) tablespace dbhell_lob;
insert into dbhell.clob_example values ('LESLIE2', 'This is a long column');
insert into dbhell.clob_example values ('LESLIE3', null);

create table dbhell.blob_example (NAME varchar2 (256), BLOBDATA BLOB) tablespace dbhell_lob;
insert into dbhell.blob_example values ('LESLIE2', hextoraw('6A')||hextoraw('6B')||hextoraw('6C'));
insert into dbhell.blob_example values ('LESLIE3', null);

/* BFILE table */
CREATE TABLE dbhell.bfile_example (name varchar2 (256),  bfiledata bfile) tablespace dbhell_lob;

insert into dbhell.bfile_example (name, bfiledata) values ('null bfile',null);
insert into dbhell.bfile_example (name, bfiledata) values ('test_readable',bfilename('DBHELL_TESTDIR1','test_readable'));
insert into dbhell.bfile_example (name, bfiledata) values ('test_unreadble_wrong_case',bfilename('dbhell_testdir1','test_readable'));
insert into dbhell.bfile_example (name, bfiledata) values ('test_unreadable',bfilename('DBHELL_TESTDIR1','test_unreadable'));
insert into dbhell.bfile_example (name, bfiledata) values ('no such file',bfilename('DBHELL_TESTDIR1','no such file'));
insert into dbhell.bfile_example (name, bfiledata) values ('invalid directory',bfilename('DBHELL_NOEXISTS','dbhell non exists'));

insert into dbhell.bfile_example (name, bfiledata) values ('nterdesk.dmp',bfilename('DBHELL_TESTDIR1','nterdesk.dmp'));
insert into dbhell.bfile_example (name, bfiledata) values ('nterdesk.dmp.Z',bfilename('DBHELL_TESTDIR1','nterdesk.dmp.Z'));

/* number format table */
CREATE TABLE DBHELL.numberformat_example(name varchar2(256), money_value varchar2(256), numberdata number);

insert into numberformat_example values ('null',null,null);
insert into numberformat_example values ('0','$0.00',0);
insert into numberformat_example values ('1','$1.00',1);
insert into numberformat_example values ('1,000','$1,000.00',1000);
insert into numberformat_example values ('1,000,000','$1,000,000.00', 1000000);
insert into numberformat_example values ('1,000,000.976','$1,000,000.98',1000000.976);

/* date format table */
CREATE TABLE DBHELL.dateformat_example(name varchar2(256), date_value date, date_string varchar2(256), time_string varchar2(256));

insert into dateformat_example values ('null',null,null,null);
insert into dateformat_example values ('midnight',to_date('06-Nov-1967','DD-MON-YYYY'),'1967/11/06','00:00:00');
insert into dateformat_example values ('3am',to_date('06-Nov-1967 03','DD-MON-YYYY HH24'),'1967/11/06','03:00:00');

/* Number test table */
CREATE TABLE dbhell.number_test (name varchar2(256), the_value number(38,10));

insert into dbhell.number_test values ('null',null);
insert into dbhell.number_test values ('0',0);
insert into dbhell.number_test values ('max_byte',127);
insert into dbhell.number_test values ('max_byte+1',128);
insert into dbhell.number_test values ('max_short',(256*256)-1);
insert into dbhell.number_test values ('max_short+1',(256*256));

/* Boolean test table */
CREATE TABLE dbhell.Boolean_test (name varchar2(256), the_character_value varchar2(256), the_number_value number(38,10));

insert into dbhell.boolean_test values ('null',null,null);
insert into dbhell.boolean_test values ('TRUE','Y',1);
insert into dbhell.boolean_test values ('TRUE','T',120202020);
insert into dbhell.boolean_test values ('TRUE','True',120202020);
insert into dbhell.boolean_test values ('TRUE','tRue',0.00000001);
insert into dbhell.boolean_test values ('TRUE','yes',1);
insert into dbhell.boolean_test values ('FALSE','N',0);
insert into dbhell.boolean_test values ('FALSE','F',0);
insert into dbhell.boolean_test values ('FALSE','n',0);
insert into dbhell.boolean_test values ('FALSE','false',0);
insert into dbhell.boolean_test values ('FALSE',' ',0);

commit;


prompt functions and procedure calls


create or replace procedure dbhell.do_nothing as
BEGIN
--
  NULL;
--
END;
.
/

create or replace procedure dbhell.do_something (a_param number) as
BEGIN
--
  NULL;
--
END;
.
/

create or replace package dbhell.generic_package as
--
procedure step_1;
procedure do_something (a_param number);
function very_simple_function return number;
function one_param_function (a_param number) return number;
function two_param_function (a_param number,another_param number ) return number;
procedure generic_package;
--
end;
.
/

show errors;

create or replace package body dbhell.generic_package as
--
procedure generic_package is
--
BEGIN
--
  NULL;
--
END;
--
procedure step_1  is
--
BEGIN
--
  NULL;
--
END;
--
function very_simple_function return number is
BEGIN
--
  RETURN 42;
--
END;
--
function one_param_function (a_param number) return number is
BEGIN
--
  RETURN a_param + 42;
--
END;
--
function two_param_function (a_param number,another_param number ) return number is
BEGIN
--
  RETURN a_param + 42;
--
END;
--
procedure do_something (a_param number) is
BEGIN
--
  NULL;
--
END;
--
END;
.
/

show errors;



create  or replace function dbhell.very_simple_function return number as
BEGIN
--
  RETURN 42;
--
END;
.
/

create or replace function dbhell.one_param_function (a_param number) return number as
BEGIN
--
  RETURN a_param + 42;
--
END;
.
/

create or replace function dbhell.two_param_function (a_param number,another_param number ) return number as
BEGIN
--
  RETURN a_param + 42;
--
END;
.
/

create or replace package dbhell.overload_test as
procedure overload_test1(a_param number);
procedure overload_test1(a_param date);
procedure overload_test1(a_param varchar2);
procedure overload_test1(a_param number, b_param number);
procedure overload_test1(a_param date, b_param number);
procedure overload_test1(a_param varchar2, b_param number);
end;
.
/

show errors;

create or replace package body dbhell.overload_test
as
procedure overload_test1(a_param number) is
BEGIN
--
  NULL;
--
END;
--
procedure overload_test1(a_param date) is
BEGIN
--
  NULL;
--
END;
--
procedure overload_test1(a_param varchar2) is
BEGIN
--
  NULL;
--
END;
--
procedure overload_test1(a_param number, b_param number) is
BEGIN
--
  NULL;
--
END;
--
procedure overload_test1(a_param date, b_param number) is
BEGIN
--
  NULL;
--
END;
--
procedure overload_test1(a_param varchar2, b_param number) is
BEGIN
--
  NULL;
--
END;
--
END;
.
/


show errors

@message_table
@countries
@datatypes
@datatypes_9i
@refcursors
@unreasonable
@dbhell_901_bug
exit



