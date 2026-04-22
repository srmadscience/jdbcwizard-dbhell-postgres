
create or replace package evil_refcursor_test as
--
TYPE GenericCurTyp IS REF CURSOR;  -- weak
--
TYPE ora_datatypes_typ IS REF CURSOR RETURN all_normal_datatypes%ROWTYPE;  -- strong
--
TYPE airline_refcursor_type IS REF CURSOR RETURN airlines%ROWTYPE;
--
TYPE airport_refcursor_type IS REF CURSOR RETURN airports%ROWTYPE;
--
TYPE aircraft_refcursor_type IS REF CURSOR RETURN aircraft%ROWTYPE;
--
TYPE flights_refcursor_type  IS REF CURSOR RETURN flights%ROWTYPE;
--
PROCEDURE getLists(p_airline_listing  out airline_refcursor_type
                  ,p_airport_listing1 out airport_refcursor_type
                  ,p_airport_listing2 out GenericCurTyp
                  ,p_aircraft_listing out aircraft_refcursor_type);
--
function cur3 return GenericCurTyp;
--
function cur4 return ora_datatypes_typ;
--
end;
.
/

show errors;

create or replace package body evil_refcursor_test
as
--

PROCEDURE getLists(p_airline_listing out airline_refcursor_type
                  ,p_airport_listing1 out airport_refcursor_type
                  ,p_airport_listing2 out GenericCurTyp
                  ,p_aircraft_listing out aircraft_refcursor_type) IS
--
BEGIN
--
  OPEN p_airline_listing
  FOR select   a.*
      from     airlines a
      order by airline_name;
--
  OPEN p_airport_listing1
  FOR select   a.*
      from     airports a
      order by airport_code;
--
  OPEN p_airport_listing2
  FOR select   a.*
      from     airports a
      order by airport_code;
--
  OPEN p_aircraft_listing
  FOR select   a.*
      from     aircraft a
      order by aircraft_type;
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
function cur4 return ora_datatypes_typ is
--
  tempCur ora_datatypes_typ;
--
begin
--
  open tempCur for SELECT * FROM all_normal_datatypes;
--
  return tempCur;
--
end;
--
end;
.
/

show errors




