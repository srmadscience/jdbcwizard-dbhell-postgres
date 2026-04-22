
create sequence test_seq start with 1000;

create or replace procedure orindabuild_example1(a_param in     number
                                                ,b_param in out number
                                                ,c_param    out varchar2
                                                ,date_a  in     date
                                                ,date_b  in out date) as
BEGIN
--
  b_param := a_param + b_param;
  c_param := to_char(b_param);
  date_b := least(date_a, date_b);
--
END;
.
/

show errors

create or replace package orindabuild_example2 as
--
TYPE GenericCurTyp IS REF CURSOR;  
--
procedure cur1(out_param out GenericCurTyp);
--
end;
.
/

show errors;

create or replace package body orindabuild_example2
as
--
procedure cur1(out_param out GenericCurTyp) is
--
BEGIN
--
  open out_param for 
  select * 
  from all_tables
  where owner in ('SYS','SYSTEM','SCOTT');
--
END;
--
end;
.
/

show errors





