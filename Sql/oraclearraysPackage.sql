set echo on

CREATE TABLE countries 
    ( country_id      CHAR(2) 
      CONSTRAINT  country_id_nn NOT NULL 
    , country_name    VARCHAR2(40) 
    , currency_name   VARCHAR2(25) 
    , currency_symbol VARCHAR2(3) 
    , region          VARCHAR2(15) 
    ,  CONSTRAINT     country_c_id_pk 
                     PRIMARY KEY (country_id) 
    ) 
    ORGANIZATION INDEX 
    INCLUDING   country_name 
    PCTTHRESHOLD 2 
    STORAGE 
     ( INITIAL  4K 
      NEXT  2K 
      PCTINCREASE 0 
      MINEXTENTS 1 
      MAXEXTENTS 1 ) 
   OVERFLOW 
    STORAGE 
      ( INITIAL  4K 
        NEXT  2K 
        PCTINCREASE 0 
        MINEXTENTS 1 
        MAXEXTENTS 1 ); 

insert into countries (country_id, country_name)
values
('EI','IRELAND');



/* Number test table */
CREATE TABLE number_test (name varchar2(256), the_value number(38,10));

insert into number_test values ('null',null);
insert into number_test values ('0',0);
insert into number_test values ('max_byte',127);
insert into number_test values ('max_byte+1',128);
insert into number_test values ('max_short',(256*256)-1);
insert into number_test values ('max_short+1',(256*256));

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

REM CREATE OR REPLACE TYPE TBL_ARRAY_COMMANDS_TYPE  AS TABLE OF TYPE_array_COMMANDS;
REM .
REM /
REM show errors
REM 
REM CREATE OR REPLACE TYPE TBL_VARRAY_COMMANDS_TYPE  AS VARRAY(100) OF TYPE_array_COMMANDS;
REM .
REM /
REM show errors
REM 
REM drop type type_array_lobs;
REM 
REM CREATE TYPE TYPE_array_lobs AS OBJECT
REM (lob_NAME VARCHAR2(100)
REM ,a_clob   CLOB
REM ,a_blob   BLOB
REM ,a_bfile  BFILE
REM );
REM .
REM /
REM 
REM show errors
REM 
REM CREATE OR REPLACE TYPE TBL_array_lobs  AS TABLE OF TYPE_array_lobs;
REM .
REM /
REM show errors
REM 
REM CREATE OR REPLACE TYPE TBL_Varray_lobs  AS VARRAY(100) OF TYPE_array_lobs;
REM .
REM /
REM show errors
REM 
REM REM CREATE OR REPLACE TYPE TBL_ARRAY_COMMANDS_ROWTYPE  AS TABLE OF array_COMMANDS%ROWTYPE;
REM REM .
REM REM /
REM REM show errors
REM REM 
REM REM CREATE OR REPLACE TYPE TBL_VARRAY_COMMANDS_ROWTYPE  AS VARRAY(100) OF array_COMMANDS%ROWTYPE;
REM REM .
REM REM /
REM REM show errors
REM REM 
REM 
REM CREATE OR REPLACE TYPE TBL_VARRAY_VARCHAR2 AS VARRAY(100) OF VARCHAR2(80);
REM .
REM /
REM show errors
REM 
REM CREATE OR REPLACE TYPE TBL_ARRAY_VARCHAR2  AS TABLE OF VARCHAR2(80);
REM .
REM /
REM show errors
REM 
REM CREATE OR REPLACE TYPE TBL_VARRAY_NUMBER AS VARRAY(100) OF NUMBER;
REM .
REM /
REM show errors
REM 
REM CREATE OR REPLACE TYPE TBL_ARRAY_NUMBER  AS TABLE OF NUMBER;
REM .
REM /
REM show errors
REM 
REM CREATE OR REPLACE TYPE TBL_ARRAY_DATE AS TABLE OF DATE;
REM .
REM /
REM show errors
REM 
REM CREATE OR REPLACE TYPE TBL_VARRAY_DATE AS VARRAY(100) OF DATE;
REM .
REM /
REM show errors
REM 
REM CREATE OR REPLACE TYPE TBL_VARRAY_CLOB AS VARRAY(100) OF CLOB;
REM .
REM /
REM show errors
REM 
REM CREATE OR REPLACE TYPE TBL_ARRAY_CLOB  AS TABLE OF CLOB;
REM .
REM /
REM show errors
REM 
REM CREATE OR REPLACE TYPE TBL_VARRAY_BLOB AS VARRAY(100) OF BLOB;
REM .
REM /
REM show errors
REM 
REM CREATE OR REPLACE TYPE TBL_ARRAY_BLOB  AS TABLE OF BLOB;
REM .
REM /
REM show errors
REM 
REM CREATE OR REPLACE TYPE TBL_VARRAY_BFILE AS VARRAY(100) OF BFILE;
REM .
REM /
REM show errors
REM 
REM CREATE OR REPLACE TYPE TBL_ARRAY_BFILE  AS TABLE OF BFILE;
REM .
REM /
REM show errors
REM 
REM CREATE OR REPLACE TYPE TBL_VARRAY_TIMESTAMP AS VARRAY(100) OF TIMESTAMP;
REM .
REM /
REM show errors
REM 
REM CREATE OR REPLACE TYPE TBL_ARRAY_TIMESTAMP  AS TABLE OF TIMESTAMP;
REM .
REM /
REM show errors
REM 
REM CREATE OR REPLACE TYPE TBL_VARRAY_TIMESTAMPTZ AS VARRAY(100) OF TIMESTAMP WITH TIME ZONE;
REM .
REM /
REM show errors
REM 
REM CREATE OR REPLACE TYPE TBL_ARRAY_TIMESTAMPTZ  AS TABLE OF TIMESTAMP WITH TIME ZONE;
REM .
REM /
REM show errors
REM 
REM CREATE OR REPLACE TYPE TBL_VARRAY_TIMESTAMPLTZ AS VARRAY(100) OF TIMESTAMP WITH LOCAL TIME ZONE;
REM .
REM /
REM show errors
REM 
REM CREATE OR REPLACE TYPE TBL_ARRAY_TIMESTAMPLTZ  AS TABLE OF TIMESTAMP WITH LOCAL TIME ZONE;
REM .
REM /
REM show errors
REM 
REM CREATE OR REPLACE TYPE TBL_VARRAY_RAW AS VARRAY(100) OF RAW(100);
REM .
REM /
REM show errors
REM 
REM CREATE OR REPLACE TYPE TBL_ARRAY_RAW  AS TABLE OF RAW(100);
REM .
REM /
REM show errors
REM 
REM CREATE OR REPLACE TYPE TBL_VARRAY_IYM AS VARRAY(100) OF interval year (2) to month;
REM .
REM /
REM show errors
REM 
REM CREATE OR REPLACE TYPE TBL_ARRAY_IYM  AS TABLE OF interval year (2) to month;
REM .
REM /
REM show errors
REM 
REM CREATE OR REPLACE TYPE TBL_VARRAY_IDS AS VARRAY(100) OF interval day (6) to second;
REM .
REM /
REM show errors
REM 
REM CREATE OR REPLACE TYPE TBL_ARRAY_IDS  AS TABLE OF interval day (6) to second;
REM .
REM /
REM show errors
REM 
REM REM CREATE OR REPLACE TYPE TBL_VARRAY_NUMBERPCT AS VARRAY(100) OF array_COMMANDS.required_number%TYPE;
REM REM .
REM REM /
REM REM show errors
REM 
REM REM CREATE OR REPLACE TYPE TBL_ARRAY_NUMBERPCT AS TABLE OF array_COMMANDS.required_number%TYPE;
REM REM .
REM REM /
REM REM show errors
REM 
REM 
REM CREATE OR REPLACE TYPE TBL_ARRAY_SUSER_CMDS_TYPE  AS TABLE OF GeNeRiC_TeStE.TYPE_array_COMMANDS;
REM .
REM /
REM show errors
REM 
REM CREATE OR REPLACE TYPE TBL_VARRAY_SUSER_CMDS_TYPE  AS VARRAY(100) OF GeNeRiC_TeStE.TYPE_array_COMMANDS;
REM .
REM /
REM show errors

