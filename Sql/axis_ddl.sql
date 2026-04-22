drop table message_table;
drop sequence message_seq;

create sequence message_seq;

create table message_table
(seqno number not null
,message_text varchar2(2000));

drop table all_normal_datatypes_9i;

create table all_normal_datatypes_9i
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

insert into all_normal_datatypes_9i
(name)
values
('all null');

insert into all_normal_datatypes_9i
(name, timestamp_generic)
values
('all null execept timestamp',sysdate);

insert into all_normal_datatypes_9i
(name, timestamp_tz)
values
('all null execept timestamp_tz',sysdate);

insert into all_normal_datatypes_9i
(name, timestamp_local_tz)
values
('all null execept timestamp_local_tz',sysdate);

insert into all_normal_datatypes_9i
(name, a_rowid)
select 'all null execept rowid',max(rowid)
from all_normal_datatypes_9i;

insert into all_normal_datatypes_9i
(name, date_year_2_month )
values
('dy2month',INTERVAL '23-2' YEAR(2) TO MONTH);

insert into all_normal_datatypes_9i
(name, date_day_2_second)
values
('dd2second',INTERVAL '11:12:10.222222' HOUR TO SECOND(6));



/* Long and longraw tables... */
drop table raw_example;
create table raw_example (NAME varchar2 (256), GIFDATA raw(200));
alter table raw_example add (constraint raw_example_pk primary key (name));
insert into raw_example values ('LESLIE2', hextoraw('6A')||hextoraw('6B')||hextoraw('6C'));
insert into raw_example values ('LESLIE3',null);

drop table longraw_example;
create table longraw_example (NAME varchar2 (256), GIFDATA long raw);
alter table longraw_example add (constraint longraw_example_pk primary key (name));
insert into longraw_example values ('LESLIE2', hextoraw('6A')||hextoraw('6B')||hextoraw('6C'));
insert into longraw_example values ('LESLIE3',null);

drop table long_example;
create table long_example (NAME varchar2 (256), LONGDATA long );
alter table long_example add (constraint long_example_pk primary key (name));
insert into long_example values ('LESLIE2', 'This is a long column');
insert into long_example values ('LESLIE3',NULL);

/* blob and clob tables... */
drop table clob_example;
create table clob_example (NAME varchar2 (256), CLOBDATA CLOB) tablespace AXISTEST_LOB;
alter table clob_example add (constraint clob_example_pk primary key (name));
insert into clob_example values ('LESLIE2', 'This is a long column');
insert into clob_example values ('LESLIE3', null);

drop table blob_example;
create table blob_example (NAME varchar2 (256), BLOBDATA BLOB) tablespace AXISTEST_LOB;
alter table blob_example add (constraint blob_example_pk primary key (name));
insert into blob_example values ('LESLIE2', hextoraw('6A')||hextoraw('6B')||hextoraw('6C'));
insert into blob_example values ('LESLIE3', null);

/* BFILE table */
drop table bfile_example;
CREATE TABLE bfile_example (name varchar2 (256),  bfiledata bfile) tablespace AXISTEST_LOB;
alter table bfile_example add (constraint bfile_example_pk primary key (name));

insert into bfile_example (name, bfiledata) values ('null bfile',null);
insert into bfile_example (name, bfiledata) values ('test_readable',bfilename('DBHELL_TESTDIR1','test_readable'));
insert into bfile_example (name, bfiledata) values ('test_unreadble_wrong_case',bfilename('testdir1','test_readable'))
;
insert into bfile_example (name, bfiledata) values ('test_unreadable',bfilename('DBHELL_TESTDIR1','test_unreadable'));
insert into bfile_example (name, bfiledata) values ('no such file',bfilename('DBHELL_TESTDIR1','no such file'));
insert into bfile_example (name, bfiledata) values ('invalid directory',bfilename('DBHELL_NOEXISTS','non exists'));

insert into bfile_example (name, bfiledata) values ('nterdesk.dmp',bfilename('DBHELL_TESTDIR1','nterdesk.dmp'));
insert into bfile_example (name, bfiledata) values ('nterdesk.dmp.Z',bfilename('DBHELL_TESTDIR1','nterdesk.dmp.Z'));

