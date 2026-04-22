
create or replace package plsql_9i_dates as
--
SUBTYPE Numeral IS NUMBER(1,0);
SUBTYPE thousands IS NUMBER(8,-4);
SUBTYPE Sentinel IS BOOLEAN;
SUBTYPE Switch IS BOOLEAN;
SUBTYPE postcode IS char(2);
SUBTYPE postcode2 IS varchar(2);
--
procedure subtype1(p_numeral in numeral
                  ,p_thousands in thousands
                  ,p_sentinel in sentinel
                  ,p_switch in switch
                  ,p_postcode in postcode
                  ,p_postcode2 in postcode2
                  ,p_numeral_io in out numeral
                  ,p_thousands_io in out thousands
                  ,p_sentinel_io in out sentinel
                  ,p_switch_io in out switch
                  ,p_postcode_io in out postcode
                  ,p_postcode2_io in out postcode2
                  ,p_numeral_out out numeral
                  ,p_thousands_out out thousands
                  ,p_sentinel_out out sentinel
                  ,p_switch_out out switch
                  ,p_postcode_out out postcode
                  ,p_postcode2_out out postcode2);
--
end;
.
/

show errors;

create or replace package body plsql_9i_dates
as
--
procedure subtype1(p_numeral in numeral
                  ,p_thousands in thousands
                  ,p_sentinel in sentinel
                  ,p_switch in switch
                  ,p_postcode in postcode
		  ,p_postcode2 in postcode2
                  ,p_numeral_io in out numeral
                  ,p_thousands_io in out thousands
                  ,p_sentinel_io in out sentinel
                  ,p_switch_io in out switch
                  ,p_postcode_io in out postcode
                  ,p_postcode2_io in out postcode2
                  ,p_numeral_out out numeral
                  ,p_thousands_out out thousands
                  ,p_sentinel_out out sentinel
                  ,p_switch_out out switch
                  ,p_postcode_out out postcode
                  ,p_postcode2_out out postcode2) is
--
BEGIN
--
  p_numeral_out := p_numeral;
  p_thousands_out := p_thousands;
  p_sentinel_out := p_sentinel;
  p_switch_out := p_switch;
  p_postcode_out := p_postcode;
  p_postcode2_out := p_postcode2;
--
END;
--
end;
.
/

show errors




