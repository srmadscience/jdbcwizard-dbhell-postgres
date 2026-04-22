
set echo on
set feedback on
set showmode on

connect system/manager@&1

drop user bytetest cascade;


grant connect, resource,dba to bytetest identified by bytetest;

connect bytetest/bytetest@&1

drop directory bytetest_testdir1;
create directory bytetest_testdir1 as '/export/data/Test/Lob';

create sequence generic_seq;

select * from all_directories;

drop table lob_table;

create table lob_table
(a_seqno number
,a_longraw long raw
,a_clob    clob
,a_blob    blob
,a_bfile   bfile)
tablespace dbhell;


insert into lob_table
values
(1,hextoraw('6A')||hextoraw('6B')||hextoraw('6C')
,'A clob value'
,hextoraw('6A')||hextoraw('6B')||hextoraw('6C')
,bfilename('BYTETEST_TESTDIR1','GenericFile.txt'));

insert into lob_table
values
(2,hextoraw('6A')||hextoraw('6B')||hextoraw('6C')
,'A clob value'
,hextoraw('6A')||hextoraw('6B')||hextoraw('6C')
,bfilename('BYTETEST_TESTDIR1','GenericFile.txt'));

insert into lob_table
values
(3,hextoraw('6A')||hextoraw('6B')||hextoraw('6C')
,'A clob value'
,hextoraw('6A')||hextoraw('6B')||hextoraw('6C')
,bfilename('BYTETEST_TESTDIR1','GenericFile.txt'));

insert into lob_table
values
(4,hextoraw('6A')||hextoraw('6B')||hextoraw('6C')
,'A clob value'
,hextoraw('6A')||hextoraw('6B')||hextoraw('6C')
,bfilename('BYTETEST_TESTDIR1','GenericFile.txt'));

insert into lob_table
values
(5,hextoraw('6A')||hextoraw('6B')||hextoraw('6C')
,'A clob value'
,hextoraw('6A')||hextoraw('6B')||hextoraw('6C')
,bfilename('BYTETEST_TESTDIR1','GenericFile.txt'));

insert into lob_table
values
(6,hextoraw('6A')||hextoraw('6B')||hextoraw('6C')
,'A clob value'
,hextoraw('6A')||hextoraw('6B')||hextoraw('6C')
,bfilename('BYTETEST_TESTDIR1','GenericFile.txt'));

drop type type_array_lobs;

CREATE TYPE TYPE_ARRAY_LOBS AS OBJECT
(lob_NAME VARCHAR2(100)
,a_clob   CLOB
,a_blob   BLOB
,a_bfile  BFILE
);
.
/

show errors

CREATE OR REPLACE TYPE TBL_ARRAY_LOBS  AS TABLE OF TYPE_ARRAY_LOBS;
.
/
show errors

REM CREATE OR REPLACE TYPE TBL_VARRAY_LOBS  AS VARRAY(100) OF TYPE_ARRAY_LOBS;
REM .
REM /
REM show errors
REM 
CREATE OR REPLACE TYPE TBL_VARRAY_LOBS  AS VARRAY(100) OF TYPE_ARRAY_LOBS;
.
/
show errors

