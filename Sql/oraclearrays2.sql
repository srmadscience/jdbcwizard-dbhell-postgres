set echo on

drop table array_commnds;

CREATE TABLE array_COMMANDS (
       COMMAND_NAME         VARCHAR2(100) NOT NULL,
       OS_NAME              VARCHAR2(512) NOT NULL,
       JAVA_CLASS_FILE_NAME VARCHAR2(512) NULL,
       BUILTIN_Y_OR_N       VARCHAR2(1) NOT NULL,
       required_number      number null,
       obligatary_date      date   NULL,
       EXE_FILE_NAME        VARCHAR2(512) NULL,
       COMMAND_DESCRIPTION  VARCHAR2(512) NULL
)
;


drop type type_array_commands;

CREATE TYPE TYPE_array_COMMANDS AS OBJECT 
(COMMAND_NAME VARCHAR2(100)
,OS_NAME VARCHAR2(512)
,JAVA_CLASS_FILE_NAME VARCHAR2(512)
,BUILTIN_Y_OR_N VARCHAR2(1)
,required_number      number null
,obligatary_date      date   NULL
,EXE_FILE_NAME VARCHAR2(512)
,COMMAND_DESCRIPTION VARCHAR2(512)
);
.
/

show errors

CREATE OR REPLACE TYPE TBL_ARRAY_COMMANDS_TYPE  AS TABLE OF TYPE_array_COMMANDS;
.
/
show errors

CREATE OR REPLACE TYPE TBL_VARRAY_COMMANDS_TYPE  AS VARRAY(100) OF TYPE_array_COMMANDS;
.
/
show errors

drop type type_array_lobs;

CREATE TYPE TYPE_array_lobs AS OBJECT
(lob_NAME VARCHAR2(100)
,a_clob   CLOB
,a_blob   BLOB
,a_bfile  BFILE
);
.
/

show errors

CREATE OR REPLACE TYPE TBL_array_lobs  AS TABLE OF TYPE_array_lobs;
.
/
show errors

CREATE OR REPLACE TYPE TBL_Varray_lobs  AS VARRAY(100) OF TYPE_array_lobs;
.
/
show errors

REM CREATE OR REPLACE TYPE TBL_ARRAY_COMMANDS_ROWTYPE  AS TABLE OF array_COMMANDS%ROWTYPE;
REM .
REM /
REM show errors
REM 
REM CREATE OR REPLACE TYPE TBL_VARRAY_COMMANDS_ROWTYPE  AS VARRAY(100) OF array_COMMANDS%ROWTYPE;
REM .
REM /
REM show errors
REM 

CREATE OR REPLACE TYPE TBL_VARRAY_VARCHAR2 AS VARRAY(100) OF VARCHAR2(80);
.
/
show errors

CREATE OR REPLACE TYPE TBL_ARRAY_VARCHAR2  AS TABLE OF VARCHAR2(80);
.
/
show errors

CREATE OR REPLACE TYPE TBL_VARRAY_NUMBER AS VARRAY(100) OF NUMBER;
.
/
show errors

CREATE OR REPLACE TYPE TBL_ARRAY_NUMBER  AS TABLE OF NUMBER;
.
/
show errors

CREATE OR REPLACE TYPE TBL_ARRAY_DATE AS TABLE OF DATE;
.
/
show errors

CREATE OR REPLACE TYPE TBL_VARRAY_DATE AS VARRAY(100) OF DATE;
.
/
show errors

CREATE OR REPLACE TYPE TBL_VARRAY_CLOB AS VARRAY(100) OF CLOB;
.
/
show errors

CREATE OR REPLACE TYPE TBL_ARRAY_CLOB  AS TABLE OF CLOB;
.
/
show errors

CREATE OR REPLACE TYPE TBL_VARRAY_BLOB AS VARRAY(100) OF BLOB;
.
/
show errors

CREATE OR REPLACE TYPE TBL_ARRAY_BLOB  AS TABLE OF BLOB;
.
/
show errors

CREATE OR REPLACE TYPE TBL_VARRAY_BFILE AS VARRAY(100) OF BFILE;
.
/
show errors

CREATE OR REPLACE TYPE TBL_ARRAY_BFILE  AS TABLE OF BFILE;
.
/
show errors