create or replace package oracle_arrays_extra as
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
TYPE TBL_ARRAY_COMMANDS_TYPE_OAX  IS TABLE OF array_COMMANDS%ROWTYPE;
--TYPE TBL_VARRAY_COMMANDS_TYPE_OAX  IS VARRAY(100) OF TYPE_array_COMMANDS;
TYPE TBL_VARRAY_COMMANDS_TYPE_OAX  IS VARRAY(100) OF array_COMMANDS%ROWTYPE;
--
--TYPE TBL_ARRAY_COMMANDS_TYPE_OBX IS TABLE OF TYPE_array_COMMANDS;
TYPE TBL_ARRAY_COMMANDS_TYPE_OBX IS TABLE OF TYPE_array_COMMANDS_oa;
--TYPE TBL_VARRAY_COMMANDS_TYPE_OBX IS VARRAY(100) OF TYPE_array_COMMANDS;
TYPE TBL_VARRAY_COMMANDS_TYPE_OBX IS VARRAY(100) OF TYPE_array_COMMANDS_oa;
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
















/*****

TYPE TBL_ARRAY_COMMANDS_TYPE  IS TABLE OF TYPE_array_COMMANDS;
TYPE TBL_VARRAY_COMMANDS_TYPE  IS VARRAY(100) OF TYPE_array_COMMANDS;




REM TYPE_array_lobs IS OBJECT
REM (lob_NAME VARCHAR2(100)
REM ,a_clob   CLOB
REM ,a_blob   BLOB
REM ,a_bfile  BFILE
REM );
REM 
REM 
REM 
REM 
REM 
REM TYPE TBL_array_lobs  IS TABLE OF TYPE_array_lobs;
REM 
REM 
REM 
REM 
REM TYPE TBL_Varray_lobs  IS VARRAY(100) OF TYPE_array_lobs;
REM  TYPE TBL_ARRAY_COMMANDS_ROWTYPE  IS TABLE OF array_COMMANDS%ROWTYPE;
REM .
REM /
REM 
REM 
REM  TYPE TBL_VARRAY_COMMANDS_ROWTYPE  IS VARRAY(100) OF array_COMMANDS%ROWTYPE;
REM .
REM /
REM 
REM 


REM  TYPE TBL_VARRAY_NUMBERPCT IS VARRAY(100) OF array_COMMANDS.required_number%TYPE;
REM .
REM /
REM 

REM  TYPE TBL_ARRAY_NUMBERPCT IS TABLE OF array_COMMANDS.required_number%TYPE;
REM .
REM /
REM 


TYPE TBL_ARRAY_SUSER_CMDS_TYPE  IS TABLE OF GeNeRiC_TeStE.TYPE_array_COMMANDS;
TYPE TBL_VARRAY_SUSER_CMDS_TYPE  IS VARRAY(100) OF GeNeRiC_TeStE.TYPE_array_COMMANDS;


*******/






