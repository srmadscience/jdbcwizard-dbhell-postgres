
set echo on
set feedback on
set showmode on

connect system/manager@&1
REM connect system/zirconium123@&1

drop user generic_testd cascade;

grant connect, resource to generic_testd identified by generic_testd;
alter user generic_testd quota unlimited on users;

connect generic_testd/generic_testd@&1

 CREATE TABLE "GENERIC_TABLE" 
   (	"VARCHAR2_COL" VARCHAR2(20 BYTE), 
	"DATE_COL" DATE, 
	"NUMBER_COL" NUMBER
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT);

CREATE TABLE "TEST" 
   (	"RAW_COL" RAW(10)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT);


CREATE OR REPLACE PACKAGE plsql_indexby_tables AS
--
TYPE indexByTabDate IS TABLE OF DATE INDEX BY BINARY_INTEGER;
--
TYPE indexByTabTimestamp IS TABLE OF TIMESTAMP(6) INDEX BY BINARY_INTEGER;
--
TYPE indexByTabRaw IS TABLE OF RAW(2000) INDEX BY BINARY_INTEGER;
--
TYPE indexByTabChar IS TABLE OF VARCHAR2(20) INDEX BY BINARY_INTEGER;
--
TYPE indexByTabNumber IS TABLE OF number(10,0) INDEX BY BINARY_INTEGER;
--
TYPE indexByTabFloatNumber IS TABLE OF number(10,2) INDEX BY BINARY_INTEGER;
--
PROCEDURE proc_01 (p1 in     indexByTabChar
                  ,p2 in out indexByTabChar
                  ,p3    out indexByTabChar
                  , status OUT VARCHAR2);
--
PROCEDURE proc_02 (p1 in     indexByTabNumber
                  ,p2 in out indexByTabNumber
                  ,p3    out indexByTabNumber
                  , status OUT BOOLEAN);
--
PROCEDURE proc_03 (p1 in     indexByTabFloatNumber
                  ,p2 in out indexByTabFloatNumber
                  ,p3    out indexByTabFloatNumber
                  , status OUT BOOLEAN);
--
PROCEDURE proc_date (p1 in     indexByTabDate
                    ,p2 in out indexByTabDate
                    ,p3    out indexByTabDate
                    , status OUT BOOLEAN);
--
PROCEDURE proc_ts   (p1 in     indexByTabTimestamp
                    ,p2 in out indexByTabTimestamp
                    ,p3    out indexByTabTimestamp
                    , status OUT BOOLEAN);
--
PROCEDURE proc_raw  (p1 in     indexByTabRaw
                    ,p2 in out indexByTabRaw
                    ,p3    out indexByTabRaw
                    , status OUT BOOLEAN);
--
END;
/


show errors

CREATE OR REPLACE PACKAGE BODY plsql_indexby_tables AS
--
PROCEDURE proc_01 (p1 in indexByTabChar
                  ,p2 in out indexByTabChar
                  ,p3    out indexByTabChar 
                  ,status OUT VARCHAR2) IS
--
BEGIN
--
  FOR i in 1..80 LOOP
--
    p3(i) := ltrim(to_char(i,'RN'));
--
  END LOOP;
--
  p3(97) := 'END';
--
  p2(2) := 'TWO';
--
END;
--
PROCEDURE proc_02 (p1 in     indexByTabNumber
                  ,p2 in out indexByTabNumber
                  ,p3    out indexByTabNumber
                  , status OUT BOOLEAN) IS
--
BEGIN
--
  FOR i in 1..80 LOOP
--
    p3(i) := i;
--
  END LOOP;
--
  p2(3) := p2(1) + p2(2);
--
  status := true;
--
END;
--
PROCEDURE proc_03 (p1 in     indexByTabFloatNumber
                  ,p2 in out indexByTabFloatNumber
                  ,p3    out indexByTabFloatNumber
                  , status OUT BOOLEAN) IS
--
BEGIN
--
  FOR i in 1..80 LOOP
--
    p3(i) := i;
--
  END LOOP;
--
  p2(3) := p2(1) + p2(2);
--
  status := true;
--
END;
--
PROCEDURE proc_date (p1 in     indexByTabDate
                    ,p2 in out indexByTabDate
                    ,p3    out indexByTabDate
                    , status OUT BOOLEAN) IS
--
BEGIN
--
  FOR i in 1..80 LOOP
--
    p3(i) := sysdate + i;
--
  END LOOP;
--
  p2(3) := p2(1) +1;
--
  status := true;
--
END;
--
--
PROCEDURE proc_ts   (p1 in     indexByTabTimestamp
                    ,p2 in out indexByTabTimestamp
                    ,p3    out indexByTabTimestamp
                    , status OUT BOOLEAN) IS
--
BEGIN
--
  FOR i in 1..80 LOOP
--
    p3(i) := sysdate + i;