CREATE OR REPLACE TYPE TBL_VARRAY_TIMESTAMP AS VARRAY(100) OF TIMESTAMP;
.
/
show errors

CREATE OR REPLACE TYPE TBL_ARRAY_TIMESTAMP  AS TABLE OF TIMESTAMP;
.
/
show errors

CREATE OR REPLACE TYPE TBL_VARRAY_TIMESTAMPTZ AS VARRAY(100) OF TIMESTAMP WITH TIME ZONE;
.
/
show errors

CREATE OR REPLACE TYPE TBL_ARRAY_TIMESTAMPTZ  AS TABLE OF TIMESTAMP WITH TIME ZONE;
.
/
show errors

CREATE OR REPLACE TYPE TBL_VARRAY_TIMESTAMPLTZ AS VARRAY(100) OF TIMESTAMP WITH LOCAL TIME ZONE;
.
/
show errors

CREATE OR REPLACE TYPE TBL_ARRAY_TIMESTAMPLTZ  AS TABLE OF TIMESTAMP WITH LOCAL TIME ZONE;
.
/
show errors

CREATE OR REPLACE TYPE TBL_VARRAY_RAW AS VARRAY(100) OF RAW(100);
.
/
show errors

CREATE OR REPLACE TYPE TBL_ARRAY_RAW  AS TABLE OF RAW(100);
.
/
show errors

CREATE OR REPLACE TYPE TBL_VARRAY_IYM AS VARRAY(100) OF interval year (2) to month;
.
/
show errors

CREATE OR REPLACE TYPE TBL_ARRAY_IYM  AS TABLE OF interval year (2) to month;
.
/
show errors

CREATE OR REPLACE TYPE TBL_VARRAY_IDS AS VARRAY(100) OF interval day (6) to second;
.
/
show errors

CREATE OR REPLACE TYPE TBL_ARRAY_IDS  AS TABLE OF interval day (6) to second;
.
/
show errors

REM CREATE OR REPLACE TYPE TBL_VARRAY_NUMBERPCT AS VARRAY(100) OF array_COMMANDS.required_number%TYPE;
REM .
REM /
REM show errors

REM CREATE OR REPLACE TYPE TBL_ARRAY_NUMBERPCT AS TABLE OF array_COMMANDS.required_number%TYPE;
REM .
REM /
REM show errors


CREATE OR REPLACE TYPE TBL_ARRAY_SUSER_CMDS_TYPE  AS TABLE OF synuser.TYPE_array_COMMANDS;
.
/
show errors

CREATE OR REPLACE TYPE TBL_VARRAY_SUSER_CMDS_TYPE  AS VARRAY(100) OF synuser.TYPE_array_COMMANDS;
.
/
show errors

create or replace package oracle_arrays_extra as
--
TYPE TBL_ARRAY_COMMANDS_TYPE_OAX  IS TABLE OF TYPE_array_COMMANDS;
TYPE TBL_VARRAY_COMMANDS_TYPE_OAX  IS VARRAY(100) OF TYPE_array_COMMANDS;
--
TYPE TBL_ARRAY_COMMANDS_TYPE_OBX IS TABLE OF TYPE_array_COMMANDS;
TYPE TBL_VARRAY_COMMANDS_TYPE_OBX IS VARRAY(100) OF TYPE_array_COMMANDS;
--
TYPE TBL_ARRAY_COMMANDS_ROWTYPE_OAX  IS TABLE OF array_COMMANDS%ROWTYPE;
TYPE TBL_VARRAY_CMMANDS_ROWTYPE_OAX  IS VARRAY(100) OF array_COMMANDS%ROWTYPE;
--
TYPE TBL_ARRAY_NUMBER_OAX  IS TABLE OF NUMBER;
TYPE TBL_VARRAY_NUMBER_OAX IS VARRAY(100) OF NUMBER;
--
TYPE TBL_VARRAY_NUMBERPCT_OAX IS VARRAY(100) OF array_COMMANDS.required_number%TYPE;
TYPE TBL_ARRAY_NUMBERPCT_OAX IS TABLE OF array_COMMANDS.required_number%TYPE;
--
end;
.
/

show errors