insert into bfile_example (name, bfiledata) values ('date.152502',bfilename('DBHELL_TESTDIR2','date.152502'));
insert into bfile_example (name, bfiledata) values ('date.152541',bfilename('DBHELL_TESTDIR2','date.152541'));
insert into bfile_example (name, bfiledata) values ('date.152551',bfilename('DBHELL_TESTDIR2','date.152551'));
insert into bfile_example (name, bfiledata) values ('date.152601',bfilename('DBHELL_TESTDIR2','date.152601'));
insert into bfile_example (name, bfiledata) values ('date.152612',bfilename('DBHELL_TESTDIR2','date.152612'));
insert into bfile_example (name, bfiledata) values ('date.152622',bfilename('DBHELL_TESTDIR2','date.152622'));
insert into bfile_example (name, bfiledata) values ('date.152632',bfilename('DBHELL_TESTDIR2','date.152632'));
insert into bfile_example (name, bfiledata) values ('date.152642',bfilename('DBHELL_TESTDIR2','date.152642'));
insert into bfile_example (name, bfiledata) values ('date.152652',bfilename('DBHELL_TESTDIR2','date.152652'));
insert into bfile_example (name, bfiledata) values ('date.152702',bfilename('DBHELL_TESTDIR2','date.152702'));
insert into bfile_example (name, bfiledata) values ('date.152712',bfilename('DBHELL_TESTDIR2','date.152712'));
insert into bfile_example (name, bfiledata) values ('date.152722',bfilename('DBHELL_TESTDIR2','date.152722'));
insert into bfile_example (name, bfiledata) values ('date.152733',bfilename('DBHELL_TESTDIR2','date.152733'));
insert into bfile_example (name, bfiledata) values ('date.152743',bfilename('DBHELL_TESTDIR2','date.152743'));
insert into bfile_example (name, bfiledata) values ('date.152753',bfilename('DBHELL_TESTDIR2','date.152753'));
insert into bfile_example (name, bfiledata) values ('date.152803',bfilename('DBHELL_TESTDIR2','date.152803'));
insert into bfile_example (name, bfiledata) values ('date.152813',bfilename('DBHELL_TESTDIR2','date.152813'));
insert into bfile_example (name, bfiledata) values ('date.152824',bfilename('DBHELL_TESTDIR2','date.152824'));
insert into bfile_example (name, bfiledata) values ('date.152835',bfilename('DBHELL_TESTDIR2','date.152835'));
insert into bfile_example (name, bfiledata) values ('date.152846',bfilename('DBHELL_TESTDIR2','date.152846'));


create or replace package datatype_test_ninei as
--
function  timestamp_func(in_param timestamp) return timestamp;
--
procedure timestamp_proc(in_param in timestamp
                     ,out_param out timestamp
                     ,in_out_param in out timestamp);
--
function  timestamp_with_time_zone_func(in_param timestamp with time zone) return timestamp
with time zone;
--
procedure timestamp_with_time_zone_proc(in_param in timestamp with time zone
                     ,out_param out timestamp with time zone
                     ,in_out_param in out timestamp with time zone);
--
function  timestamp_with_ltz_func(in_param timestamp with local time zone) return timestamp
with local time zone;
--
procedure timestamp_with_ltz_proc(in_param in timestamp with local time zone
                     ,out_param out timestamp with local time zone
                     ,in_out_param in out timestamp with local time zone);
--
end;
.
/

show errors;


create or replace package body datatype_test_ninei
as
function  timestamp_func(in_param timestamp) return timestamp is
--
foo timestamp := null;
--
BEGIN
--
  foo := TO_TIMESTAMP ('1999-12-01 11:00:00', 'YYYY-MM-DD HH:MI:SS');
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(foo));
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(in_param));
--
--
commit;
  IF in_param IS NOT NULL THEN
--
    return(greatest(foo,in_param));
--
  ELSE
--
    return(in_param);
--
  END IF;
--
END;
--
procedure timestamp_proc(in_param in timestamp
                     ,out_param out timestamp
                     ,in_out_param in out timestamp) is
--
foo timestamp := null;
--
BEGIN
--
  foo := TO_TIMESTAMP ('1967-12-12 11:00:00', 'YYYY-MM-DD HH:MI:SS');
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(foo));
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(in_param));
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(greatest(foo, in_param)));
--
-- least doesnt work!
--
  out_param := greatest(foo, in_param);
--
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(out_param));
--
  commit;
--
    out_param := in_param;
  in_out_param := in_param;
--
END;
--
function  timestamp_with_time_zone_func(in_param timestamp with time zone) return timestamp with time zone is
--
foo timestamp with time zone := null;
--
BEGIN
--
  foo := TO_TIMESTAMP_TZ ('1999-12-01 11:00:00 -08:00', 'YYYY-MM-DD HH:MI:SS TZH:TZM');
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(foo));
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(in_param));
--
--
commit;
  IF in_param IS NOT NULL THEN
--
    return(greatest(foo,in_param));
--
  ELSE
--
    return(in_param);
--
  END IF;
--
END;
--
procedure timestamp_with_time_zone_proc(in_param in timestamp with time zone
                     ,out_param out timestamp with time zone
                     ,in_out_param in out timestamp with time zone) is
--
foo timestamp with time zone := null;
--
BEGIN
--
  foo := TO_TIMESTAMP ('1967-12-12 11:00:00', 'YYYY-MM-DD HH:MI:SS');
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(foo));
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(in_param));
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(greatest(foo, in_param)));
--
-- least doesnt work!
--
  out_param := greatest(foo, in_param);
--
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(out_param));
--
  commit;
--
    out_param := in_param;
  in_out_param := in_param;
--
END;
--
function  timestamp_with_ltz_func(in_param timestamp with local time zone) return timestamp with local time zone is
--
foo timestamp with local time zone := null;
--
BEGIN
--
  foo := TO_TIMESTAMP ('1999-12-01 11:00:00', 'YYYY-MM-DD HH:MI:SS');
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(foo));
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(in_param));
--
--
commit;
  IF in_param IS NOT NULL THEN
