set echo on
set feedback on
set showmode on

connect system/manager@&1

drop user synuser cascade;

drop tablespace synuser including contents;

create tablespace synuser datafile 'C:\oracle\ora90\oradata\DB920A21\synuser.dbf' size 10M reuse;

grant connect, resource,dba to synuser identified by synuser;

connect synuser/synuser@&1

create sequence synuser.test_seq_1;
create sequence synuser.test_seq_2 start with 1000;
create sequence synuser.test_seq_3_no_syn;

grant select on synuser.test_seq_1 to public;
grant select on synuser.test_seq_2 to public;
grant select on synuser.test_seq_3_no_syn to public;

drop public synonym test_seq_1_pub;
create public synonym test_seq_1_pub for synuser.test_seq_1;

create table synuser.all_normal_datatypes
(name varchar2(4000)
,name_char char(2000)
,seqno number
,seqno_big number(38,0)
,seqno_small number(2,-28)
, seqno_float float
,date_generic date 
);

insert into synuser.all_normal_datatypes
(name)
values
('all null');


insert into synuser.all_normal_datatypes
(name, name_char, seqno, seqno_big, seqno_small, seqno_float,date_generic)
values
('42','42',99999999999999999999999999999999999999,99999999999999999999999999999999999999 ,42,42,sysdate);

drop public synonym all_normal_datatypes ;
create public synonym all_normal_datatypes for synuser.all_normal_datatypes;

grant select on all_normal_datatypes to public;


create table synuser.all_normal_datatypes_9i
(name varchar2(4000)
,date_generic date 
,timestamp_generic timestamp
,date_year_2_month interval year (2) to month
,date_day_2_second interval day (6) to second
,a_rowid rowid
,a_u_rowid urowid
);

insert into synuser.all_normal_datatypes_9i
(name)
values
('all null');

insert into synuser.all_normal_datatypes_9i
(name, timestamp_generic)
values
('all null execept timestamp',sysdate);

grant select on all_normal_datatypes_9i to public;


create or replace function synuser.very_simple_function return number as
BEGIN
--
  RETURN 24;
--
END;
.
/

create or replace function synuser.one_param_function (a_param number) return number as
BEGIN
--
  RETURN a_param + 24;
--
END;
.
/

create or replace function synuser.two_param_function (a_param number,another_param number ) return number as
BEGIN
--
  RETURN a_param + 24;
--
END;
.
/

commit;

create or replace package synuser.synuser_package as
--
procedure step_1;
procedure step_2 (p_param in number);
function very_simple_function return number;
function one_param_function (a_param number) return number;
function two_param_function (a_param number,another_param number ) return number;
--
end;
.
/

show errors;

create or replace package body synuser.synuser_package as
--
procedure step_1  is
--
BEGIN
--
  NULL;
--
END;
--
procedure step_2 (p_param in number)  is
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
END;
.
/


create or replace procedure synuser_do_nothing as
--
BEGIN
--
  NULL;
--
END;
.
/

show errors;


create or replace procedure synuser_do_something (p_number in number) as
--
BEGIN
--
  NULL;
--
END;
.
/

show errors;

exit