create or replace package oracle_arrays as
--
TYPE TYPE_array_COMMANDS_oa IS RECORD
(COMMAND_NAME VARCHAR2(100)
,OS_NAME VARCHAR2(512)
,JAVA_CLASS_FILE_NAME VARCHAR2(512)
,BUILTIN_Y_OR_N VARCHAR2(1)
,required_number      number null
,obligatary_date      date   NULL
,EXE_FILE_NAME VARCHAR2(512)
,COMMAND_DESCRIPTION VARCHAR2(512)
);
--
TYPE_ARRAY_COMMANDS_RT array_commands%ROWTYPE;
--
TYPE TBL_ARRAY_COMMANDS_TYPE_OA  IS TABLE OF TYPE_array_COMMANDS_oa;
TYPE TBL_VARRAY_COMMANDS_TYPE_OA  IS VARRAY(100) OF TYPE_array_COMMANDS_oa;
--
TYPE TBL_ARRAY_COMMANDS_TYPE_OB  IS TABLE OF TYPE_array_COMMANDS;
TYPE TBL_VARRAY_COMMANDS_TYPE_OB  IS VARRAY(100) OF TYPE_array_COMMANDS;
--
TYPE TBL_ARRAY_COMMANDS_ROWTYPE_OA  IS TABLE OF array_COMMANDS%ROWTYPE;
TYPE TBL_VARRAY_COMMANDS_ROWTYPE_OA  IS VARRAY(100) OF array_COMMANDS%ROWTYPE;
--
TYPE TBL_ARRAY_NUMBER_OA  IS TABLE OF NUMBER;
TYPE TBL_VARRAY_NUMBER_OA IS VARRAY(100) OF NUMBER;
--
TYPE TBL_VARRAY_NUMBERPCT_OA IS VARRAY(100) OF array_COMMANDS.required_number%TYPE;
TYPE TBL_ARRAY_NUMBERPCT_OA IS TABLE OF array_COMMANDS.required_number%TYPE;
--
PROCEDURE arraytest_clob_array(p_param1 in out TBL_VARRAY_CLOB
                              ,p_param2 in out TBL_ARRAY_CLOB); 
--
PROCEDURE arraytest_blob_array(p_param1 in out TBL_VARRAY_BLOB
                              ,p_param2 in out TBL_ARRAY_BLOB); 
--
PROCEDURE arraytest_bfile_array(p_param1 in out TBL_VARRAY_bfile
                              ,p_param2 in out TBL_ARRAY_bfile); 
--
PROCEDURE arraytest_varchar2_array(p_param1 in out TBL_VARRAY_varchar2
                                  ,p_param2 in out TBL_ARRAY_varchar2); 
--
PROCEDURE arraytest_timestamp_array(p_param1 in out TBL_VARRAY_timestamp
                                   ,p_param2 in out TBL_ARRAY_timestamp); 
--
PROCEDURE arraytest_timestamptz_array(p_param1 in out TBL_VARRAY_timestamptz
                                     ,p_param2 in out TBL_ARRAY_timestamptz); 
--
PROCEDURE arraytest_timestampltz_array(p_param1 in out TBL_VARRAY_timestampltz
                                      ,p_param2 in out TBL_ARRAY_timestampltz); 
--
PROCEDURE arraytest_iym_array(p_param1 in out TBL_VARRAY_iym
                             ,p_param2 in out TBL_ARRAY_iym); 
--
PROCEDURE arraytest_ids_array(p_param1 in out TBL_VARRAY_ids
                             ,p_param2 in out TBL_ARRAY_ids); 
--
PROCEDURE arraytest_date_array(p_param1 in out TBL_VARRAY_date
                                   ,p_param2 in out TBL_ARRAY_date); 
--
PROCEDURE arraytest_raw_array(p_param1 in out TBL_VARRAY_raw
                                   ,p_param2 in out TBL_ARRAY_raw); 
--
PROCEDURE arraytest3(p_param1 in out TBL_VARRAY_COMMANDS_TYPE
                    ,p_param2 in out TBL_ARRAY_COMMANDS_TYPE); 
--
PROCEDURE arraytest2(p_param1 in out TBL_VARRAY_NUMBER
                    ,p_param2 in out TBL_ARRAY_NUMBER); 