--
    return(greatest(foo,in_param));
--
  ELSE
--
    return(in_param);
--
  END IF;
--
END;
--
procedure timestamp_with_ltz_proc(in_param in timestamp with local time zone
                     ,out_param out timestamp with local time zone
                     ,in_out_param in out timestamp with local time zone) is
--
foo timestamp with local time zone := null;
--
BEGIN
--
  foo := TO_TIMESTAMP ('1967-12-12 11:00:00', 'YYYY-MM-DD HH:MI:SS');
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(foo));
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(in_param));
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(greatest(foo, in_param)));
--
-- least doesnt work!
--
  out_param := greatest(foo, in_param);
--
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(out_param));
--
  commit;
--
    out_param := in_param;
  in_out_param := in_param;
--
END;
--
END;
.
/

show errors


create or replace package refcursor_test as
--
TYPE ora_datatypes_typ IS REF CURSOR RETURN all_normal_datatypes%ROWTYPE;  -- strong
--
TYPE GenericCurTyp IS REF CURSOR;  -- weak
--
procedure cur1(out_param out ora_datatypes_typ);
--
procedure cur2(out_param out GenericCurTyp);
--
function cur3 return GenericCurTyp;
--
function cur4 (in_param number) return GenericCurTyp;
--
procedure badcur1(in_param GenericCurTyp);
--
procedure badcur2(statement_results out varchar2);
--
end;
.
/

show errors;

create or replace package body refcursor_test
as
--
procedure cur1(out_param out ora_datatypes_typ) is
--
BEGIN
--
  open out_param for select * from all_normal_datatypes;
--
END;
--
procedure cur2(out_param out GenericCurTyp) is
--
BEGIN
--
  open out_param for select * from all_normal_datatypes;
--
END;
--
function cur3 return GenericCurTyp is
--
  tempCur GenericCurTyp;
--
begin
--
  open tempCur for select * from bigtables.bigtable1;
  return tempCur;
--
end;
--
function cur4 (in_param number) return GenericCurTyp is
--
  tempCur GenericCurTyp;
--
begin
--
  IF in_param IS NULL THEN
--
    open tempCur for select * from dual where 1 = 2;
--
  ELSIF in_param = 0 THEN
--
    null;
--
  ELSIF in_param = 1 THEN
--
    open tempCur for SELECT * FROM BFILE_EXAMPLE WHERE rownum < 3;
--
  ELSIF in_param = 2 THEN
--
    open tempCur for SELECT * FROM CLOB_EXAMPLE WHERE rownum < 3;
--
    open tempCur for SELECT * FROM CLOB_EXAMPLE WHERE rownum < 3;
--
  ELSIF in_param = 3 THEN
--
    open tempCur for SELECT * FROM BLOB_EXAMPLE WHERE rownum < 3;
--
  ELSIF in_param = 4 THEN
--
    open tempCur for SELECT * FROM LONG_EXAMPLE WHERE rownum < 3;
--
  ELSIF in_param = 5 THEN
--
    open tempCur for SELECT * FROM LONGRAW_EXAMPLE WHERE rownum < 3;
--
  ELSIF in_param = 6 THEN
--
    open tempCur for SELECT * FROM RAW_EXAMPLE WHERE rownum < 3;
--
  END IF;
--
  return tempCur;
--
end;
--
procedure badcur1(in_param GenericCurTyp) is
--
  begin
--
  null;
--
end;
--
procedure badcur2(statement_results out varchar2) is
--
begin
--
  null;
--
end;
--
end;
.
/

show errors


DROP TYPE dbRecordType;

CREATE TYPE dbRecordType AS OBJECT
(COMMAND_NAME VARCHAR2(100)
,OS_NAME VARCHAR2(512)
,JAVA_CLASS_FILE_NAME VARCHAR2(512)
,BUILTIN_Y_OR_N VARCHAR2(1)
,EXE_FILE_NAME VARCHAR2(512)
,COMMAND_DESCRIPTION VARCHAR2(512)
);
.
/

create or replace package record_test2 as
--
TYPE packageRecordType IS RECORD (flag VARCHAR2(1), msg VARCHAR2(200));
--
END;
.
/


create or replace package record_test as
--
TYPE ora_datatypes_typ IS REF CURSOR RETURN all_normal_datatypes%ROWTYPE;  -- strong
--
TYPE GenericCurTyp IS REF CURSOR;  -- weak
--
TYPE packageRecordType IS RECORD (flag VARCHAR2(1), msg VARCHAR2(200));
TYPE ANDRecordType IS RECORD (ast all_normal_datatypes%ROWTYPE);
TYPE AND2RecordType IS RECORD (ast all_normal_datatypes%ROWTYPE
                              ,flag VARCHAR2(1)
                              ,msg VARCHAR2(200)
                              ,real_flag boolean
                              ,ast2 all_normal_datatypes%ROWTYPE);