create or replace package oracle_arrays as
--
TYPE TBL_VARRAY_VARCHAR2 IS VARRAY(100) OF VARCHAR2(80);
TYPE TBL_ARRAY_VARCHAR2  IS TABLE OF VARCHAR2(80);
TYPE TBL_VARRAY_NUMBER IS VARRAY(100) OF NUMBER;
TYPE TBL_ARRAY_NUMBER  IS TABLE OF NUMBER;
TYPE TBL_ARRAY_DATE IS TABLE OF DATE;
TYPE TBL_VARRAY_DATE IS VARRAY(100) OF DATE;
TYPE TBL_VARRAY_CLOB IS VARRAY(100) OF CLOB;
TYPE TBL_ARRAY_CLOB  IS TABLE OF CLOB;
TYPE TBL_VARRAY_BLOB IS VARRAY(100) OF BLOB;
TYPE TBL_ARRAY_BLOB  IS TABLE OF BLOB;
TYPE TBL_VARRAY_BFILE IS VARRAY(100) OF BFILE;
TYPE TBL_ARRAY_BFILE  IS TABLE OF BFILE;
TYPE TBL_VARRAY_TIMESTAMP IS VARRAY(100) OF TIMESTAMP;
TYPE TBL_ARRAY_TIMESTAMP  IS TABLE OF TIMESTAMP;
TYPE TBL_VARRAY_TIMESTAMPTZ IS VARRAY(100) OF TIMESTAMP WITH TIME ZONE;
TYPE TBL_ARRAY_TIMESTAMPTZ  IS TABLE OF TIMESTAMP WITH TIME ZONE;
TYPE TBL_VARRAY_TIMESTAMPLTZ IS VARRAY(100) OF TIMESTAMP WITH LOCAL TIME ZONE;
TYPE TBL_ARRAY_TIMESTAMPLTZ  IS TABLE OF TIMESTAMP WITH LOCAL TIME ZONE;
TYPE TBL_VARRAY_RAW IS VARRAY(100) OF RAW(100);
TYPE TBL_ARRAY_RAW  IS TABLE OF RAW(100);
TYPE TBL_VARRAY_IYM IS VARRAY(100) OF interval year (2) to month;
TYPE TBL_ARRAY_IYM  IS TABLE OF interval year (2) to month;
TYPE TBL_VARRAY_IDS IS VARRAY(100) OF interval day (6) to second;
TYPE TBL_ARRAY_IDS  IS TABLE OF interval day (6) to second;
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
TYPE TBL_ARRAY_COMMANDS_TYPE_MIX  IS TABLE OF TYPE_array_COMMANDS;
TYPE TBL_VARRAY_COMMANDS_TYPE_MIX  IS VARRAY(100) OF TYPE_array_COMMANDS;
--
TYPE TBL_ARRAY_COMMANDS_TYPE_OB  IS TABLE OF TYPE_array_COMMANDS_oa;
TYPE TBL_VARRAY_COMMANDS_TYPE_OB  IS VARRAY(100) OF TYPE_array_COMMANDS_oa;
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
TYPE TYPE_array_lobs IS RECORD
(lob_NAME VARCHAR2(100)
,a_clob   CLOB
,a_blob   BLOB
,a_bfile  BFILE
);
--
TYPE TBL_array_lobs  IS TABLE OF TYPE_array_lobs;
TYPE TBL_Varray_lobs  IS VARRAY(100) OF TYPE_array_lobs;
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
PROCEDURE arraytest3andahalf(p_param1 in out TBL_VARRAY_COMMANDS_TYPE_MIX
                            ,p_param2 in out TBL_ARRAY_COMMANDS_TYPE_MIX); 
