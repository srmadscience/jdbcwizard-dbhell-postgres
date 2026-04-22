
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

create or replace package dbhell.record_test2 as
--
TYPE packageRecordType IS RECORD (flag VARCHAR2(1), msg VARCHAR2(200));
--
END;
.
/

create or replace package dbhell.record_test as
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
procedure rt1(p_binary_integer 	in binary_integer
             ,p_dec		in dec
             ,p_decimal		in decimal
             ,p_double		in double precision
             ,p_float		in float
             ,p_int		in int
             ,p_integer		in integer
             ,p_natural		in natural
             ,p_naturaln	in naturaln
             ,p_number		in number
             ,p_numeric		in numeric
             ,p_pls_integer	in pls_integer
             ,p_positive	in positive
             ,p_positiven	in positiven
             ,p_real		in real
             ,p_signtype	in signtype
             ,p_smallint	in smallint
             ,p_char		in char
             ,p_character	in character
             ,p_long		in long
             ,p_string		in string
             ,p_varchar		in varchar
             ,p_varchar2	in varchar2
             ,p_boolean		in boolean
             ,p_date 		in date
             ,p_outcursor	out GenericCurTyp);
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

end;
.
/
show errors;

create or replace package body dbhell.record_test as
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
 NULL;
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
END;
--
END;
.
/

show errors