--
PROCEDURE arraytest4 
--
-- has type_owner, type_name. type_subname is null.
-- type name is a type name
--
-- select c.type_name, c.elem_type_name, c.coll_type, c.upper_bound
--      , a.attr_name
-- from user_coll_types c
--    , user_type_attrs a
-- where c.elem_type_name = a.type_name
-- and   c.type_name = 'TBL_VARRAY_COMMANDS_USR'
-- /
--
(p_param1  in     TBL_ARRAY_COMMANDS_TYPE
,p_param2  in     TBL_ARRAY_COMMANDS_TYPE
,p_param3  in     TBL_VARRAY_COMMANDS_TYPE
,p_param4  in     TBL_VARRAY_COMMANDS_TYPE
--
-- select 'a_value' column_name, c.elem_type_name data_type
-- if c.elem_type_name is not a record.
--
,p_param5  in     TBL_ARRAY_NUMBER
,p_param6  in     TBL_VARRAY_NUMBER
--
-- has type_owner, type_name. type_subname is type name.
-- type name is a package name
--
--
,p_param7  in     TBL_ARRAY_COMMANDS_TYPE_OA
,p_param8  in     TBL_VARRAY_COMMANDS_TYPE_OA
,p_param9  in     TBL_ARRAY_COMMANDS_TYPE_OB
,p_param10 in     TBL_VARRAY_COMMANDS_TYPE_OB
,p_param11 in     TBL_ARRAY_COMMANDS_ROWTYPE_OA
,p_param12 in     TBL_VARRAY_COMMANDS_ROWTYPE_OA
,p_param13 in     TBL_ARRAY_NUMBER_OA
,p_param14 in     TBL_VARRAY_NUMBER_OA
,p_param15 in     TBL_ARRAY_NUMBERPCT_OA
,p_param16 in     oracle_arrays_extra.TBL_VARRAY_NUMBERPCT_OAX
,p_param17  in    oracle_arrays_extra.TBL_ARRAY_COMMANDS_TYPE_OAX
,p_param18  in    oracle_arrays_extra.TBL_VARRAY_COMMANDS_TYPE_OAX
,p_param19  in    oracle_arrays_extra.TBL_ARRAY_COMMANDS_TYPE_OBX
,p_param20 in     oracle_arrays_extra.TBL_VARRAY_COMMANDS_TYPE_OBX
,p_param21 in     oracle_arrays_extra.TBL_ARRAY_COMMANDS_ROWTYPE_OAX
,p_param22 in     oracle_arrays_extra.TBL_VARRAY_CMMANDS_ROWTYPE_OAX
,p_param23 in     oracle_arrays_extra.TBL_ARRAY_NUMBER_OAX
,p_param24 in     oracle_arrays_extra.TBL_VARRAY_NUMBER_OAX
,p_param25 in     oracle_arrays_extra.TBL_ARRAY_NUMBERPCT_OAX
,p_param26 in     oracle_arrays_extra.TBL_VARRAY_NUMBERPCT_OAX
);
--
PROCEDURE arraytest5 (p_param1 in out TBL_VARRAY_COMMANDS_TYPE_OA);
--
PROCEDURE arraytest6 (p_param1 in out TBL_VARRAY_SUSER_CMDS_TYPE
                     ,p_param2 in out TBL_ARRAY_SUSER_CMDS_TYPE
                     ,p_param3 in out synuser.TBL_ARRAY_COMMANDS_TYPE
                     ,p_param4 in out synuser.TBL_VARRAY_COMMANDS_TYPE);
--
PROCEDURE arraytest7 (p_param1 in out TBL_VARRAY_lobs
                     ,p_param2 in out TBL_ARRAY_lobs);
--
END;
.
/

show errors

create or replace package body oracle_arrays as
--
PROCEDURE arraytest_clob_array(p_param1 in out TBL_VARRAY_CLOB
                              ,p_param2 in out TBL_ARRAY_CLOB) IS
--
BEGIN
--
  NULL;
--
END;
--
--
PROCEDURE arraytest_blob_array(p_param1 in out TBL_VARRAY_BLOB
                              ,p_param2 in out TBL_ARRAY_BLOB) IS
--
BEGIN
--
  NULL;
--
END;
--
PROCEDURE arraytest_bfile_array(p_param1 in out TBL_VARRAY_bfile
                              ,p_param2 in out TBL_ARRAY_bfile) IS
--
BEGIN
--
  NULL;
--
END;
--
PROCEDURE arraytest_varchar2_array(p_param1 in out TBL_VARRAY_varchar2
                                  ,p_param2 in out TBL_ARRAY_varchar2) IS
