
create or replace package dbhell.refcursor_test as
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

create or replace package body dbhell.refcursor_test
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