--
CURSOR c2 IS
SELECT * FROM all_normal_datatypes;
--
TYPE c2Rec IS RECORD (c2and c2%ROWTYPE);
--
procedure rt1(p_binary_integer  in binary_integer
             ,p_dec             in dec
             ,p_decimal         in decimal
             ,p_double          in double precision
             ,p_float           in float
             ,p_int             in int
             ,p_integer         in integer
             ,p_natural         in natural
             ,p_naturaln        in naturaln
             ,p_number          in number
             ,p_numeric         in numeric
             ,p_pls_integer     in pls_integer
             ,p_positive        in positive
             ,p_positiven       in positiven
             ,p_real            in real
             ,p_signtype        in signtype
             ,p_smallint        in smallint
             ,p_char            in char
             ,p_character       in character
             ,p_long            in long
             ,p_string          in string
             ,p_varchar         in varchar
             ,p_varchar2        in varchar2
             ,p_boolean         in boolean
             ,p_date            in date
             ,p_outcursor       out GenericCurTyp);
--
PROCEDURE procpackageRecordType
         (p_Eventno   in     NUMBER
         ,p_EventType in     VARCHAR2
         ,p_asof             DATE
         ,p_err       in     packageRecordType
         ,p_err2      in out packageRecordType
         ,p_err3         out packageRecordType
         ,p_boolean   in out BOOLEAN);
--
PROCEDURE procOtherpackageRecordType
         (p_Eventno   in     NUMBER
         ,p_EventType in     VARCHAR2
         ,p_asof             DATE
         ,p_err       in     record_test2.packageRecordType
         ,p_err2      in out record_test2.packageRecordType
         ,p_err3         out record_test2.packageRecordType
         ,p_boolean   in out BOOLEAN);
--
PROCEDURE procdbRecordType
         (p_Eventno   in     NUMBER
         ,p_EventType in     VARCHAR2
         ,p_asof             DATE
         ,p_err       in     dbRecordType
         ,p_err2      in out dbRecordType
         ,p_err3         out dbRecordType
         ,p_boolean   in out BOOLEAN);
--
PROCEDURE procRowtypeRecordType
         (p_Eventno   in     NUMBER
         ,p_EventType in     VARCHAR2
         ,p_asof             DATE
         ,p_err       in     all_normal_datatypes%ROWTYPE
         ,p_err2      in out all_normal_datatypes%ROWTYPE
         ,p_err3         out all_normal_datatypes%ROWTYPE
         ,p_boolean   in out BOOLEAN);
--
PROCEDURE procursortrongrecordtype
         (p_Eventno   in     NUMBER
         ,p_EventType in     VARCHAR2
         ,p_asof             DATE
         ,p_err3         out ora_datatypes_typ
         ,p_boolean   in out BOOLEAN);
--
PROCEDURE procursorweakrecordtype
         (p_Eventno   in     NUMBER
         ,p_EventType in     VARCHAR2
         ,p_asof             DATE
         ,p_err3         out GenericCurTyp
         ,p_boolean   in out BOOLEAN);
--
PROCEDURE lobs_as_normal_params
         (p_in_clob     in     CLOB
         ,p_inout_clob  in out CLOB
         ,p_out_clob       out CLOB
         ,p_in_blob     in     BLOB
         ,p_inout_blob  in out BLOB
         ,p_out_blob       out BLOB);
--

end;
.
/
show errors;


create or replace package body record_test as
--
procedure rt1(p_binary_integer  in binary_integer
             ,p_dec             in dec
             ,p_decimal         in decimal
             ,p_double          in double precision
             ,p_float           in float
             ,p_int             in int
             ,p_integer         in integer
             ,p_natural         in natural
             ,p_naturaln        in naturaln
             ,p_number          in number
             ,p_numeric         in numeric
             ,p_pls_integer     in pls_integer
             ,p_positive        in positive
             ,p_positiven       in positiven
             ,p_real            in real
             ,p_signtype        in signtype
             ,p_smallint        in smallint
             ,p_char            in char
             ,p_character       in character
             ,p_long            in long
             ,p_string          in string
             ,p_varchar         in varchar
             ,p_varchar2        in varchar2
             ,p_boolean         in boolean
             ,p_date            in date
             ,p_outcursor       out GenericCurTyp) IS
