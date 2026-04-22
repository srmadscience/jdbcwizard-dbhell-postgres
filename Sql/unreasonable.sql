
create or replace package dbhell.unreasonable_test as
--
procedure odd_param_type (in_param all_normal_datatypes.name%TYPE);
--
procedure odd_param_rowtype (in_param all_normal_datatypes%ROWTYPE);
--
TYPE DeptRec IS RECORD ( 
      dept_id   all_normal_datatypes.name%TYPE,
      dept_name VARCHAR2(14),
      dept_loc  VARCHAR2(13));
--
procedure odd_param_record (in_param DeptRec);
--
end;
.
/

show errors;

create or replace package body dbhell.unreasonable_test
as
--
procedure odd_param_type (in_param all_normal_datatypes.name%TYPE) is
--
--
begin
--
  null;
--
end;
--
procedure odd_param_rowtype (in_param all_normal_datatypes%ROWTYPE) is
--
begin
--
  null;
--
end;
--
procedure odd_param_record (in_param DeptRec) is
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