--
  END LOOP;
--
  p2(3) := p2(1) +1;
--
  status := true;
--
END;
--
--
PROCEDURE proc_raw  (p1 in     indexByTabRaw
                    ,p2 in out indexByTabRaw
                    ,p3    out indexByTabRaw
                    , status OUT BOOLEAN) IS
--
--
BEGIN
--
  FOR i in 1..80 LOOP
--
    p3(i) := p2(1);
--
  END LOOP;
--
  p2(3) := p2(1);
--
  status := true;
--
END;
--
END;
/


show errors

create or replace package iba_test as

  /* TODO enter package declarations (types, exceptions, methods etc) here */
    type varchar2_iba is table of varchar2(20) index by binary_integer;
    type int_iba is table of number(3) index by binary_integer;
    type number_iba is table of number(30,15) index by binary_integer;
    type date_iba is table of date index by binary_integer;
    type timestamp_iba is table of timestamp index by binary_integer;
    type timestamp_tz_iba is table of timestamp with time zone index by binary_integer;
    type timestamp_ltz_iba is table of timestamp with local time zone index by binary_integer;
    type raw_iba is table of raw(40) index by binary_integer;

  type l_rec IS RECORD (a_vc2_array varchar2_iba
                       ,a_int_array int_iba
                       ,a_number_iba number_iba
                       ,a_date_iba date_iba
                       ,a_ts_iba timestamp_iba
                       ,a_raw_iba raw_iba);
  
  type  l_rec_array_t IS TABLE of l_rec;
  type  l_rec_array_v IS VARRAY(20) of l_rec;

    procedure test_varchar2_iba(p_in in varchar2_iba, p_in_out in out varchar2_iba,p_out out varchar2_iba);
    procedure test_int_iba(p_in in int_iba, p_in_out in out int_iba, p_out out int_iba);
    procedure test_number(p_in in number_iba, p_in_out in out number_iba, p_out out number_iba);
    procedure test_date(p_in in date_iba, p_in_out in out date_iba, p_out out date_iba);
    procedure test_timestamp(p_in in timestamp_iba, p_in_out in out timestamp_iba, p_out out timestamp_iba);
    procedure test_timestamp_tz(p_in in timestamp_tz_iba, p_in_out in out timestamp_tz_iba, p_out out timestamp_tz_iba);
    procedure test_timestamp_ltz(p_in in timestamp_ltz_iba, p_in_out in out timestamp_ltz_iba, p_out out timestamp_ltz_iba);
    procedure test_raw(p_in in raw_iba, p_in_out in out raw_iba, p_out out raw_iba);
    procedure test_rec(p_in in l_rec, p_in_out in out l_rec, p_out out l_rec);
    
end iba_test;
.
/

create or replace package body iba_test as

  procedure test_varchar2_iba(p_in in varchar2_iba, p_in_out in out varchar2_iba,p_out out varchar2_iba) as
  begin
    p_out := p_in;
    
  end test_varchar2_iba;

  procedure test_int_iba(p_in in int_iba, p_in_out in out int_iba, p_out out int_iba) as
  begin
    p_out := p_in;
  end test_int_iba;

  procedure test_number(p_in in number_iba, p_in_out in out number_iba, p_out out number_iba) as
  begin
    p_out := p_in;
  end test_number;

  procedure test_date(p_in in date_iba, p_in_out in out date_iba, p_out out date_iba) as
  begin
    p_out := p_in;
  end test_date;

  procedure test_timestamp(p_in in timestamp_iba, p_in_out in out timestamp_iba, p_out out timestamp_iba) as
  begin
    p_out := p_in;
  end test_timestamp;

  procedure test_timestamp_tz(p_in in timestamp_tz_iba, p_in_out in out timestamp_tz_iba, p_out out timestamp_tz_iba) as
  begin
    p_out := p_in;
  end test_timestamp_tz;

  procedure test_timestamp_ltz(p_in in timestamp_ltz_iba, p_in_out in out timestamp_ltz_iba, p_out out timestamp_ltz_iba) as
  begin
    p_out := p_in;
  end test_timestamp_ltz;

  procedure test_raw(p_in in raw_iba, p_in_out in out raw_iba, p_out out raw_iba) as
  begin
    p_out := p_in;
  end test_raw;
procedure test_rec(p_in in l_rec, p_in_out in out l_rec, p_out out l_rec) IS
--
begin
--
 p_out := p_in;
--
end;
end iba_test;
.
/