--
BEGIN
--
OPEN p_outcursor FOR
SELECT to_char(p_binary_integer )||' = '||'binary_integer' val2 FROM DUAL UNION
SELECT to_char(p_dec            )||' = '||'dec' val2 FROM DUAL UNION
SELECT to_char(p_decimal        )||' = '||'decimal' val2 FROM DUAL UNION
SELECT to_char(p_double         )||' = '||'double precision' val2 FROM DUAL UNION
SELECT to_char(p_float          )||' = '||'float' val2 FROM DUAL UNION
SELECT to_char(p_int            )||' = '||'int' val2 FROM DUAL UNION
SELECT to_char(p_integer        )||' = '||'integer' val2 FROM DUAL UNION
SELECT to_char(p_natural        )||' = '||'natural' val2 FROM DUAL UNION
SELECT to_char(p_naturaln       )||' = '||'naturaln' val2 FROM DUAL UNION
SELECT to_char(p_number         )||' = '||'number' val2 FROM DUAL UNION
SELECT to_char(p_numeric        )||' = '||'numeric' val2 FROM DUAL UNION
SELECT to_char(p_pls_integer    )||' = '||'pls_integer' val2 FROM DUAL UNION
SELECT to_char(p_positive       )||' = '||'positive' val2 FROM DUAL UNION
SELECT to_char(p_positiven      )||' = '||'positiven' val2 FROM DUAL UNION
SELECT to_char(p_real           )||' = '||'real' val2 FROM DUAL UNION
SELECT to_char(p_signtype       )||' = '||'signtype' val2 FROM DUAL UNION
SELECT to_char(p_smallint       )||' = '||'smallint' val2 FROM DUAL UNION
--SELECT        p_char           ||' = '||'char' val2 FROM DUAL UNION
--SELECT        p_character      ||' = '||'character' val2 FROM DUAL UNION
----SELECT       (p_long           )||' = '||'long' val2 FROM DUAL UNION
SELECT        p_string         ||' = '||'string' val2 FROM DUAL UNION
SELECT        p_varchar        ||' = '||'varchar' val2 FROM DUAL UNION
SELECT        p_varchar2       ||' = '||'varchar2' val2 FROM DUAL UNION
----SELECT to_char(p_boolean        )||' = '||'boolean' val2 FROM DUAL UNION
SELECT to_char(p_date           )||' = '||'date' val2 FROM DUAL;
--
END;
--
PROCEDURE procpackageRecordType
         (p_Eventno   in     NUMBER
         ,p_EventType in     VARCHAR2
         ,p_asof             DATE
         ,p_err       in     packageRecordType
         ,p_err2      in out packageRecordType
         ,p_err3         out packageRecordType
         ,p_boolean   in out BOOLEAN) IS
--
BEGIN
--
p_err2.flag := 'S';
p_err2.msg  := 'foo';
--
p_err3.flag := 'S';
p_err3.msg  := 'foo';
--
END;
--
PROCEDURE procOtherpackageRecordType
         (p_Eventno   in     NUMBER
         ,p_EventType in     VARCHAR2
         ,p_asof             DATE
         ,p_err       in     record_test2.packageRecordType
         ,p_err2      in out record_test2.packageRecordType
         ,p_err3         out record_test2.packageRecordType
         ,p_boolean   in out BOOLEAN) IS
--
BEGIN
--
p_err2.flag := 'S';
p_err2.msg  := 'foo';
--
p_err3.flag := 'S';
p_err3.msg  := 'foo';
--
END;
--
PROCEDURE procdbRecordType
         (p_Eventno   in     NUMBER
         ,p_EventType in     VARCHAR2
         ,p_asof             DATE
         ,p_err       in     dbRecordType
         ,p_err2      in out dbRecordType
         ,p_err3         out dbRecordType
         ,p_boolean   in out BOOLEAN) IS
--
BEGIN
--
  NULL;
--
END;
--
PROCEDURE procRowtypeRecordType
         (p_Eventno   in     NUMBER
         ,p_EventType in     VARCHAR2
         ,p_asof             DATE
         ,p_err       in     all_normal_datatypes%ROWTYPE
         ,p_err2      in out all_normal_datatypes%ROWTYPE
         ,p_err3         out all_normal_datatypes%ROWTYPE
         ,p_boolean   in out BOOLEAN) IS
--
BEGIN
--
 NULL;
--
END;
--
PROCEDURE procursortrongrecordtype
         (p_Eventno   in     NUMBER
         ,p_EventType in     VARCHAR2
         ,p_asof             DATE
         ,p_err3         out ora_datatypes_typ
         ,p_boolean   in out BOOLEAN) IS
--
BEGIN
--
 OPEN p_err3 FOR select * from all_normal_datatypes;
--
END;
--
PROCEDURE procursorweakrecordtype
         (p_Eventno   in     NUMBER
         ,p_EventType in     VARCHAR2
         ,p_asof             DATE
         ,p_err3         out GenericCurTyp
         ,p_boolean   in out BOOLEAN) IS
--
BEGIN
--
 NULL;
--
  OPEN p_err3
  FOR select * from all_users;
--
END;
--
PROCEDURE lobs_as_normal_params
         (p_in_clob     in     CLOB
         ,p_inout_clob  in out CLOB
         ,p_out_clob       out CLOB
         ,p_in_blob     in     BLOB
         ,p_inout_blob  in out BLOB
         ,p_out_blob       out BLOB) IS
--
BEGIN
--
  p_out_clob := p_in_clob;
  p_out_blob := p_in_blob;
--
END;
--
END;
.
/

show errors

REM create or replace package axis_test_records
REM --
REM 
REM --
REM END;
REM .
REM /
REM 
REM show errors

