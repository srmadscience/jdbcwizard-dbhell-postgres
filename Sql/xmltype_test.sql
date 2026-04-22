create or replace
TYPE TBL_ARRAY_XMLTYPE  AS TABLE OF XMLTYPE;
.
/


create or replace
TYPE TBL_VARRAY_XMLTYPE  AS VARRAY(100) OF XMLTYPE;
.
/


drop type TBL_ARRAY_XMLTYPE_OBJ;

create or replace
TYPE TYPE_array_xlobs AS OBJECT
(lob_NAME VARCHAR2(100)
,an_xml   xmltype
,another_xml   xmltype
,random_clob clob
);
.
/


create or replace
TYPE TBL_ARRAY_XMLTYPE_OBJ  AS TABLE OF TYPE_array_xlobs;
.
/

drop table xml_test purge;

create table xml_test (id number, xmlcol xmltype) tablespace dbhell_lob;

alter table xml_test  add (constraint xml_test_pk primary key (id));
 
alter table ALL_NORMAL_DATATYPES add
(an_xml_column xmltype);

create or replace
PACKAGE        DATATYPE_TEST_10G AS
 --
 --
 TYPE TYPE_ARRAY_COMMANDS_OA IS RECORD
 (COMMAND_NAME VARCHAR2(100)
 ,OS_NAME VARCHAR2(512)
 ,JAVA_CLASS_FILE_NAME VARCHAR2(512)
 ,BUILTIN_Y_OR_N VARCHAR2(1)
 ,REQUIRED_NUMBER      NUMBER NULL
 ,OBLIGATARY_DATE      DATE   NULL
 ,EXE_FILE_NAME VARCHAR2(512)
 ,COMMAND_DESCRIPTION XMLTYPE
 );
 --
 TYPE_XML_TEST_RT XML_TEST%ROWTYPE;
 --
 TYPE TBL_ARRAY_COMMANDS_TYPE_OA  IS TABLE OF TYPE_ARRAY_COMMANDS_OA;
 TYPE TBL_VARRAY_COMMANDS_TYPE_OA  IS VARRAY(100) OF TYPE_ARRAY_COMMANDS_OA;
 --
 FUNCTION  XMLTYPE_FUNC(IN_PARAM XMLTYPE) RETURN XMLTYPE;
 --
 PROCEDURE XMLTYPE_PROC(IN_PARAM IN XMLTYPE
 ,OUT_PARAM OUT XMLTYPE
 ,IN_OUT_PARAM IN OUT XMLTYPE);
 --
 PROCEDURE XMLTYPE_RT_PROC(IN_PARAM IN ALL_NORMAL_DATATYPES%ROWTYPE
 ,OUT_PARAM OUT ALL_NORMAL_DATATYPES%ROWTYPE
 ,IN_OUT_PARAM IN OUT ALL_NORMAL_DATATYPES%ROWTYPE);
 --
 PROCEDURE ARRAYTEST_XMLTYPE_ARRAY_OBJ(P_PARAM1 IN OUT TBL_ARRAY_XMLTYPE
 ,P_PARAM2 IN OUT TBL_VARRAY_XMLTYPE);
 --
 PROCEDURE ARRAYTEST_XMLTYPE_ARRAY_OBJECT(P_PARAM1 IN OUT TBL_ARRAY_XMLTYPE_OBJ
 ,P_PARAM2 IN OUT TBL_ARRAY_XMLTYPE_OBJ);
 --
 PROCEDURE ARRAYTEST_XMLTYPE_ARRAY_PCK(P_PARAM1 IN OUT TBL_ARRAY_COMMANDS_TYPE_OA
 ,P_PARAM2 IN OUT TBL_VARRAY_COMMANDS_TYPE_OA);
 --
 PROCEDURE ARRAYTEST_XMLTYPE_ARRAY_REC(P_PARAM1 IN OUT TYPE_ARRAY_COMMANDS_OA
 ,P_PARAM2 IN OUT XML_TEST%ROWTYPE);
 --
 END;
.
/

show errors

l


