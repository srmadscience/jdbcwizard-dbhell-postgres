create or replace
TYPE TBL_ARRAY_SDO_GEOMETRY  AS TABLE OF SDO_GEOMETRY;
.
/


create or replace
TYPE TBL_VARRAY_SDO_GEOMETRY  AS VARRAY(100) OF SDO_GEOMETRY;
.
/


drop type TBL_ARRAY_SDO_GEOMETRY_OBJ;

create or replace
TYPE TYPE_array_sdogeoms AS OBJECT
(lob_NAME VARCHAR2(100)
,an_sdogeom   SDO_GEOMETRY
,another_sdogeom   SDO_GEOMETRY
,random_clob clob
);
.
/


create or replace procedure 
sdo_test_1 (p_in in     sdo_geometry, 
p_inout in out     sdo_geometry, 
p_out out     sdo_geometry) as 
begin
null;
end;
.
/


create or replace
TYPE TBL_ARRAY_SDO_GEOMETRY_OBJ  AS TABLE OF TYPE_array_sdogeoms;
.
/

drop table sdogeom_test purge;

create table sdogeom_test (id number, sdogeomcol SDO_GEOMETRY) tablespace dbhell_lob;

alter table sdogeom_test  add (constraint sdogeom_test_pk primary key (id));
 
alter table ALL_NORMAL_DATATYPES add
(an_sdogeom_column SDO_GEOMETRY);


update all_normal_datatypes set an_sdogeom_column = SDO_GEOMETRY(
    2003,  -- two-dimensional polygon
    NULL,
    NULL,
    SDO_ELEM_INFO_ARRAY(1,1003,4), -- one circle
    SDO_ORDINATE_ARRAY(8,7, 10,9, 8,11)) 
  where name != 'all null';


create or replace
PACKAGE        SDOTEST_10G AS
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
 ,COMMAND_DESCRIPTION SDO_GEOMETRY
 );
 --
 TYPE_sdogeom_test_RT sdogeom_test%ROWTYPE;
 --
 TYPE TBL_ARRAY_COMMANDS_TYPE_OA  IS TABLE OF TYPE_ARRAY_COMMANDS_OA;
 TYPE TBL_VARRAY_COMMANDS_TYPE_OA  IS VARRAY(100) OF TYPE_ARRAY_COMMANDS_OA;
 --
 FUNCTION  SDO_GEOMETRY_FUNC(IN_PARAM SDO_GEOMETRY) RETURN SDO_GEOMETRY;
 --
 PROCEDURE SDO_GEOMETRY_PROC(IN_PARAM IN SDO_GEOMETRY
 ,OUT_PARAM OUT SDO_GEOMETRY
 ,IN_OUT_PARAM IN OUT SDO_GEOMETRY);
 --
 PROCEDURE SDO_GEOMETRY_RT_PROC(IN_PARAM IN ALL_NORMAL_DATATYPES%ROWTYPE
 ,OUT_PARAM OUT ALL_NORMAL_DATATYPES%ROWTYPE
 ,IN_OUT_PARAM IN OUT ALL_NORMAL_DATATYPES%ROWTYPE);
 --
 PROCEDURE ATEST_SDO_ARRAY_OBJ(P_PARAM1 IN OUT TBL_ARRAY_SDO_GEOMETRY
 ,P_PARAM2 IN OUT TBL_VARRAY_SDO_GEOMETRY);
 --
 PROCEDURE ATEST_SDO_ARRAY_OBJECT(P_PARAM1 IN OUT TBL_ARRAY_SDO_GEOMETRY_OBJ
 ,P_PARAM2 IN OUT TBL_ARRAY_SDO_GEOMETRY_OBJ);
 --
 PROCEDURE ATEST_SDO_ARRAY_PCK(P_PARAM1 IN OUT TBL_ARRAY_COMMANDS_TYPE_OA
 ,P_PARAM2 IN OUT TBL_VARRAY_COMMANDS_TYPE_OA);
 --
 PROCEDURE ATEST_SDO_ARRAY_REC(P_PARAM1 IN OUT TYPE_ARRAY_COMMANDS_OA
 ,P_PARAM2 IN OUT sdogeom_test%ROWTYPE);
 --
PROCEDURE sdo_test_2 (p_in in     sdo_geometry, 
p_inout in out     sdo_geometry, 
p_out out     sdo_geometry);
--
 END;
.
/

show errors

l


create or replace
package body        SDOTEST_10G
as
function  SDO_GEOMETRY_func(in_param SDO_GEOMETRY) return SDO_GEOMETRY is
--
foo SDO_GEOMETRY := null;
--
BEGIN
--
  INSERT into sdogeom_test
   values
  (message_seq.nextval, in_param);
--
  delete sdogeom_test where  id < (select max(id) from sdogeom_test);
--
  commit;