--
PROCEDURE arraytest3(p_param1 in out TBL_VARRAY_COMMANDS_TYPE_oa
                    ,p_param2 in out TBL_ARRAY_COMMANDS_TYPE_oa); 
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
(p_param1  in     TBL_ARRAY_COMMANDS_TYPE_oa
,p_param2  in     TBL_ARRAY_COMMANDS_TYPE_oa
,p_param3  in     TBL_VARRAY_COMMANDS_TYPE_oa
,p_param4  in     TBL_VARRAY_COMMANDS_TYPE_oa
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
--PROCEDURE arraytest6 (p_param1 in out TBL_VARRAY_SUSER_CMDS_TYPE
--                     ,p_param2 in out TBL_ARRAY_SUSER_CMDS_TYPE
--                     ,p_param3 in out GeNeRiC_TeStE.TBL_ARRAY_COMMANDS_TYPE
--                     ,p_param4 in out GeNeRiC_TeStE.TBL_VARRAY_COMMANDS_TYPE
--);
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
PROCEDURE arraytest3andahalf(p_param1 in out TBL_VARRAY_COMMANDS_TYPE_MIX
                            ,p_param2 in out TBL_ARRAY_COMMANDS_TYPE_MIX) IS
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
--PROCEDURE arraytest3(p_param1 in out TBL_VARRAY_COMMANDS_TYPE
--                    ,p_param2 in out TBL_ARRAY_COMMANDS_TYPE) IS
PROCEDURE arraytest3(p_param1 in out TBL_VARRAY_COMMANDS_TYPE_oa
                    ,p_param2 in out TBL_ARRAY_COMMANDS_TYPE_oa) IS
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
--(p_param1  in     TBL_ARRAY_COMMANDS_TYPE
--,p_param2  in     TBL_ARRAY_COMMANDS_TYPE
--,p_param3  in     TBL_VARRAY_COMMANDS_TYPE
--,p_param4  in     TBL_VARRAY_COMMANDS_TYPE
(p_param1  in     TBL_ARRAY_COMMANDS_TYPE_oa
,p_param2  in     TBL_ARRAY_COMMANDS_TYPE_oa
,p_param3  in     TBL_VARRAY_COMMANDS_TYPE_oa
,p_param4  in     TBL_VARRAY_COMMANDS_TYPE_oa
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
--PROCEDURE arraytest6 (p_param1 in out TBL_VARRAY_SUSER_CMDS_TYPE
--                     ,p_param2 in out TBL_ARRAY_SUSER_CMDS_TYPE
--                     ,p_param3 in out GeNeRiC_TeStE.TBL_ARRAY_COMMANDS_TYPE
--                     ,p_param4 in out GeNeRiC_TeStE.TBL_VARRAY_COMMANDS_TYPE) IS
--
--BEGIN
----
--  NULL;
----
--END;
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
TYPE TBL_VARRAY_VARCHAR2 IS VARRAY(100) OF VARCHAR2(80);
TYPE TBL_ARRAY_VARCHAR2  IS TABLE OF VARCHAR2(80);
TYPE TBL_VARRAY_NUMBER IS VARRAY(100) OF NUMBER;
TYPE TBL_ARRAY_NUMBER  IS TABLE OF NUMBER;
TYPE TBL_ARRAY_DATE IS TABLE OF DATE;
TYPE TBL_VARRAY_DATE IS VARRAY(100) OF DATE;
TYPE TBL_VARRAY_RAW IS VARRAY(100) OF RAW(100);
TYPE TBL_ARRAY_RAW  IS TABLE OF RAW(100);
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
--
TYPE TYPE_array_COMMANDS IS RECORD
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
TYPE TBL_ARRAY_COMMANDS_TYPE_OA  IS TABLE OF TYPE_array_COMMANDS_oa;
TYPE TBL_VARRAY_COMMANDS_TYPE_OA  IS VARRAY(100) OF TYPE_array_COMMANDS_oa;
--
TYPE TBL_ARRAY_COMMANDS_TYPE_OB  IS TABLE OF TYPE_array_COMMANDS;
TYPE TBL_VARRAY_COMMANDS_TYPE_OB  IS VARRAY(100) OF TYPE_array_COMMANDS;
--
TYPE TBL_ARRAY_COMMANDS_ROWTYPE_OA  IS TABLE OF array_COMMANDS%ROWTYPE;
TYPE TBL_VARRAY_COMMANDS_ROWTYPE_OA  IS VARRAY(100) OF array_COMMANDS%ROWTYPE;
--
-- DR
TYPE TBL_ARRAY_COMMANDS_TYPE  IS TABLE OF array_COMMANDS%ROWTYPE;
TYPE TBL_VARRAY_COMMANDS_TYPE  IS VARRAY(100) OF array_COMMANDS%ROWTYPE;
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
--PROCEDURE arraytest6 (p_param1 in out TBL_VARRAY_SUSER_CMDS_TYPE
--                     ,p_param2 in out TBL_ARRAY_SUSER_CMDS_TYPE
--                     ,p_param3 in out GeNeRiC_TeStE.TBL_ARRAY_COMMANDS_TYPE
--                     ,p_param4 in out GeNeRiC_TeStE.TBL_VARRAY_COMMANDS_TYPE);
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
--PROCEDURE arraytest6 (p_param1 in out TBL_VARRAY_SUSER_CMDS_TYPE
--                     ,p_param2 in out TBL_ARRAY_SUSER_CMDS_TYPE
--                     ,p_param3 in out GeNeRiC_TeStE.TBL_ARRAY_COMMANDS_TYPE
--                     ,p_param4 in out GeNeRiC_TeStE.TBL_VARRAY_COMMANDS_TYPE) IS
----
--BEGIN
----
--  NULL;
----
--END;
----
end;
.
/

show errors

set lines 132



/* Long and longraw tables... */
create table raw_example (NAME varchar2 (256), GIFDATA raw(200));
alter table raw_example add (constraint raw_example_pk primary key (name));
insert into raw_example values ('LESLIE2', hextoraw('6A')||hextoraw('6B')||hextoraw('6C'));
insert into raw_example values ('LESLIE3',null);

create table longraw_example (NAME varchar2 (256), GIFDATA long raw);
alter table longraw_example add (constraint longraw_example_pk primary key (name));
insert into longraw_example values ('LESLIE2', hextoraw('6A')||hextoraw('6B')||hextoraw('6C'));
insert into longraw_example values ('LESLIE3',null);

create table long_example (NAME varchar2 (256), LONGDATA long );
alter table long_example add (constraint long_example_pk primary key (name));
insert into long_example values ('LESLIE2', 'This is a long column');
insert into long_example values ('LESLIE3',NULL); 

/* blob and clob tables... */
create table clob_example (NAME varchar2 (256), CLOBDATA CLOB) ;
alter table clob_example add (constraint clob_example_pk primary key (name));
insert into clob_example values ('LESLIE2', 'This is a long column');
insert into clob_example values ('LESLIE3', null);

create table blob_example (NAME varchar2 (256), BLOBDATA BLOB) ;
alter table blob_example add (constraint blob_example_pk primary key (name));
insert into blob_example values ('LESLIE2', hextoraw('6A')||hextoraw('6B')||hextoraw('6C'));
insert into blob_example values ('LESLIE3', null);

/* BFILE table */
CREATE TABLE bfile_example (name varchar2 (256),  bfiledata bfile) ;
alter table bfile_example add (constraint bfile_example_pk primary key (name));

insert into bfile_example (name, bfiledata) values ('null bfile',null);
insert into bfile_example (name, bfiledata) values ('test_readable',bfilename('DBHELL_TESTDIR1','test_readable'));
insert into bfile_example (name, bfiledata) values ('test_unreadble_wrong_case',bfilename('testdir1','test_readable'));
insert into bfile_example (name, bfiledata) values ('test_unreadable',bfilename('DBHELL_TESTDIR1','test_unreadable'));
insert into bfile_example (name, bfiledata) values ('no such file',bfilename('DBHELL_TESTDIR1','no such file'));
insert into bfile_example (name, bfiledata) values ('invalid directory',bfilename('DBHELL_NOEXISTS','non exists'));

insert into bfile_example (name, bfiledata) values ('nterdesk.dmp',bfilename('DBHELL_TESTDIR1','nterdesk.dmp'));
insert into bfile_example (name, bfiledata) values ('nterdesk.dmp.Z',bfilename('DBHELL_TESTDIR1','nterdesk.dmp.Z'));

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



drop table clob_test;
drop table blob_test;
drop table bfile_test;
drop sequence clob_seq;
drop sequence blob_seq;
drop sequence bfile_seq;

create sequence clob_seq;
create table clob_test(seqno number, clob_column clob) ;
insert into clob_test values (0,'Hello World');

create sequence blob_seq;
create table blob_test(seqno number, blob_column blob) ;
insert into blob_test values (0,hextoraw('FF'));

create sequence bfile_seq;
create table bfile_test(seqno number, bfile_column bfile) ;

create or replace package datatype_test as
--
--function  number_func(in_param number) return number;
----
--procedure number_proc(in_param in number
--                     ,out_param out number
--                     ,in_out_param in out number);
----
--function  date_func(in_param date) return date;
----
--procedure date_proc(in_param in date
--                     ,out_param out date
--                     ,in_out_param in out date);
----
--function  binary_integer_func(in_param binary_integer) return binary_integer;
----
--procedure binary_integer_proc(in_param in binary_integer
--                     ,out_param out binary_integer
--                     ,in_out_param in out binary_integer);
----
--function  natural_func(in_param natural) return natural;
----
--procedure natural_proc(in_param in natural
--                     ,out_param out natural
--                     ,in_out_param in out natural);
----
--function  naturaln_func(in_param naturaln) return naturaln;
----
--procedure naturaln_proc(in_param in naturaln
--          --           ,out_param out naturaln 
--                     ,in_out_param in out naturaln);
----
--function  positive_func(in_param positive) return positive;
----
--procedure positive_proc(in_param in positive
--                     ,out_param out positive
--                     ,in_out_param in out positive);
----
--function  positiven_func(in_param positiven) return positiven;
----
--procedure positiven_proc(in_param in positiven
--               --       ,out_param out positiven
--                     ,in_out_param in out positiven);
----
--function  signtype_func(in_param signtype) return signtype;
----
--procedure signtype_proc(in_param in signtype
--                     ,out_param out signtype
--                     ,in_out_param in out signtype);
----
--function  dec_func(in_param dec) return dec;
----
--procedure dec_proc(in_param in dec
--                     ,out_param out dec
--                     ,in_out_param in out dec);
----
--function  decimal_func(in_param decimal) return decimal;
----
--procedure decimal_proc(in_param in decimal
--                     ,out_param out decimal
--                     ,in_out_param in out decimal);
----
--function  double_precision_func(in_param double precision) return double precision;
----
--procedure double_precision_proc(in_param in double precision
--                     ,out_param out double precision
--                     ,in_out_param in out double precision);
----
--function  float_func(in_param float) return float;
----
--procedure float_proc(in_param in float
--                     ,out_param out float
--                     ,in_out_param in out float);
----
--function  integer_func(in_param integer) return integer;
----
--procedure integer_proc(in_param in integer
--                     ,out_param out integer
--                     ,in_out_param in out integer);
----
--function  int_func(in_param int) return int;
----
--procedure int_proc(in_param in int
--                     ,out_param out int
--                     ,in_out_param in out int);
----
--function  numeric_func(in_param numeric) return numeric;
----
--procedure numeric_proc(in_param in numeric
--                     ,out_param out numeric
--                     ,in_out_param in out numeric);
----
----
--function  real_func(in_param real) return real;
----
--procedure real_proc(in_param in real
--                     ,out_param out real
--                     ,in_out_param in out real);
----
----
--function  smallint_func(in_param smallint) return smallint;
----
--procedure smallint_proc(in_param in smallint
--                     ,out_param out smallint
--                     ,in_out_param in out smallint);
----
----
--function  pls_integer_func(in_param pls_integer) return pls_integer;
----
--procedure pls_integer_proc(in_param in pls_integer
--                     ,out_param out pls_integer
--                     ,in_out_param in out pls_integer);
----
----
--function  boolean_func(in_param boolean) return boolean;
----
--procedure boolean_proc(in_param in boolean
--                     ,out_param out boolean
--                     ,in_out_param in out boolean);
----
----
----
--function  character_func(in_param character) return character;
----
--procedure character_proc(in_param in character
--                     ,out_param out character
--                     ,in_out_param in out character);
----
--function  char_func(in_param char) return char;
----
--procedure char_proc(in_param in char
--                     ,out_param out char
--                     ,in_out_param in out char);
----
--function  long_func(in_param long) return long;
----
--procedure long_proc(in_param in long
--                     ,out_param out long
--                     ,in_out_param in out long);
----
--
--function  long_raw_func(in_param long raw) return long raw;
----
--procedure long_raw_proc(in_param in long raw
--                     ,out_param out long raw
--                     ,in_out_param in out long raw);
----
--function  raw_func(in_param raw) return raw;
----
--procedure raw_proc(in_param in raw
--                     ,out_param out raw
--                     ,in_out_param in out raw);
----
--
--function  rowid_func(in_param rowid) return rowid;
----
--procedure rowid_proc(in_param in  rowid
--                     ,out_param out rowid
--                     ,in_out_param in out rowid);
----
--
--function  urowid_func(in_param urowid) return urowid;
----
--procedure urowid_proc(in_param in urowid
--                     ,out_param out urowid
--                     ,in_out_param in out urowid);
----
--
--function  string_func(in_param string) return string;
----
--procedure string_proc(in_param in string
--                     ,out_param out string
--                     ,in_out_param in out string);
----
--
--function  varchar_func(in_param varchar) return varchar;
----
--procedure varchar_proc(in_param in varchar
--                     ,out_param out varchar
--                     ,in_out_param in out varchar);
----
--function  varchar2_func(in_param varchar2) return varchar2;
----
--procedure varchar2_proc(in_param in varchar2
--                     ,out_param out varchar2
--                     ,in_out_param in out varchar2);
----
--
--function  nchar_func(in_param nchar) return nchar;
----
--procedure nchar_proc(in_param in nchar
--                     ,out_param out nchar
--                     ,in_out_param in out nchar);
----
--
--function  nvarchar2_func(in_param nvarchar2) return nvarchar2;
----
--procedure nvarchar2_proc(in_param in nvarchar2
--                     ,out_param out nvarchar2
--                     ,in_out_param in out nvarchar2);
----
--function  bfile_func(in_param varchar2) return bfile;
----
--procedure bfile_proc(in_param in bfile
--                     ,out_param out bfile
--                     ,out_seqno out number
--                     ,in_out_param in out bfile);
--
--
function  blob_func_simpleblob return blob;
--
function  blob_func_newblob return blob;
--
--function  blob_func(in_param blob) return blob;
----
--procedure blob_proc(in_param in blob
--                     ,out_param out blob
--                     ,in_out_param in out blob);
----
--procedure blob_proc_1(out_param out blob
--                     ,out_seqno out number);
----
--procedure blob_proc_2(out_param out blob
--                     ,in_seqno number);
----
--function  clob_func_simpleclob return clob;
----
--function  clob_func_getclob(in_param number) return clob;
----
--function  clob_func_newclob return clob;
----
--function  clob_func(in_param clob) return clob;
----
--procedure clob_proc(in_param in clob
--                     ,out_param out clob
--                     ,in_out_param in out clob);
----
--procedure clob_proc_1(out_param out clob
--                     ,out_seqno out number);
----
--procedure clob_proc_2(out_param out clob
--                     ,in_seqno number);
----
--function  nclob_func(in_param nclob) return nclob;
----
--procedure nclob_proc(in_param in nclob
--                     ,out_param out nclob
--                     ,in_out_param in out nclob);
----
end;
.
/

show errors;

create or replace package body datatype_test
as
function  number_func(in_param number) return number is
--
BEGIN
--
  return(in_param);
--
END;
--
procedure number_proc(in_param in number
                     ,out_param out number
                     ,in_out_param in out number) is
BEGIN
--
  out_param := in_param + in_out_param;
--
END;
--
function  date_func(in_param date) return date is
--
BEGIN
--
  return(in_param);
--
END;
--
procedure date_proc(in_param in date
                   ,out_param out date
                   ,in_out_param in out date) is
BEGIN
--
  out_param := in_out_param + 1;
--
END;
--
function  varchar2_func(in_param varchar2) return varchar2 is
--
BEGIN
--
  return(in_param);
--
END;
--
procedure varchar2_proc(in_param in varchar2
                       ,out_param out varchar2
                       ,in_out_param in out varchar2) is
BEGIN
--
  out_param := in_param ||  in_out_param;
--
END;
--
function  binary_integer_func(in_param binary_integer) return binary_integer is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure binary_integer_proc(in_param in binary_integer
                     ,out_param out binary_integer
                     ,in_out_param in out binary_integer)
is
BEGIN
--
  out_param := in_param + in_out_param;
--
END;
--
--
function  natural_func(in_param natural) return natural is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure natural_proc(in_param in natural
                     ,out_param out natural
                     ,in_out_param in out natural)
is
BEGIN
--
  out_param := in_param + in_out_param;
--
END;
--
--
function  naturaln_func(in_param naturaln) return naturaln is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure naturaln_proc(in_param in naturaln
--                     ,out_param out naturaln 
                     ,in_out_param in out naturaln)
is
BEGIN
--
  in_out_param := NVL(in_param,0) + NVL(in_out_param,0);
--
END;
--
--
function  positive_func(in_param positive) return positive is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure positive_proc(in_param in positive
                     ,out_param out positive
                     ,in_out_param in out positive)
is
BEGIN
--
  out_param := in_param + in_out_param;
--
END;
--
--
function  positiven_func(in_param positiven) return positiven is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure positiven_proc(in_param in positiven
              --       ,out_param out positiven
                     ,in_out_param in out positiven)
is
BEGIN
--
  in_out_param := in_param + in_out_param;
--
END;
--
--
function  signtype_func(in_param signtype) return signtype is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure signtype_proc(in_param in signtype
                     ,out_param out signtype
                     ,in_out_param in out signtype)
is
BEGIN
--
  out_param := in_param + in_out_param;
--
END;
--
--
function  dec_func(in_param dec) return dec is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure dec_proc(in_param in dec
                     ,out_param out dec
                     ,in_out_param in out dec)
is
BEGIN
--
  out_param := in_param + in_out_param;
--
END;
--
--
function  decimal_func(in_param decimal) return decimal is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure decimal_proc(in_param in decimal
                     ,out_param out decimal
                     ,in_out_param in out decimal)
is
BEGIN
--
  out_param := in_param + in_out_param;
--
END;
--
--
function  double_precision_func(in_param double precision) return double precision is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure double_precision_proc(in_param in double precision
                     ,out_param out double precision
                     ,in_out_param in out double precision)
is
BEGIN
--
  out_param := in_param + in_out_param;
--
END;
--
--
function  float_func(in_param float) return float is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure float_proc(in_param in float
                     ,out_param out float
                     ,in_out_param in out float)
is
BEGIN
--
  out_param := in_param + in_out_param;
--
END;
--
--
function  integer_func(in_param integer) return integer is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure integer_proc(in_param in integer
                     ,out_param out integer
                     ,in_out_param in out integer)
is
BEGIN
--
  out_param := in_param + in_out_param;
--
END;
--
--
function  int_func(in_param int) return int is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure int_proc(in_param in int
                     ,out_param out int
                     ,in_out_param in out int)
is
BEGIN
--
  out_param := in_param + in_out_param;
--
END;
--
--
function  numeric_func(in_param numeric) return numeric is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure numeric_proc(in_param in numeric
                     ,out_param out numeric
                     ,in_out_param in out numeric)
is
BEGIN
--
  out_param := in_param + in_out_param;
--
END;
--
--
--
function  real_func(in_param real) return real is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure real_proc(in_param in real
                     ,out_param out real
                     ,in_out_param in out real)
is
BEGIN
--
  out_param := in_param + in_out_param;
--
END;
--
--
--
function  smallint_func(in_param smallint) return smallint is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure smallint_proc(in_param in smallint
                     ,out_param out smallint
                     ,in_out_param in out smallint)
is
BEGIN
--
  out_param := in_param + in_out_param;
--
END;
--
--
--
function  pls_integer_func(in_param pls_integer) return pls_integer is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure pls_integer_proc(in_param in pls_integer
                     ,out_param out pls_integer
                     ,in_out_param in out pls_integer)
is
BEGIN
--
  out_param := in_param + in_out_param;
--
END;
--
--
--
function  boolean_func(in_param boolean) return boolean is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure boolean_proc(in_param in boolean
                     ,out_param out boolean
                     ,in_out_param in out boolean)
is
BEGIN
--
  out_param := in_param;
--
  if  in_out_param then
--
    out_param := false;
--
  END if;
--
END;
--
--
--
--
function  character_func(in_param character) return character is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure character_proc(in_param in character
                     ,out_param out character
                     ,in_out_param in out character) is
BEGIN
--
  out_param := greatest(in_param,in_out_param);
--
END;
--
--
function  char_func(in_param char) return char is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure char_proc(in_param in char
                     ,out_param out char
                     ,in_out_param in out char) is
BEGIN
--
  out_param := greatest(in_param,in_out_param) ;
--
END;
--
--
function  long_func(in_param long) return long is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure long_proc(in_param in long
                     ,out_param out long
                     ,in_out_param in out long) is
BEGIN
--
  out_param := in_param ||  in_out_param;
--
END;
--
--

function  long_raw_func(in_param long raw) return long raw is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure long_raw_proc(in_param in long raw
                     ,out_param out long raw
                     ,in_out_param in out long raw) is
BEGIN
--
  out_param := in_param ;
--
END;
--
--
function  raw_func(in_param raw) return raw is
--
new_raw raw_example.gifdata%TYPE;
--
BEGIN
--
  IF in_param IS NOT NULL THEN
--
    SELECT gifdata||in_param INTO new_raw
    FROM raw_example
    WHERE name = 'LESLIE2';
-- 
  ELSE
--
    new_raw := in_param;
--
  END IF;
--
RETURN new_raw ;
--
END;
--
--
procedure raw_proc(in_param in raw
                     ,out_param out raw
                     ,in_out_param in out raw) is
BEGIN
--
  out_param := in_param ||  in_out_param;
  in_out_param := in_param;
--
END;
--
--

function  rowid_func(in_param rowid) return rowid is
--
new_rowid ROWID := null;
--
BEGIN
--
--
  IF in_param IS NOT NULL THEN
--
  SELECT min(rowid) INTO new_rowid FROM number_test;
--
  END IF;
--
  RETURN new_rowid;
--
END;
--
--
procedure rowid_proc(in_param in  rowid
                     ,out_param out rowid
                     ,in_out_param in out rowid) is
--
new_rowid ROWID := null;
--
BEGIN
--
  SELECT min(rowid) INTO new_rowid FROM number_test;
--
  SELECT min(rowid) INTO new_rowid 
  FROM  number_test
  WHERE rowid = new_rowid;
--
  out_param := new_rowid;
  in_out_param := new_rowid;
--
END;
--
--

function  urowid_func(in_param urowid) return urowid is
--
new_rowid UROWID := null;
--
BEGIN
--
  IF in_param IS NOT NULL THEN
--
  SELECT min(rowid) INTO new_rowid FROM countries;
--
  END IF;
--
  RETURN new_rowid;
--
END;
--
procedure urowid_proc(in_param in urowid
                     ,out_param out urowid
                     ,in_out_param in out urowid) is
--
new_rowid UROWID := null;
--
BEGIN
--
--
  SELECT min(rowid) INTO new_rowid FROM countries;
--
  SELECT min(rowid) INTO new_rowid
  FROM  countries;
--  WHERE rowid = new_rowid;
--
  out_param := new_rowid;
  in_out_param := new_rowid;
----
END;
--
--

function  string_func(in_param string) return string is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure string_proc(in_param in string
                     ,out_param out string
                     ,in_out_param in out string) is
BEGIN
--
  out_param := in_param ||  in_out_param;
--
END;
--
--

function  varchar_func(in_param varchar) return varchar is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure varchar_proc(in_param in varchar
                     ,out_param out varchar
                     ,in_out_param in out varchar) is
BEGIN
--
  out_param := in_param ||  in_out_param;
--
END;
--
--

function  nchar_func(in_param nchar) return nchar is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure nchar_proc(in_param in nchar
                     ,out_param out nchar
                     ,in_out_param in out nchar) is
BEGIN
--
  out_param := in_param ||  in_out_param;
--
END;
--
--

function  nvarchar2_func(in_param nvarchar2) return nvarchar2 is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure nvarchar2_proc(in_param in nvarchar2
                     ,out_param out nvarchar2
                     ,in_out_param in out nvarchar2) is
BEGIN
--
  out_param := in_param ||  in_out_param;
--
END;
--
--
function  bfile_func(in_param varchar2) return bfile is
-- 
return_value bfile := null;
--
BEGIN
--
  IF in_param IS NOT NULL THEN
--
  SELECT bfiledata
  INTO return_value
  FROM bfile_example
  WHERE name = in_param;
--
  END IF;
--
  return(return_value);
--
END;
--
--
procedure bfile_proc(in_param in bfile
                     ,out_param out bfile
                     ,out_seqno out number
                     ,in_out_param in out bfile) is
--
  new_seqno number := null;
--
BEGIN
--
  SELECT bfile_seq.nextval
  INTO new_seqno
  FROM dual;
--
  INSERT INTO bfile_test
  (seqno, bfile_column)
  VALUES
  (new_seqno,in_param);
--
  out_param := in_param;
  out_seqno := new_seqno;
--
  SELECT bfile_column
  INTO   in_out_param
  FROM   bfile_test b
  WHERE b.seqno = (SELECT max(seqno) FROM bfile_test c);
--
END;
--
--
function  clob_func_getclob(in_param number) return clob IS
--
--
  new_clob clob := null;
  new_seqno number := null;
--
BEGIN
--
  select clob_column
  into new_clob
  from clob_test
  where seqno = in_param
  for update of clob_column NOWAIT;
--
  return(new_clob);
--
end;
--
--
function  clob_func_newclob return clob is
--
  new_clob clob := null;
  new_seqno number := null;
--
BEGIN
--
  select clob_seq.nextval into new_seqno from dual;
--
  insert into clob_test 
  (seqno, clob_column)
  values
  (new_seqno, empty_clob());
--
  select clob_column
  into new_clob
  from clob_test
  where seqno = new_seqno
  for update of clob_column NOWAIT;
--
  return(new_clob);
--
END;
--
--
function  clob_func_simpleclob return clob is
--
  new_clob clob := null;
  new_seqno number := null;
--
BEGIN
--
  select clob_column
  into new_clob
  from clob_test
  where seqno = 0
  for update of clob_column NOWAIT;
--
  return(new_clob);
--
END;
--
--
function  clob_func(in_param clob) return clob is
--
out_param clob;
--
BEGIN
--
  -- out_param := empty_clob();
  -- dbms_lob.copy(out_param,in_param, dbms_lob.getlength(in_param));
  out_param := in_param;
  dbms_lob.append(out_param,in_param);
  return(out_param);
--
END;
--
--
procedure clob_proc_1(out_param out clob
                     ,out_seqno out number) is
--
--
  new_clob clob := null;
  new_seqno number := null;
--
BEGIN
--
  select clob_seq.nextval into new_seqno from dual;
--
  insert into clob_test
  (seqno, clob_column)
  values
  (new_seqno, empty_clob());
--
  select clob_column, seqno
  into out_param, out_seqno
  from clob_test
  where seqno = new_seqno
  for update of clob_column NOWAIT;
--
END;
--
procedure clob_proc_2(out_param out clob
                     ,in_seqno number) is
--
BEGIN
--
  select clob_column
  into out_param
  from clob_test
  where seqno = in_seqno
  for update of clob_column NOWAIT;
--
END;
--
procedure clob_proc(in_param in clob
                     ,out_param out clob
                     ,in_out_param in out clob) is
BEGIN
--
  out_param := in_param;
--
END;
--
--
function  blob_func_newblob return blob is
--
  new_blob blob := null;
  new_seqno number := null;
--
BEGIN
--
  select blob_seq.nextval into new_seqno from dual;
--
  insert into blob_test 
  (seqno, blob_column)
  values
  (new_seqno, empty_blob());
--
  select blob_column
  into new_blob
  from blob_test
  where seqno = new_seqno
  for update of blob_column NOWAIT;
--
  return(new_blob);
--
END;
--
--
function  blob_func_simpleblob return blob is
--
  new_blob blob := null;
  new_seqno number := null;
--
BEGIN
--
  select blob_column
  into new_blob
  from blob_test
  where seqno = 0
  for update of blob_column NOWAIT;
--
  return(new_blob);
--
END;
--
--
function  blob_func(in_param blob) return blob is
--
out_param blob;
--
BEGIN
--
  -- out_param := empty_blob();
  -- dbms_lob.copy(out_param,in_param, dbms_lob.getlength(in_param));
  out_param := in_param;
  dbms_lob.append(out_param,in_param);
  return(out_param);
--
END;
--
--
procedure blob_proc_1(out_param out blob
                     ,out_seqno out number) is
--
--
  new_blob blob := null;
  new_seqno number := null;
--
BEGIN
--
  select blob_seq.nextval into new_seqno from dual;
--
  insert into blob_test
  (seqno, blob_column)
  values
  (new_seqno, empty_blob());
--
  select blob_column, seqno
  into out_param, out_seqno
  from blob_test
  where seqno = new_seqno
  for update of blob_column NOWAIT;
--
END;
--
procedure blob_proc_2(out_param out blob
                     ,in_seqno number) is
--
BEGIN
--
  select blob_column
  into out_param
  from blob_test
  where seqno = in_seqno
  for update of blob_column NOWAIT;
--
END;
--
procedure blob_proc(in_param in blob
                     ,out_param out blob
                     ,in_out_param in out blob) is
BEGIN
--
  out_param := in_param;
--
END;
--
--
function  nclob_func(in_param nclob) return nclob is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure nclob_proc(in_param in nclob
                     ,out_param out nclob
                     ,in_out_param in out nclob) is
BEGIN
--
  out_param := in_param;
--
END;
--
--
--
END;
.
/

show errors





exit