create or replace
package body        datatype_test_10g
as
function  xmltype_func(in_param xmltype) return xmltype is
--
foo xmltype := null;
--
BEGIN
--
  INSERT into xml_test
   values
  (message_seq.nextval, in_param);
--
  delete xml_test where  id < (select max(id) from xml_test);
--
  commit;
--
  select xmlcol
  into  foo
  from xml_test
  where rownum = 1;
--
  return foo;
--
END;
--
procedure xmltype_proc(in_param in xmltype
                     ,out_param out xmltype
                     ,in_out_param in out xmltype) is
--
foo xmltype;
--
--
BEGIN
--
  foo := XMLType(
              '<Warehouse whNo="100">
               <Building>Owned</Building>
               </Warehouse>');
--
  INSERT into xml_test
   values
  (message_seq.nextval, in_param);
--
  delete xml_test where  id < (select max(id) from xml_test);
--
  commit;
--
  select xmlcol
  into in_out_param
  from xml_test
  where rownum = 1;
--
-- least doesnt work!
--
  out_param := foo;
--
  in_out_param := in_param;
--
END;
--
procedure xmltype_rt_proc(in_param in all_normal_datatypes%ROWTYPE
                     ,out_param out all_normal_datatypes%ROWTYPE
                     ,in_out_param in out all_normal_datatypes%ROWTYPE) IS
--
 i xmltype;
 io xmltype;
 o xmltype;
--
begin
--
i := in_param.an_xml_column;
io := in_out_param.an_xml_column;
o := null;
--
xmltype_proc(i,o,io);
--
out_param.an_xml_column := io;
in_out_param.an_xml_column := i;
in_out_param.an_xml_column := XMLType(
              '<Warehouse whNo="100">
               <Building>Owned</Building>
               </Warehouse>');
--
END;
--
 --
 PROCEDURE ARRAYTEST_XMLTYPE_ARRAY_OBJ(P_PARAM1 IN OUT TBL_ARRAY_XMLTYPE
 ,P_PARAM2 IN OUT TBL_VARRAY_XMLTYPE) is
--
begin
-- 
  null;
end;
 --
 PROCEDURE ARRAYTEST_XMLTYPE_ARRAY_PCK(P_PARAM1 IN OUT TBL_ARRAY_COMMANDS_TYPE_OA
 ,P_PARAM2 IN OUT TBL_VARRAY_COMMANDS_TYPE_OA) is
--
begin
-- 
  null;
end;
 --
 PROCEDURE ARRAYTEST_XMLTYPE_ARRAY_REC(P_PARAM1 IN OUT TYPE_ARRAY_COMMANDS_OA
 ,P_PARAM2 IN OUT XML_TEST%ROWTYPE) is
--
begin
-- 
  null;
end;
 --
 PROCEDURE ARRAYTEST_XMLTYPE_ARRAY_OBJECT(P_PARAM1 IN OUT TBL_ARRAY_XMLTYPE_OBJ
 ,P_PARAM2 IN OUT TBL_ARRAY_XMLTYPE_OBJ) IS
--
begin
-- 
  null;
end;
 --
END;
.
/

show errors


l

REM drop package datatype_test_10g;

begin FOR cur IN (SELECT OBJECT_NAME, OBJECT_TYPE, owner FROM all_objects WHERE object_type in ('PROCEDURE','PACKAGE','PACKAGE BODY') 
and owner = user
order by decode (object_type ,'PACKAGE BODY',2,1) ) LOOP 
BEGIN
  if cur.OBJECT_TYPE = 'PACKAGE BODY' then 
    EXECUTE IMMEDIATE 'alter package "' || cur.owner || '"."' || cur.OBJECT_NAME || '" compile body'; 
  else 
    EXECUTE IMMEDIATE 'alter ' || cur.OBJECT_TYPE || ' "' || cur.owner || '"."' || cur.OBJECT_NAME || '" compile'; 
  end if; 
EXCEPTION
  WHEN OTHERS THEN NULL; 
END;
end loop; end;
.
/



exit