--
  select sdogeomcol
  into  foo
  from sdogeom_test
  where rownum = 1;
--
  return foo;
--
END;
--
procedure SDO_GEOMETRY_proc(in_param in SDO_GEOMETRY
                     ,out_param out SDO_GEOMETRY
                     ,in_out_param in out SDO_GEOMETRY) is
--
foo SDO_GEOMETRY;
--
--
BEGIN
--
--
  INSERT into sdogeom_test
  values
  (message_seq.nextval, in_param);
--
  delete sdogeom_test where  id < (select max(id) from sdogeom_test);
--
  commit;
--
  select sdogeomcol
  into foo
  from sdogeom_test
  where rownum = 1;
--
-- least doesnt work!
--
  out_param := foo;
--
  in_out_param := SDO_GEOMETRY(
    2003,  -- two-dimensional polygon
    NULL,
    NULL,
    SDO_ELEM_INFO_ARRAY(1,1003,4), -- one circle
    SDO_ORDINATE_ARRAY(8,7, 10,9, 8,11));
----
END;
--
procedure SDO_GEOMETRY_rt_proc(in_param in all_normal_datatypes%ROWTYPE
                     ,out_param out all_normal_datatypes%ROWTYPE
                     ,in_out_param in out all_normal_datatypes%ROWTYPE) IS
--
 i SDO_GEOMETRY;
 io SDO_GEOMETRY;
 o SDO_GEOMETRY;
--
begin
--
i := in_param.an_sdogeom_column;
io := in_out_param.an_sdogeom_column;
o := null;
--
SDO_GEOMETRY_proc(i,o,io);
--
out_param.an_sdogeom_column := i;
--in_out_param.an_sdogeom_column := i;
in_out_param.an_sdogeom_column := SDO_GEOMETRY(
    2003,  -- two-dimensional polygon
    NULL,
    NULL,
    SDO_ELEM_INFO_ARRAY(1,1003,4), -- one circle
    SDO_ORDINATE_ARRAY(8,7, 10,9, 8,11));
--
END;
--
 --
 PROCEDURE ATEST_SDO_ARRAY_OBJ(P_PARAM1 IN OUT TBL_ARRAY_SDO_GEOMETRY
 ,P_PARAM2 IN OUT TBL_VARRAY_SDO_GEOMETRY) is
--
begin
-- 
  null;
end;
 --
 PROCEDURE ATEST_SDO_ARRAY_PCK(P_PARAM1 IN OUT TBL_ARRAY_COMMANDS_TYPE_OA
 ,P_PARAM2 IN OUT TBL_VARRAY_COMMANDS_TYPE_OA) is
--
begin
-- 
  null;
end;
 --
 PROCEDURE ATEST_SDO_ARRAY_REC(P_PARAM1 IN OUT TYPE_ARRAY_COMMANDS_OA
 ,P_PARAM2 IN OUT sdogeom_test%ROWTYPE) is
--
begin
-- 
  null;
end;
 --
 PROCEDURE ATEST_SDO_ARRAY_OBJECT(P_PARAM1 IN OUT TBL_ARRAY_SDO_GEOMETRY_OBJ
 ,P_PARAM2 IN OUT TBL_ARRAY_SDO_GEOMETRY_OBJ) IS
--
begin
-- 
  null;
end;
 --
procedure
sdo_test_2 (p_in in     sdo_geometry,
p_inout in out     sdo_geometry,
p_out out     sdo_geometry) is
begin
null;
END;
END;
.
/

show errors


l

CREATE  or replace
PACKAGE REDLINE_TEST_PKG 
AS 

  /* TODO enter package declarations (types, exceptions, methods etc) here */ 
  PROCEDURE TEST(data IN OUT REDLINE_TEST);
  
  procedure test2(param1 in number, param2 out number, param3 out varchar2);

PROCEDURE TEST3(data IN OUT REDLINE_TEST/*, p_blob in out blob*/);
--
END REDLINE_TEST_PKG;
/

CREATE TYPE REDLINE_TEST 
AS OBJECT 
( /* TODO enter attribute and method declarations here */ 
    id number,
    text varchar2(30)
)
/

CREATE or replace PACKAGE BODY REDLINE_TEST_PKG AS

  PROCEDURE TEST(data IN OUT REDLINE_TEST) AS
  BEGIN
    /* TODO implementation required */
    data.id := 1;
    data.text := 'Hello world';
  END TEST;
  
  procedure test2(param1 in number, param2 out number, param3 out varchar2) AS
  BEGIN
    param2 := 1;
    param3 := 'Hello world';
  end test2;
PROCEDURE TEST3(data IN OUT REDLINE_TEST/*, p_blob in out blob*/) IS begin NULL; end;   

END REDLINE_TEST_PKG;
/


REM drop package SDOTEST_10G;

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
