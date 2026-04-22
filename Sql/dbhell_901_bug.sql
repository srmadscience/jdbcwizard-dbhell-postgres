

create or replace package dbhell.bug901 as
--
procedure bug901 (a_param number);
--
end;
.
/

show errors;

create or replace package body dbhell.bug901 as
--
procedure bug901(a_param number) is
BEGIN
--
  NULL;
--
END;
--
END;
.
/

show errors;

create or replace procedure bug901(a_param number) is
BEGIN
--
  NULL;
--
END;
.
/

show errors