create or replace package axis_record_test AS
--
TYPE art IS RECORD
(p_binary_integer  binary_integer
             ,p_dec              dec
             ,p_decimal          decimal
             ,p_double           double precision
             ,p_float            float
             ,p_int              int
             ,p_integer          integer
             ,p_natural          natural
             ,p_naturaln         naturaln := 1
             ,p_number           number
             ,p_numeric          numeric
             ,p_pls_integer      pls_integer
             ,p_positive         positive
             ,p_positiven        positiven := 1
             ,p_real             real
             ,p_signtype         signtype
             ,p_smallint         smallint
             ,p_char             char
             ,p_character        character
             ,p_long             long
             ,p_string           string(100)
             ,p_varchar          varchar(100)
             ,p_varchar2         varchar2(100)
             ,p_boolean          boolean -- DRKLUGE
             ,p_date             date
             ,p_string2          string(100)
             ,p_timestamp        timestamp
           --  ,p_rowid            rowid
             ,p_timestamp_tz     timestamp with time zone
             ,p_timestamp_ltz    timestamp with local time zone
             ,p_interval_ds      interval day to second
             ,p_interval_ym      interval year to month
);
--
PROCEDURE art_test (p_art1 in out art
                   ,p_art2 in out art
                   ,p_art3    out art);
--
PROCEDURE art_test2 (p_art1 in     art
                    ,p_art2 in out art
                    ,p_art3    out art);
--
PROCEDURE art_test3 (p_art1    out art
                    ,p_art2 in out art
                    ,p_art3 in     art);
--
END;
.
/

show errors

CREATE OR REPLACE PACKAGE BODY axis_record_test AS
--
PROCEDURE art_test (p_art1 in out art
                   ,p_art2 in out art
                   ,p_art3    out art) IS
--
BEGIN
--
  p_art3 := p_art1;
--
END;
--
PROCEDURE art_test2 (p_art1 in     art
                    ,p_art2 in out art
                    ,p_art3    out art) IS
--
BEGIN
--
  p_art3 := p_art1;
--
END;
--
PROCEDURE art_test3 (p_art1    out art
                    ,p_art2 in out art
                    ,p_art3 in     art) IS
--
BEGIN
--
  p_art1 := p_art3;
--
END;
--
END;
.
/

show errors


create or replace function axis_test_scalar_datatypes
             (p_binary_integer  in out binary_integer
             ,p_dec             in out dec
             ,p_decimal         in out decimal
             ,p_double          in out double precision
             ,p_float           in out float
             ,p_int             in out int
             ,p_integer         in out integer
             ,p_natural         in out natural
             ,p_naturaln        in out naturaln
             ,p_number          in out number
             ,p_numeric         in out numeric
             ,p_pls_integer     in out pls_integer
             ,p_positive        in out positive
             ,p_positiven       in out positiven
             ,p_real            in out real
             ,p_signtype        in out signtype
             ,p_smallint        in out smallint
             ,p_char            in out char
             ,p_character       in out character
             ,p_long               out long
             ,p_string          in out string
             ,p_varchar         in out varchar
             ,p_varchar2        in out varchar2
             ,p_boolean         in out boolean
             ,p_date            in out date
             ,p_string2          in out string
             ,p_timestamp        in out timestamp
             ,p_rowid            in out rowid
             ,p_timestamp_tz     in out timestamp with time zone
             ,p_timestamp_ltz    in out timestamp with local time zone
             ,p_interval_ds      in out interval day to second 
             ,p_interval_ym      in out interval year to month
) RETURN varchar2 IS
--
BEGIN
--
--
  p_long := 'Hello World';
  p_positiven := greatest(p_positiven,1);
  p_naturaln := greatest(p_naturaln,1);
  RETURN 'Hello';
--
END;
.
/

show errors
 

create or replace procedure long_raw_proc(in_param in long raw
                     ,out_param out long raw
                     ,in_out_param in out long raw) AS
--
BEGIN
--
  out_param := in_param||in_out_param;
--
END;
.
/

show errors

create or replace procedure raw_proc(in_param in raw
                     ,out_param out raw
                     ,in_out_param in out raw) As
--
BEGIN
--
  out_param := in_param||in_out_param;
--
END;
.
/

create or replace procedure raw_proc2(in_param in raw
                     ,out_param out raw) as
--
BEGIN
--
  out_param := in_param||in_param;
--
END;
.
/

drop table timestamp_madness;

create table timestamp_madness
(timestamp_value   varchar2(80)
,timestamp_generic timestamp
,timestamp_0       timestamp (0)
,timestamp_1       timestamp (1)
,timestamp_2       timestamp (2)
,timestamp_3       timestamp (3)
,timestamp_4       timestamp (4)
,timestamp_5       timestamp (5)
,timestamp_6       timestamp (6)
,timestamp_7       timestamp (7)
,timestamp_8       timestamp (8)
,timestamp_9       timestamp (9)
);

insert into timestamp_madness (timestamp_value) values ('all null');

insert into timestamp_madness (timestamp_value
,timestamp_generic
,timestamp_0
,timestamp_1
,timestamp_2
,timestamp_3
,timestamp_4
,timestamp_5
,timestamp_6
,timestamp_7
,timestamp_8
,timestamp_9) 
values 
('no seconds'
,timestamp '1997-01-31 09:26:50.000000000'
,timestamp '1997-01-31 09:26:50.000000000'
,timestamp '1997-01-31 09:26:50.000000000'
,timestamp '1997-01-31 09:26:50.000000000'
,timestamp '1997-01-31 09:26:50.000000000'
,timestamp '1997-01-31 09:26:50.000000000'
,timestamp '1997-01-31 09:26:50.000000000'
,timestamp '1997-01-31 09:26:50.000000000'
,timestamp '1997-01-31 09:26:50.000000000'
,timestamp '1997-01-31 09:26:50.000000000'
,timestamp '1997-01-31 09:26:50.000000000'
);