--
BEGIN
--
  NULL;
--
END;
--
PROCEDURE arraytest_timestamp_array(p_param1 in out TBL_VARRAY_timestamp
                                   ,p_param2 in out TBL_ARRAY_timestamp) IS
--
BEGIN
--
  NULL;
--
END;
--
PROCEDURE arraytest_timestamptz_array(p_param1 in out TBL_VARRAY_timestamptz
                                     ,p_param2 in out TBL_ARRAY_timestamptz) IS
--
BEGIN
--
  NULL;
--
END;
--
PROCEDURE arraytest_timestampltz_array(p_param1 in out TBL_VARRAY_timestampltz
                                      ,p_param2 in out TBL_ARRAY_timestampltz) IS
--
BEGIN
--
  NULL;
--
END;
--
PROCEDURE arraytest_ids_array(p_param1 in out TBL_VARRAY_ids
                             ,p_param2 in out TBL_ARRAY_ids) IS
--
BEGIN
--
  NULL;
--
END;
--
PROCEDURE arraytest_iym_array(p_param1 in out TBL_VARRAY_iym
                             ,p_param2 in out TBL_ARRAY_iym) IS
--
BEGIN
--
  NULL;
--
END;
--
PROCEDURE arraytest_date_array(p_param1 in out TBL_VARRAY_date
                                   ,p_param2 in out TBL_ARRAY_date) IS
--
BEGIN
--
  p_param1(1) := null;
--
END;
--
PROCEDURE arraytest_raw_array(p_param1 in out TBL_VARRAY_raw
                                   ,p_param2 in out TBL_ARRAY_raw) IS
--
BEGIN
--
  NULL;
--
END;
--
PROCEDURE arraytest2(p_param1 in out TBL_VARRAY_NUMBER
                    ,p_param2 in out TBL_ARRAY_NUMBER) IS
--
BEGIN
--
  NULL;
--
END;
--
PROCEDURE arraytest3(p_param1 in out TBL_VARRAY_COMMANDS_TYPE
                    ,p_param2 in out TBL_ARRAY_COMMANDS_TYPE) IS
--
BEGIN
--
  IF p_param1.LAST > 0 THEN
--
  FOR i IN p_param1.FIRST .. p_param1.LAST LOOP
--
    p_param1(i).exe_file_name := 'foo.txt';
--
  END LOOP;
--
  END IF;
--
END;
--
PROCEDURE arraytest4 
(p_param1  in     TBL_ARRAY_COMMANDS_TYPE
,p_param2  in     TBL_ARRAY_COMMANDS_TYPE
,p_param3  in     TBL_VARRAY_COMMANDS_TYPE
,p_param4  in     TBL_VARRAY_COMMANDS_TYPE
,p_param5  in     TBL_ARRAY_NUMBER
,p_param6  in     TBL_VARRAY_NUMBER
,p_param7  in     TBL_ARRAY_COMMANDS_TYPE_OA
,p_param8  in     TBL_VARRAY_COMMANDS_TYPE_OA
,p_param9  in     TBL_ARRAY_COMMANDS_TYPE_OB
,p_param10 in     TBL_VARRAY_COMMANDS_TYPE_OB
,p_param11 in     TBL_ARRAY_COMMANDS_ROWTYPE_OA
,p_param12 in     TBL_VARRAY_COMMANDS_ROWTYPE_OA
,p_param13 in     TBL_ARRAY_NUMBER_OA
,p_param14 in     TBL_VARRAY_NUMBER_OA
,p_param15 in     TBL_ARRAY_NUMBERPCT_OA
,p_param16 in     oracle_arrays_extra.TBL_VARRAY_NUMBERPCT_OAX
,p_param17  in    oracle_arrays_extra.TBL_ARRAY_COMMANDS_TYPE_OAX
,p_param18  in    oracle_arrays_extra.TBL_VARRAY_COMMANDS_TYPE_OAX
,p_param19  in    oracle_arrays_extra.TBL_ARRAY_COMMANDS_TYPE_OBX
,p_param20 in     oracle_arrays_extra.TBL_VARRAY_COMMANDS_TYPE_OBX
,p_param21 in     oracle_arrays_extra.TBL_ARRAY_COMMANDS_ROWTYPE_OAX
,p_param22 in     oracle_arrays_extra.TBL_VARRAY_CMMANDS_ROWTYPE_OAX
,p_param23 in     oracle_arrays_extra.TBL_ARRAY_NUMBER_OAX
,p_param24 in     oracle_arrays_extra.TBL_VARRAY_NUMBER_OAX
,p_param25 in     oracle_arrays_extra.TBL_ARRAY_NUMBERPCT_OAX
,p_param26 in     oracle_arrays_extra.TBL_VARRAY_NUMBERPCT_OAX
) IS
--
BEGIN
--
  NULL;