create or replace PACKAGE APACK AS

  l_row generic_table%ROWTYPE;
  
  type l_row_array_t IS TABLE of generic_table%ROWTYPE;
  type l_row_array_v IS VARRAY(20) of generic_table%ROWTYPE;
  
  cursor l_row_cur IS SELECT * FROM generic_table;
  
  type  l_row_cur_t IS TABLE of l_row_cur%ROWTYPE;
  type  l_row_cur_v IS VARRAY(20) of l_row_cur%ROWTYPE;
  
  type l_rec IS RECORD ("VARCHAR2_COL" VARCHAR2(20 BYTE), 
	"DATE_COL" DATE, 
	"NUMBER_COL" NUMBER);
  
  type  l_rec_array_t IS TABLE of l_rec;
  type  l_rec_array_v IS VARRAY(20) of l_rec;
  
  --
  
    type varchar2_iba is table of varchar2(20) index by binary_integer;
    type varchar2_int is table of number(3) index by binary_integer;
    type varchar2_number is table of number(30,15) index by binary_integer;
    type varchar2_date is table of varchar2(20) index by binary_integer;
    type varchar2_timestamp is table of varchar2(20) index by binary_integer;



 procedure tbool (p_bool in out boolean);

  procedure a_test(p_io_t  in out  l_row_array_t);
                  
  procedure b_test(p_in_t  in      l_row_array_t
                  ,p_io_t  in out  l_row_array_t
                  ,p_out_t    out  l_row_array_t
                  ,p_in_v  in      l_row_array_v
                  ,p_io_v  in out  l_row_array_v
                  ,p_out_v    out  l_row_array_v
                  ,p_in_ct  in     l_row_cur_t
                  ,p_io_ct  in out l_row_cur_t
                  ,p_out_ct    out l_row_cur_t
                  ,p_in_cv  in     l_row_cur_v
                  ,p_io_cv  in out l_row_cur_v
                  ,p_out_cv    out l_row_cur_v 
                  ,p_in_rv  in     l_rec_array_v
                  ,p_io_rv  in out l_rec_array_v
                  ,p_out_rv    out l_rec_array_v 
                  ,p_in_rt  in     l_rec_array_t
                  ,p_io_rt  in out l_rec_array_t
                  ,p_out_rt    out l_rec_array_t 
                  
                  );
END APACK;
.
/

create or replace PACKAGE BODY APACK AS

procedure tbool (p_bool in out boolean) is
begin
null;
end;

  procedure atest is
  
  p_io_t   l_row_array_t := l_row_array_t();

  type t1 is table of varchar2(20) index by
binary_integer;
  t1v t1; -- :1
  
  type t2 is table of varchar2(20) index by
binary_integer;
  t2v t2; -- :2
  
  type t3 is table of varchar2(20) index by
binary_integer;
  t3v t3; -- :3
  
  
    
    
  begin
    t1v(1) := '42';
    t2v(1) := 'foo';
    t3v(1) := '20080808000000';


  FOR i IN t1v.FIRST .. t1v.LAST LOOP -- We assume all arrays same length
 
   p_io_t(i).number_col   := TO_NUMBER(t1v(i));
   p_io_t(i).VARCHAR2_COL := t2v(i);
   p_io_t(i).date_col :=
TO_DATE(t3v(i),'YYYYMMDDHH24MISS');
   
  END LOOP;
  
  a_test(p_io_t);
  
   FOR i IN p_io_t.FIRST .. p_io_t.LAST LOOP
 
   t1v(i) :=
TO_CHAR(p_io_t(i).number_col,'99999999999999999');
   t2v(i) := p_io_t(i).VARCHAR2_COL;
   t3v(i) :=
TO_CHAR(p_io_t(i).date_col,'YYYYMMDDHH24MISS');
   
   
  END LOOP;
  
  -- :4 := t1v;
  -- :5 := t2v;
  -- :6 := t3v;


  end;
  
  
  procedure a_test(p_io_t  in out  l_row_array_t) AS
  BEGIN
    /* TODO implementation required */
    NULL;
  END a_test;

  procedure b_test(p_in_t  in      l_row_array_t
                  ,p_io_t  in out  l_row_array_t
                  ,p_out_t    out  l_row_array_t
                  ,p_in_v  in      l_row_array_v
                  ,p_io_v  in out  l_row_array_v
                  ,p_out_v    out  l_row_array_v
                  ,p_in_ct  in     l_row_cur_t
                  ,p_io_ct  in out l_row_cur_t
                  ,p_out_ct    out l_row_cur_t
                  ,p_in_cv  in     l_row_cur_v
                  ,p_io_cv  in out l_row_cur_v
                  ,p_out_cv    out l_row_cur_v 
                  ,p_in_rv  in     l_rec_array_v
                  ,p_io_rv  in out l_rec_array_v
                  ,p_out_rv    out l_rec_array_v 
                  ,p_in_rt  in     l_rec_array_t
                  ,p_io_rt  in out l_rec_array_t
                  ,p_out_rt    out l_rec_array_t 
                  
                  ) AS
  BEGIN
    /* TODO implementation required */
    NULL;
  END b_test;

END APACK;
.
/


exit


exit