insert into timestamp_madness (timestamp_value
,timestamp_generic
,timestamp_0
,timestamp_1
,timestamp_2
,timestamp_3
,timestamp_4
,timestamp_5
,timestamp_6
,timestamp_7
,timestamp_8
,timestamp_9) 
values 
('nine seconds'
,timestamp '1997-01-31 09:26:50.123456789'
,timestamp '1997-01-31 09:26:50.123456789'
,timestamp '1997-01-31 09:26:50.123456789'
,timestamp '1997-01-31 09:26:50.123456789'
,timestamp '1997-01-31 09:26:50.123456789'
,timestamp '1997-01-31 09:26:50.123456789'
,timestamp '1997-01-31 09:26:50.123456789'
,timestamp '1997-01-31 09:26:50.123456789'
,timestamp '1997-01-31 09:26:50.123456789'
,timestamp '1997-01-31 09:26:50.123456789'
,timestamp '1997-01-31 09:26:50.123456789'
);


create table timestamp_tz_madness
(timestamp_value   varchar2(80)
,timestamp_generic timestamp with time zone
,timestamp_0       timestamp (0) with time zone
,timestamp_1       timestamp (1) with time zone
,timestamp_2       timestamp (2) with time zone
,timestamp_3       timestamp (3) with time zone
,timestamp_4       timestamp (4) with time zone
,timestamp_5       timestamp (5) with time zone
,timestamp_6       timestamp (6) with time zone
,timestamp_7       timestamp (7) with time zone
,timestamp_8       timestamp (8) with time zone
,timestamp_9       timestamp (9) with time zone
);

insert into timestamp_tz_madness (timestamp_value) values ('all null');

insert into timestamp_tz_madness (timestamp_value
,timestamp_generic
,timestamp_0
,timestamp_1
,timestamp_2
,timestamp_3
,timestamp_4
,timestamp_5
,timestamp_6
,timestamp_7
,timestamp_8
,timestamp_9) 
values 
('no seconds'
,timestamp '1997-01-31 09:26:50.000000000 -8:00'
,timestamp '1997-01-31 09:26:50.000000000 -8:00'
,timestamp '1997-01-31 09:26:50.000000000 -8:00'
,timestamp '1997-01-31 09:26:50.000000000 -8:00'
,timestamp '1997-01-31 09:26:50.000000000 -8:00'
,timestamp '1997-01-31 09:26:50.000000000 -8:00'
,timestamp '1997-01-31 09:26:50.000000000 -8:00'
,timestamp '1997-01-31 09:26:50.000000000 -8:00'
,timestamp '1997-01-31 09:26:50.000000000 -8:00'
,timestamp '1997-01-31 09:26:50.000000000 -8:00'
,timestamp '1997-01-31 09:26:50.000000000 -8:00'
);

insert into timestamp_tz_madness (timestamp_value
,timestamp_generic
,timestamp_0
,timestamp_1
,timestamp_2
,timestamp_3
,timestamp_4
,timestamp_5
,timestamp_6
,timestamp_7
,timestamp_8
,timestamp_9) 
values 
('nine seconds'
,timestamp '1997-01-31 09:26:50.123456789 -8:00'
,timestamp '1997-01-31 09:26:50.123456789 -8:00'
,timestamp '1997-01-31 09:26:50.123456789 -8:00'
,timestamp '1997-01-31 09:26:50.123456789 -8:00'
,timestamp '1997-01-31 09:26:50.123456789 -8:00'
,timestamp '1997-01-31 09:26:50.123456789 -8:00'
,timestamp '1997-01-31 09:26:50.123456789 -8:00'
,timestamp '1997-01-31 09:26:50.123456789 -8:00'
,timestamp '1997-01-31 09:26:50.123456789 -8:00'
,timestamp '1997-01-31 09:26:50.123456789 -8:00'
,timestamp '1997-01-31 09:26:50.123456789 -8:00'
);

create table timestamp_ltz_madness
(timestamp_value   varchar2(80)
,timestamp_generic timestamp
,timestamp_0       timestamp (0)
,timestamp_1       timestamp (1)
,timestamp_2       timestamp (2)
,timestamp_3       timestamp (3)
,timestamp_4       timestamp (4)
,timestamp_5       timestamp (5)
,timestamp_6       timestamp (6)
,timestamp_7       timestamp (7)
,timestamp_8       timestamp (8)
,timestamp_9       timestamp (9)
);

insert into timestamp_ltz_madness (timestamp_value) values ('all null');

