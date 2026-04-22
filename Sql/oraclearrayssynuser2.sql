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


grant all on array_commands to public;

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

grant all on type_array_commands to public;


CREATE OR REPLACE TYPE TBL_ARRAY_COMMANDS_TYPE  AS TABLE OF TYPE_array_COMMANDS;
.
/
show errors

grant all on TBL_ARRAY_COMMANDS_TYPE to public;

CREATE OR REPLACE TYPE TBL_VARRAY_COMMANDS_TYPE  AS VARRAY(100) OF TYPE_array_COMMANDS;
.
/
show errors


grant all on TBL_VARRAY_COMMANDS_TYPE to public;

exit