--
END;
--
PROCEDURE arraytest5 (p_param1 in out TBL_VARRAY_COMMANDS_TYPE_OA) IS
--
BEGIN
--
  NULL;
--
END;
--
PROCEDURE arraytest6 (p_param1 in out TBL_VARRAY_SUSER_CMDS_TYPE
                     ,p_param2 in out TBL_ARRAY_SUSER_CMDS_TYPE
                     ,p_param3 in out synuser.TBL_ARRAY_COMMANDS_TYPE
                     ,p_param4 in out synuser.TBL_VARRAY_COMMANDS_TYPE) IS
--
BEGIN
--
  NULL;
--
END;
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
end;
.
/

show errors

set pages 1000

create or replace package oracle_arraysv8 as
--
TYPE TYPE_array_COMMANDS_oa IS RECORD
(COMMAND_NAME VARCHAR2(100)
,OS_NAME VARCHAR2(512)
,JAVA_CLASS_FILE_NAME VARCHAR2(512)
,BUILTIN_Y_OR_N VARCHAR2(1)
,required_number      number null
,obligatary_date      date   NULL
,EXE_FILE_NAME VARCHAR2(512)
,COMMAND_DESCRIPTION VARCHAR2(512)
);
--
TYPE_ARRAY_COMMANDS_RT array_commands%ROWTYPE;
--
TYPE TBL_ARRAY_COMMANDS_TYPE_OA  IS TABLE OF TYPE_array_COMMANDS_oa;
TYPE TBL_VARRAY_COMMANDS_TYPE_OA  IS VARRAY(100) OF TYPE_array_COMMANDS_oa;
--
TYPE TBL_ARRAY_COMMANDS_TYPE_OB  IS TABLE OF TYPE_array_COMMANDS;
TYPE TBL_VARRAY_COMMANDS_TYPE_OB  IS VARRAY(100) OF TYPE_array_COMMANDS;
--
TYPE TBL_ARRAY_COMMANDS_ROWTYPE_OA  IS TABLE OF array_COMMANDS%ROWTYPE;
TYPE TBL_VARRAY_COMMANDS_ROWTYPE_OA  IS VARRAY(100) OF array_COMMANDS%ROWTYPE;
--
TYPE TBL_ARRAY_NUMBER_OA  IS TABLE OF NUMBER;
TYPE TBL_VARRAY_NUMBER_OA IS VARRAY(100) OF NUMBER;
--
TYPE TBL_VARRAY_NUMBERPCT_OA IS VARRAY(100) OF array_COMMANDS.required_number%TYPE;
TYPE TBL_ARRAY_NUMBERPCT_OA IS TABLE OF array_COMMANDS.required_number%TYPE;
--
PROCEDURE arraytest_varchar2_array(p_param1 in out TBL_VARRAY_varchar2
                                  ,p_param2 in out TBL_ARRAY_varchar2); 
--
PROCEDURE arraytest_date_array(p_param1 in out TBL_VARRAY_date
                                   ,p_param2 in out TBL_ARRAY_date); 
--
PROCEDURE arraytest_raw_array(p_param1 in out TBL_VARRAY_raw
                                   ,p_param2 in out TBL_ARRAY_raw); 
--
PROCEDURE arraytest3(p_param1 in out TBL_VARRAY_COMMANDS_TYPE
                    ,p_param2 in out TBL_ARRAY_COMMANDS_TYPE); 
--
PROCEDURE arraytest2(p_param1 in out TBL_VARRAY_NUMBER
                    ,p_param2 in out TBL_ARRAY_NUMBER); 