insert into timestamp_ltz_madness (timestamp_value
,timestamp_generic
,timestamp_0
,timestamp_1
,timestamp_2
,timestamp_3
,timestamp_4
,timestamp_5
,timestamp_6
,timestamp_7
,timestamp_8
,timestamp_9) 
values 
('no seconds'
,timestamp '1997-01-31 09:26:50.000000000'
,timestamp '1997-01-31 09:26:50.000000000'
,timestamp '1997-01-31 09:26:50.000000000'
,timestamp '1997-01-31 09:26:50.000000000'
,timestamp '1997-01-31 09:26:50.000000000'
,timestamp '1997-01-31 09:26:50.000000000'
,timestamp '1997-01-31 09:26:50.000000000'
,timestamp '1997-01-31 09:26:50.000000000'
,timestamp '1997-01-31 09:26:50.000000000'
,timestamp '1997-01-31 09:26:50.000000000'
,timestamp '1997-01-31 09:26:50.000000000'
);

insert into timestamp_ltz_madness (timestamp_value
,timestamp_generic
,timestamp_0
,timestamp_1
,timestamp_2
,timestamp_3
,timestamp_4
,timestamp_5
,timestamp_6
,timestamp_7
,timestamp_8
,timestamp_9) 
values 
('nine seconds'
,timestamp '1997-01-31 09:26:50.123456789'
,timestamp '1997-01-31 09:26:50.123456789'
,timestamp '1997-01-31 09:26:50.123456789'
,timestamp '1997-01-31 09:26:50.123456789'
,timestamp '1997-01-31 09:26:50.123456789'
,timestamp '1997-01-31 09:26:50.123456789'
,timestamp '1997-01-31 09:26:50.123456789'
,timestamp '1997-01-31 09:26:50.123456789'
,timestamp '1997-01-31 09:26:50.123456789'
,timestamp '1997-01-31 09:26:50.123456789'
,timestamp '1997-01-31 09:26:50.123456789'
);

     

create table interval_ym_madness
(interval_value   varchar2(80)
,interval_generic interval year to month
,interval_0       interval year (0) to month
,interval_1       interval year (1) to month
,interval_2       interval year (2) to month
,interval_3       interval year (3) to month
,interval_4       interval year (4) to month
,interval_5       interval year (5) to month
,interval_6       interval year (6) to month
,interval_7       interval year (7) to month
,interval_8       interval year (8) to month
,interval_9       interval year (9) to month
);
insert into interval_ym_madness (interval_value) values ('all null');


insert into interval_ym_madness 
(interval_value
,interval_generic
,interval_0
,interval_1
,interval_2
,interval_3
,interval_4
,interval_5
,interval_6
,interval_7
,interval_8
,interval_9) 
values 
('232'
,INTERVAL '23-2'  YEAR TO MONTH
,INTERVAL '0-2'  YEAR TO MONTH
,INTERVAL '1-2'  YEAR TO MONTH
,INTERVAL '12-11'  YEAR TO MONTH
,INTERVAL '123-2' YEAR(3) TO MONTH
,INTERVAL '1234-2' YEAR(4) TO MONTH
,INTERVAL '12345-2' YEAR(5) TO MONTH
,INTERVAL '123456-2' YEAR(6) TO MONTH
,INTERVAL '1234567-2' YEAR(7) TO MONTH
,INTERVAL '12345678-2' YEAR(8) TO MONTH
,INTERVAL '123456789-2' YEAR(9) TO MONTH
);

create table interval_ds_madness
(interval_value   varchar2(80)
,interval_generic interval day to second
,interval_0       interval day (0) to second (0)
,interval_1       interval day (1) to second (1)
,interval_2       interval day (2) to second (2)
,interval_3       interval day (3) to second (3)
,interval_4       interval day (4) to second (4)
,interval_5       interval day (5) to second (5)
,interval_6       interval day (6) to second (6)
,interval_7       interval day (7) to second (7)
,interval_8       interval day (8) to second (8)
,interval_9       interval day (9) to second (9)
);

insert into interval_ds_madness (interval_value) values ('all null');


insert into interval_ds_madness
(interval_value
,interval_generic
,interval_0
,interval_1
,interval_2
,interval_3
,interval_4
,interval_5
,interval_6
,interval_7
,interval_8
,interval_9)
values
('232'
,INTERVAL '23 0:0:2'  DAY TO SECOND
,INTERVAL '0 0:0:2'  DAY TO SECOND
,INTERVAL '3 0:0:2'  DAY TO SECOND
,INTERVAL '23 0:0:2'  DAY TO SECOND
,INTERVAL '23 0:0:2'  DAY TO SECOND
,INTERVAL '23 0:0:2'  DAY TO SECOND
,INTERVAL '23 0:0:2'  DAY TO SECOND
,INTERVAL '23 0:0:2'  DAY TO SECOND
,INTERVAL '11:12:10.2222222' HOUR TO SECOND(7)
,INTERVAL '23 0:0:2'  DAY TO SECOND
,INTERVAL '999999999 0:0:2.999999999'  DAY(9) TO SECOND(9)
);

REM create table all_normal_datatypes_10g
REM (name varchar2(4000)
REM ,date_generic date
REM ,timestamp_generic timestamp
REM ,timestamp_tz timestamp with time zone
REM ,timestamp_local_tz timestamp with local time zone
REM ,date_year_2_month interval year (2) to month
REM ,date_day_2_second interval day (6) to second
REM ,a_rowid rowid
REM ,a_u_rowid urowid
REM );

 