REM create or replace package bytetest as
REM --
REM TYPE recordType IS RECORD (
REM  a_long_raw long raw
REM ,a_clob clob
REM ,a_blob blob
REM ,a_bfile bfile);
REM --
REM TYPE lob_datatypes_typ IS REF CURSOR RETURN lob_table%ROWTYPE;  -- strong
REM --
REM TYPE GenericCurTyp IS REF CURSOR;  -- weak
REM --
REM procedure cur1(out_param out lob_datatypes_typ);
REM --
REM procedure cur2(out_param out GenericCurTyp);
REM --
REM procedure rec1(in_param  in recordType
REM               ,out_param out recordType);
REM --
REM function cur4 (in_param number) return GenericCurTyp;
REM --
REM PROCEDURE arraytest7 (p_param1 in out TBL_VARRAY_lobs
REM                      ,p_param2 in out TBL_ARRAY_lobs);
REM --
REM PROCEDURE norm1 (p_in_blob in blob
REM                 ,p_in_clob in clob
REM                 ,p_out_bfile out bfile
REM                 ,p_out_blon out blob
REM                 ,p_out_clob out clob);
REM --
REM end;
REM .
REM /
REM 
REM show errors;
REM 
REM create or replace package body bytetest
REM as
REM --
REM procedure cur1(out_param out lob_datatypes_typ) is
REM --
REM BEGIN
REM --
REM   open out_param for select * from lob_table;
REM --
REM END;
REM --
REM procedure cur2(out_param out genericcurtyp) is
REM --
REM BEGIN
REM --
REM   open out_param for select * from lob_table;
REM --
REM END;
REM --
REM procedure rec1(in_param  in recordType
REM               ,out_param out recordType) IS
REM --
REM BEGIN
REM --
REM out_param := in_param;
REM --
REM END;
REM --
REM function cur4 (in_param number) return GenericCurTyp is
REM --
REM   tempCur GenericCurTyp;
REM --
REM begin
REM --
REM   IF in_param IS NULL THEN
REM --
REM     open tempCur for select * from dual where 1 = 2;
REM --
REM   ELSIF in_param = 0 THEN
REM --
REM     null;
REM --
REM   ELSIF in_param = 1 THEN
REM --
REM     open tempCur for SELECT a_bfile  FROM lob_table WHERE rownum < 3;
REM --
REM   ELSIF in_param = 2 THEN
REM --
REM     open tempCur for SELECT a_longraw FROM lob_table WHERE rownum < 3;
REM --
REM   ELSIF in_param = 3 THEN
REM --
REM     open tempCur for SELECT a_clob FROM lob_table WHERE rownum < 3;
REM --
REM   ELSIF in_param = 4 THEN
REM --
REM     open tempCur for SELECT a_blob FROM lob_table WHERE rownum < 3;
REM --
REM   END IF;
REM --
REM   return tempCur;
REM --
REM end;
REM --
REM PROCEDURE arraytest7 (p_param1 in out TBL_VARRAY_lobs
REM                      ,p_param2 in out TBL_ARRAY_lobs) IS
REM --
REM BEGIN
REM --
REM   NULL;
REM --
REM END;
REM --
REM PROCEDURE norm1 (p_in_blob in blob
REM                 ,p_in_clob in clob
REM                 ,p_out_bfile out bfile
REM                 ,p_out_blon out blob
REM                 ,p_out_clob out clob) IS
REM --
REM begin
REM --
REM   null;
REM --
REM end;
REM --
REM end;
REM --
REM .
REM /
REM 
REM show errors


create or replace package bytetestthepackage as
--
TYPE recordType IS RECORD (
 a_long_raw long raw
,a_clob clob
,a_blob blob
,a_bfile bfile);
--
TYPE lob_datatypes_typ IS REF CURSOR RETURN lob_table%ROWTYPE;  -- strong
--
TYPE GenericCurTyp IS REF CURSOR;  -- weak
--
procedure cur1(out_param out lob_datatypes_typ);
--
procedure cur2(out_param out GenericCurTyp);
--
procedure rec1(in_param  in recordType
              ,out_param out recordType);
--
function cur4 (in_param number) return GenericCurTyp;
--
PROCEDURE arraytest7 (p_param1 in out TBL_VARRAY_lobs
                     ,p_param2 in out TBL_ARRAY_lobs);
--
PROCEDURE norm1 (p_in_blob in blob
                ,p_in_clob in clob
                ,p_out_bfile out bfile
                ,p_out_blon out blob
                ,p_out_clob out clob);
--
end;
.
/

show errors;

create or replace package body bytetestthepackage
as
--
procedure cur1(out_param out lob_datatypes_typ) is
--
BEGIN
--
  open out_param for select * from lob_table;
--
END;
--
procedure cur2(out_param out genericcurtyp) is
--
BEGIN
--
  open out_param for select * from lob_table;
--
END;
--
procedure rec1(in_param  in recordType
              ,out_param out recordType) IS
--
BEGIN
--
out_param := in_param;
--
END;
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
    open tempCur for SELECT a_bfile  FROM lob_table WHERE rownum < 3;
--
  ELSIF in_param = 2 THEN
--
    open tempCur for SELECT a_longraw FROM lob_table WHERE rownum < 3;
--
  ELSIF in_param = 3 THEN
--
    open tempCur for SELECT a_clob FROM lob_table WHERE rownum < 3;
--
  ELSIF in_param = 4 THEN
--
    open tempCur for SELECT a_blob FROM lob_table WHERE rownum < 3;
--
  END IF;
--
  return tempCur;
--
end;
--
PROCEDURE arraytest7 (p_param1 in out TBL_VARRAY_lobs
                     ,p_param2 in out TBL_ARRAY_lobs) IS
--
BEGIN
--
  NULL;
--
END;
--
PROCEDURE norm1 (p_in_blob in blob
                ,p_in_clob in clob
                ,p_out_bfile out bfile
                ,p_out_blon out blob
                ,p_out_clob out clob) IS
--
begin
--
  null;
--
end;
--
end;
--
.
/

show errors


exit