--
PROCEDURE arraytest4 
--
-- has type_owner, type_name. type_subname is null.
-- type name is a type name
--
-- select c.type_name, c.elem_type_name, c.coll_type, c.upper_bound
--      , a.attr_name
-- from user_coll_types c
--    , user_type_attrs a
-- where c.elem_type_name = a.type_name
-- and   c.type_name = 'TBL_VARRAY_COMMANDS_USR'
-- /
--
(p_param1  in     TBL_ARRAY_COMMANDS_TYPE
,p_param2  in     TBL_ARRAY_COMMANDS_TYPE
,p_param3  in     TBL_VARRAY_COMMANDS_TYPE
,p_param4  in     TBL_VARRAY_COMMANDS_TYPE
--
-- select 'a_value' column_name, c.elem_type_name data_type
-- if c.elem_type_name is not a record.
--
,p_param5  in     TBL_ARRAY_NUMBER
,p_param6  in     TBL_VARRAY_NUMBER
--
-- has type_owner, type_name. type_subname is type name.
-- type name is a package name
--
--
,p_param7  in     TBL_ARRAY_COMMANDS_TYPE_OA
,p_param8  in     TBL_VARRAY_COMMANDS_TYPE_OA
,p_param9  in     TBL_ARRAY_COMMANDS_TYPE_OB
,p_param10 in     TBL_VARRAY_COMMANDS_TYPE_OB
,p_param11 in     TBL_ARRAY_COMMANDS_ROWTYPE_OA
,p_param12 in     TBL_VARRAY_COMMANDS_ROWTYPE_OA
,p_param13 in     TBL_ARRAY_NUMBER_OA
,p_param14 in     TBL_VARRAY_NUMBER_OA
,p_param15 in     TBL_ARRAY_NUMBERPCT_OA
,p_param16 in     oracle_arrays_extra.TBL_VARRAY_NUMBERPCT_OAX
,p_param17  in    oracle_arrays_extra.TBL_ARRAY_COMMANDS_TYPE_OAX
,p_param18  in    oracle_arrays_extra.TBL_VARRAY_COMMANDS_TYPE_OAX
,p_param19  in    oracle_arrays_extra.TBL_ARRAY_COMMANDS_TYPE_OBX
,p_param20 in     oracle_arrays_extra.TBL_VARRAY_COMMANDS_TYPE_OBX
,p_param21 in     oracle_arrays_extra.TBL_ARRAY_COMMANDS_ROWTYPE_OAX
,p_param22 in     oracle_arrays_extra.TBL_VARRAY_CMMANDS_ROWTYPE_OAX
,p_param23 in     oracle_arrays_extra.TBL_ARRAY_NUMBER_OAX
,p_param24 in     oracle_arrays_extra.TBL_VARRAY_NUMBER_OAX
,p_param25 in     oracle_arrays_extra.TBL_ARRAY_NUMBERPCT_OAX
,p_param26 in     oracle_arrays_extra.TBL_VARRAY_NUMBERPCT_OAX
);
--
PROCEDURE arraytest5 (p_param1 in out TBL_VARRAY_COMMANDS_TYPE_OA);
--
PROCEDURE arraytest6 (p_param1 in out TBL_VARRAY_SUSER_CMDS_TYPE
                     ,p_param2 in out TBL_ARRAY_SUSER_CMDS_TYPE
                     ,p_param3 in out synuser.TBL_ARRAY_COMMANDS_TYPE
                     ,p_param4 in out synuser.TBL_VARRAY_COMMANDS_TYPE);
--
END;
.
/

show errors

create or replace package body oracle_arraysv8 as
--
PROCEDURE arraytest_varchar2_array(p_param1 in out TBL_VARRAY_varchar2
                                  ,p_param2 in out TBL_ARRAY_varchar2) IS
--
BEGIN
--
  NULL;
--
END;
--
PROCEDURE arraytest_date_array(p_param1 in out TBL_VARRAY_date
                                   ,p_param2 in out TBL_ARRAY_date) IS
--
BEGIN
--
  p_param1(1) := null;
--
END;
--
PROCEDURE arraytest_raw_array(p_param1 in out TBL_VARRAY_raw
                                   ,p_param2 in out TBL_ARRAY_raw) IS
--
BEGIN
--
  NULL;
--
END;
--
PROCEDURE arraytest2(p_param1 in out TBL_VARRAY_NUMBER
                    ,p_param2 in out TBL_ARRAY_NUMBER) IS
--
BEGIN
--
  NULL;
