
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

CREATE OR REPLACE TYPE TBL_array_COMMANDS_usr  AS TABLE OF TYPE_array_COMMANDS;
.
/
show errors

CREATE OR REPLACE TYPE TBL_varray_COMMANDS_usr AS VARRAY(100) OF TYPE_array_COMMANDS;
.
/
show errors


REM create synonym syn_TBL_varray_COMMANDS_usr for TBL_varray_COMMANDS_usr;
REM create public synonym psyn_TBL_varray_COMMANDS_usr for TBL_varray_COMMANDS_usr;

grant all on TBL_varray_COMMANDS_usr to public; 

create or replace package oracle_arrays as
--
TYPE TBL_array_COMMANDS  IS TABLE OF TYPE_array_COMMANDS;
TYPE TBL_varray_COMMANDS  IS VARRAY(100) OF TYPE_array_COMMANDS;
--TYPE TBL_aarray_COMMANDS  IS TABLE OF TYPE_array_COMMANDS INDEX BY BINARY_INTEGER;
--
TYPE TBL_array_COMMANDS_rowtype  IS TABLE OF array_COMMANDS%ROWTYPE;
TYPE TBL_varray_COMMANDS_rowtype  IS VARRAY(100) OF array_COMMANDS%ROWTYPE;
TYPE TBL_aarray_COMMANDS_rowtype  IS TABLE OF array_COMMANDS%ROWTYPE;
--
TYPE TBL_array_numbert  IS TABLE OF array_COMMANDS.required_number%TYPE;
TYPE TBL_array_number  IS TABLE OF number(10,2);
TYPE TBL_varray_number IS VARRAY(100) OF number(10,2);
--TYPE TBL_aarray_number IS TABLE OF number(10,2) INDEX BY BINARY_INTEGER;
--
PROCEDURE arraytest1 
(p_param1  in     TBL_array_COMMANDS
,p_param2  in out TBL_array_COMMANDS
,p_param3     out TBL_array_COMMANDS
);
--
PROCEDURE arraytest2
(p_param1  in    TBL_array_COMMANDS
,p_param2  in    TBL_varray_COMMANDS
--,p_param3  in    TBL_aarray_COMMANDS
,p_param4  in    TBL_array_COMMANDS_rowtype
,p_param5  in    TBL_varray_COMMANDS_rowtype
,p_param6  in    TBL_aarray_COMMANDS_rowtype
,p_param7  in    TBL_array_numbert
,p_param8  in    TBL_array_number
,p_param9  in    TBL_varray_number
--,p_param10  in    TBL_aarray_number
,p_param11 in    TBL_array_COMMANDS_usr
,p_param12 in    TBL_varray_COMMANDS_usr);
--
PROCEDURE arraytest3 
(p_param1  in out TBL_array_COMMANDS
,p_param2  in out TYPE_array_COMMANDS);
--
PROCEDURE arraytest4 
(p_param1  in     TBL_array_COMMANDS
,p_param2  in     TYPE_array_COMMANDS);
--
END;
.
/

show errors

create or replace package body oracle_arrays as
--
PROCEDURE arraytest1
(p_param1  in     TBL_array_COMMANDS
,p_param2  in out TBL_array_COMMANDS
,p_param3     out TBL_array_COMMANDS
) IS
--
BEGIN
--
  p_param3 := p_param1;
--
END;
--
PROCEDURE arraytest2
(p_param1  in    TBL_array_COMMANDS
,p_param2  in    TBL_varray_COMMANDS
--,p_param3  in    TBL_aarray_COMMANDS
,p_param4  in    TBL_array_COMMANDS_rowtype
,p_param5  in    TBL_varray_COMMANDS_rowtype
,p_param6  in    TBL_aarray_COMMANDS_rowtype
,p_param7  in    TBL_array_numbert
,p_param8  in    TBL_array_number
,p_param9  in    TBL_varray_number
--,p_param10  in    TBL_aarray_number
,p_param11 in    TBL_array_COMMANDS_usr
,p_param12 in    TBL_varray_COMMANDS_usr) is
--
BEGIN
--
  NULL;
--
END;
--
PROCEDURE arraytest3 
(p_param1  in out TBL_array_COMMANDS
,p_param2  in out TYPE_array_COMMANDS) IS
--
BEGIN
--
  NULL;
--
END;
--
PROCEDURE arraytest4 
(p_param1  in     TBL_array_commands
,p_param2  in     TYPE_array_COMMANDS) IS
--
--
BEGIN
--
  NULL;
--
END;
--
--
end;
.
/

show errors