--
END;
--
PROCEDURE arraytest3(p_param1 in out TBL_VARRAY_COMMANDS_TYPE
                    ,p_param2 in out TBL_ARRAY_COMMANDS_TYPE) IS
--
BEGIN
--
  IF p_param1.LAST > 0 THEN
--
  FOR i IN p_param1.FIRST .. p_param1.LAST LOOP
--
    p_param1(i).exe_file_name := 'foo.txt';
--
  END LOOP;
--
  END IF;
--
END;
--
PROCEDURE arraytest4 
(p_param1  in     TBL_ARRAY_COMMANDS_TYPE
,p_param2  in     TBL_ARRAY_COMMANDS_TYPE
,p_param3  in     TBL_VARRAY_COMMANDS_TYPE
,p_param4  in     TBL_VARRAY_COMMANDS_TYPE
,p_param5  in     TBL_ARRAY_NUMBER
,p_param6  in     TBL_VARRAY_NUMBER
,p_param7  in     TBL_ARRAY_COMMANDS_TYPE_OA
,p_param8  in     TBL_VARRAY_COMMANDS_TYPE_OA
,p_param9  in     TBL_ARRAY_COMMANDS_TYPE_OB
,p_param10 in     TBL_VARRAY_COMMANDS_TYPE_OB
,p_param11 in     TBL_ARRAY_COMMANDS_ROWTYPE_OA
,p_param12 in     TBL_VARRAY_COMMANDS_ROWTYPE_OA
,p_param13 in     TBL_ARRAY_NUMBER_OA
,p_param14 in     TBL_VARRAY_NUMBER_OA
,p_param15 in     TBL_ARRAY_NUMBERPCT_OA
,p_param16 in     oracle_arrays_extra.TBL_VARRAY_NUMBERPCT_OAX
,p_param17  in    oracle_arrays_extra.TBL_ARRAY_COMMANDS_TYPE_OAX
,p_param18  in    oracle_arrays_extra.TBL_VARRAY_COMMANDS_TYPE_OAX
,p_param19  in    oracle_arrays_extra.TBL_ARRAY_COMMANDS_TYPE_OBX
,p_param20 in     oracle_arrays_extra.TBL_VARRAY_COMMANDS_TYPE_OBX
,p_param21 in     oracle_arrays_extra.TBL_ARRAY_COMMANDS_ROWTYPE_OAX
,p_param22 in     oracle_arrays_extra.TBL_VARRAY_CMMANDS_ROWTYPE_OAX
,p_param23 in     oracle_arrays_extra.TBL_ARRAY_NUMBER_OAX
,p_param24 in     oracle_arrays_extra.TBL_VARRAY_NUMBER_OAX
,p_param25 in     oracle_arrays_extra.TBL_ARRAY_NUMBERPCT_OAX
,p_param26 in     oracle_arrays_extra.TBL_VARRAY_NUMBERPCT_OAX
) IS
--
BEGIN
--
  NULL;
--
END;
--
PROCEDURE arraytest5 (p_param1 in out TBL_VARRAY_COMMANDS_TYPE_OA) IS
--
BEGIN
--
  NULL;
--
END;
--
PROCEDURE arraytest6 (p_param1 in out TBL_VARRAY_SUSER_CMDS_TYPE
                     ,p_param2 in out TBL_ARRAY_SUSER_CMDS_TYPE
                     ,p_param3 in out synuser.TBL_ARRAY_COMMANDS_TYPE
                     ,p_param4 in out synuser.TBL_VARRAY_COMMANDS_TYPE) IS
--
BEGIN
--
  NULL;
--
END;
--
end;
.
/

show errors

create or replace PROCEDURE arraytest6 (p_param1 in out TBL_VARRAY_SUSER_CMDS_TYPE
                     ,p_param2 in out TBL_ARRAY_SUSER_CMDS_TYPE
                     ,p_param3 in out synuser.TBL_ARRAY_COMMANDS_TYPE
                     ,p_param4 in out synuser.TBL_VARRAY_COMMANDS_TYPE) AS
--
BEGIN
--
  NULL;
--
END;
.
/

create or replace PROCEDURE arraytest7 (p_param1 in out TBL_VARRAY_lobs
                     ,p_param2 in out TBL_ARRAY_lobs) AS
--
BEGIN
--
  NULL;
--
END;
--
.
/

show errors
set lines 132


exit

