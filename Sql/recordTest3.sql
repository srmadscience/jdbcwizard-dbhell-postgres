
drop table all8i_datatypes;

create table all8i_datatypes
(name varchar2(4000)
,name_char char(2000)
,seqno number
,seqno_big number(38,0)
,seqno_small number(2,-28)
, seqno_float float
,date_generic date
,a_raw raw(100)
,a_long_raw long raw
/*,a_long long
,a_clob clob
,a_blob blob
,a_bfile bfile */
);


drop type rectest2_8itype;

CREATE TYPE rectest2_8itype AS OBJECT 
(name varchar2(4000)
,name_char char(2000)
,seqno number
,seqno_big number(38,0)
,seqno_small number(2,-28)
, seqno_float float
,date_generic date
,a_raw raw(100)
/*,a_clob clob
,a_blob blob
,a_bfile bfile*/
);
.
/

show errors

drop table all_9i_datatypes;

create table all_9i_datatypes
(name varchar2(4000)
,name_char char(2000)
,seqno number
,seqno_big number(38,0)
,seqno_small number(2,-28)
,seqno_float float
,a_raw raw(100)
/*,a_long_raw long raw*/
,date_generic date
,timestamp_generic timestamp
/* ,timestamp_tz timestamp with time zone
,timestamp_local_tz timestamp with local time zone
,date_year_2_month interval year (2) to month
,date_day_2_second interval day (6) to second */
,a_rowid rowid
/*,a_u_rowid urowid
,a_clob clob
,a_blob blob
,a_bfile bfile*/);

drop type rectest2_9itype;

create type rectest2_9itype as OBJECT
(name varchar2(4000)
,name_char char(2000)
,seqno number
,seqno_big number(38,0)
,seqno_small number(2,-28)
,seqno_float float
,a_raw raw(100)
/*,a_long_raw long raw*/
,date_generic date
,timestamp_generic timestamp
/* ,timestamp_tz timestamp with time zone
,timestamp_local_tz timestamp with local time zone
,date_year_2_month interval year (2) to month
,date_day_2_second interval day (6) to second */
/*,a_clob clob
,a_blob blob
,a_bfile bfile*/);
.
/

show errors

create or replace package dbhell.record_test2b_8i as
--
TYPE recordtype8i IS RECORD (name varchar2(4000)
,name_char char(2000)
,seqno number
,seqno_big number(38,0)
,seqno_small number(2,-28)
, seqno_float float
,date_generic date
,a_raw raw(100)
,a_long_raw long raw
/*,a_long long
,a_clob clob
,a_blob blob
,a_bfile bfile*/);
--
END;
.
/

show errors

create or replace package dbhell.record_test2b_9i as
--
TYPE recordtype9i IS RECORD (
name varchar2(4000)
,name_char char(2000)
,seqno number
,seqno_big number(38,0)
,seqno_small number(2,-28)
,seqno_float float
,a_raw raw(100)
/*,a_long_raw long raw*/
,date_generic date
,timestamp_generic timestamp
/* ,timestamp_tz timestamp with time zone
,timestamp_local_tz timestamp with local time zone
,date_year_2_month interval year (2) to month
,date_day_2_second interval day (6) to second */
,a_rowid rowid
/*,a_u_rowid urowid*/
,a_long long
/*,a_clob clob
,a_blob blob
,a_bfile bfile*/);
--
END;
.
/

show errors

create or replace package record_test2_8i as
--
TYPE all8i_datatypes_typ IS REF CURSOR RETURN all8i_datatypes%ROWTYPE;  -- strong
--
TYPE GenericCurTyp IS REF CURSOR;  -- weak
--
TYPE recordType IS RECORD (name varchar2(4000)
,name_char char(2000)
,seqno number
,seqno_big number(38,0)
,seqno_small number(2,-28)
, seqno_float float
,date_generic date
,a_raw raw(100)
,a_long_raw long raw
/*,a_long long
,a_clob clob
,a_blob blob
,a_bfile bfile*/);
--
TYPE ANDRecordType IS RECORD (ast all8i_datatypes%ROWTYPE);
TYPE AND2RecordType IS RECORD (ast all8i_datatypes%ROWTYPE
                              ,flag VARCHAR2(1)
			      ,msg VARCHAR2(200)
                              ,real_flag boolean
                              ,ast2 recordType
                              ,ast3 record_test2b_8i.recordType8i
			      ,ast4 dbhell.rectest2_8itype);
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
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all8i_datatypes_typ
	/*     ,p_clob            in clob */
	     ,p_package_recordtype1 in     recordType
	     ,p_package_recordtype2 in out recordType
	     ,p_package_recordtype3    out recordType
	     ,p_nonpackage_recordtype1 in     record_test2b_8i.recordType8i
	     ,p_nonpackage_recordtype2 in out record_test2b_8i.recordType8i
	     ,p_nonpackage_recordtype3    out record_test2b_8i.recordType8i
             ,p_rowtype1 in     all8i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all8i_datatypes%ROWTYPE
             ,p_rowtype3    out all8i_datatypes%ROWTYPE
	     ,p_db_recordtype1 in     rectest2_8itype
	     ,p_db_recordtype2 in out rectest2_8itype
	     ,p_db_recordtype3    out rectest2_8itype
             ,p_string2          in string
             );
--
function rt2(p_binary_integer  in binary_integer
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
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all8i_datatypes_typ
        /*     ,p_clob            in clob */
             ,p_package_recordtype1 in     recordType
             ,p_package_recordtype2 in out recordType
             ,p_package_recordtype3    out recordType
             ,p_nonpackage_recordtype1 in     record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype2 in out record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype3    out record_test2b_8i.recordType8i
             ,p_rowtype1 in     all8i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all8i_datatypes%ROWTYPE
             ,p_rowtype3    out all8i_datatypes%ROWTYPE
             ,p_db_recordtype1 in     rectest2_8itype
             ,p_db_recordtype2 in out rectest2_8itype
             ,p_db_recordtype3    out rectest2_8itype
             ,p_string2          in string) RETURN recordType;
--
function rt3(p_binary_integer  in binary_integer
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
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all8i_datatypes_typ
        /*     ,p_clob            in clob */
             ,p_package_recordtype1 in     recordType
             ,p_package_recordtype2 in out recordType
             ,p_package_recordtype3    out recordType
             ,p_nonpackage_recordtype1 in     record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype2 in out record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype3    out record_test2b_8i.recordType8i
             ,p_rowtype1 in     all8i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all8i_datatypes%ROWTYPE
             ,p_rowtype3    out all8i_datatypes%ROWTYPE
             ,p_db_recordtype1 in     rectest2_8itype
             ,p_db_recordtype2 in out rectest2_8itype
             ,p_db_recordtype3    out rectest2_8itype
             ,p_string2          in string) RETURN record_test2b_8i.recordType8i;
--
function rt4(p_binary_integer  in binary_integer
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
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all8i_datatypes_typ
        /*     ,p_clob            in clob */
             ,p_package_recordtype1 in     recordType
             ,p_package_recordtype2 in out recordType
             ,p_package_recordtype3    out recordType
             ,p_nonpackage_recordtype1 in     record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype2 in out record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype3    out record_test2b_8i.recordType8i
             ,p_rowtype1 in     all8i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all8i_datatypes%ROWTYPE
             ,p_rowtype3    out all8i_datatypes%ROWTYPE
             ,p_db_recordtype1 in     rectest2_8itype
             ,p_db_recordtype2 in out rectest2_8itype
             ,p_db_recordtype3    out rectest2_8itype
             ,p_string2          in string) RETURN dbhell.all8i_datatypes%ROWTYPE;
--
function rt5(p_binary_integer  in binary_integer
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
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all8i_datatypes_typ
        /*     ,p_clob            in clob */
             ,p_package_recordtype1 in     recordType
             ,p_package_recordtype2 in out recordType
             ,p_package_recordtype3    out recordType
             ,p_nonpackage_recordtype1 in     record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype2 in out record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype3    out record_test2b_8i.recordType8i
             ,p_rowtype1 in     all8i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all8i_datatypes%ROWTYPE
             ,p_rowtype3    out all8i_datatypes%ROWTYPE
             ,p_db_recordtype1 in     rectest2_8itype
             ,p_db_recordtype2 in out rectest2_8itype
             ,p_db_recordtype3    out rectest2_8itype
             ,p_string2          in string) RETURN rectest2_8itype;
--
end;
.
/

show errors


create or replace package body record_test2_8i as
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
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all8i_datatypes_typ
/*	     ,p_clob            in clob */
	     ,p_package_recordtype1 in     recordType
	     ,p_package_recordtype2 in out recordType
	     ,p_package_recordtype3    out recordType
	     ,p_nonpackage_recordtype1 in     record_test2b_8i.recordType8i
	     ,p_nonpackage_recordtype2 in out record_test2b_8i.recordType8i
	     ,p_nonpackage_recordtype3    out record_test2b_8i.recordType8i
             ,p_rowtype1 in     all8i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all8i_datatypes%ROWTYPE
             ,p_rowtype3    out all8i_datatypes%ROWTYPE
	     ,p_db_recordtype1 in     rectest2_8itype
	     ,p_db_recordtype2 in out rectest2_8itype
	     ,p_db_recordtype3    out rectest2_8itype
             ,p_string2          in string
             ) IS
--
BEGIN
--
  open p_outcursor FOR
  SELECT * from all8i_datatypes;
--
  open p_outcursor2 FOR
  SELECT * from all8i_datatypes;
--
  p_package_recordtype3 := p_package_recordtype2;
  p_nonpackage_recordtype3 := p_nonpackage_recordtype2;
  p_rowtype3 := p_rowtype2;
  p_db_recordtype3 := p_db_recordtype2;
--
END;
--
function rt2(p_binary_integer  in binary_integer
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
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all8i_datatypes_typ
        /*     ,p_clob            in clob */
             ,p_package_recordtype1 in     recordType
             ,p_package_recordtype2 in out recordType
             ,p_package_recordtype3    out recordType
             ,p_nonpackage_recordtype1 in     record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype2 in out record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype3    out record_test2b_8i.recordType8i
             ,p_rowtype1 in     all8i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all8i_datatypes%ROWTYPE
             ,p_rowtype3    out all8i_datatypes%ROWTYPE
             ,p_db_recordtype1 in     rectest2_8itype
             ,p_db_recordtype2 in out rectest2_8itype
             ,p_db_recordtype3    out rectest2_8itype
             ,p_string2          in string) RETURN recordType IS
--
BEGIN
--
  open p_outcursor FOR
  SELECT * from all8i_datatypes;
--
  open p_outcursor2 FOR
  SELECT * from all8i_datatypes;
--
  p_package_recordtype3 := p_package_recordtype2;
  p_nonpackage_recordtype3 := p_nonpackage_recordtype2;
  p_rowtype3 := p_rowtype2;
  p_db_recordtype3 := p_db_recordtype2;
--
RETURN(p_package_recordtype3);
--
END;
--
function rt3(p_binary_integer  in binary_integer
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
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all8i_datatypes_typ
        /*     ,p_clob            in clob */
             ,p_package_recordtype1 in     recordType
             ,p_package_recordtype2 in out recordType
             ,p_package_recordtype3    out recordType
             ,p_nonpackage_recordtype1 in     record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype2 in out record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype3    out record_test2b_8i.recordType8i
             ,p_rowtype1 in     all8i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all8i_datatypes%ROWTYPE
             ,p_rowtype3    out all8i_datatypes%ROWTYPE
             ,p_db_recordtype1 in     rectest2_8itype
             ,p_db_recordtype2 in out rectest2_8itype
             ,p_db_recordtype3    out rectest2_8itype
             ,p_string2          in string) RETURN record_test2b_8i.recordType8i IS
--
BEGIN
--
  open p_outcursor FOR
  SELECT * from all8i_datatypes;
--
  open p_outcursor2 FOR
  SELECT * from all8i_datatypes;
--
  p_package_recordtype3 := p_package_recordtype2;
  p_nonpackage_recordtype3 := p_nonpackage_recordtype2;
  p_rowtype3 := p_rowtype2;
  p_db_recordtype3 := p_db_recordtype2;
--
RETURN(p_nonpackage_recordtype3);
--
END;
--
function rt4(p_binary_integer  in binary_integer
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
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all8i_datatypes_typ
        /*     ,p_clob            in clob */
             ,p_package_recordtype1 in     recordType
             ,p_package_recordtype2 in out recordType
             ,p_package_recordtype3    out recordType
             ,p_nonpackage_recordtype1 in     record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype2 in out record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype3    out record_test2b_8i.recordType8i
             ,p_rowtype1 in     all8i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all8i_datatypes%ROWTYPE
             ,p_rowtype3    out all8i_datatypes%ROWTYPE
             ,p_db_recordtype1 in     rectest2_8itype
             ,p_db_recordtype2 in out rectest2_8itype
             ,p_db_recordtype3    out rectest2_8itype
             ,p_string2          in string) RETURN dbhell.all8i_datatypes%ROWTYPE IS
--
BEGIN
--
  open p_outcursor FOR
  SELECT * from all8i_datatypes;
--
  open p_outcursor2 FOR
  SELECT * from all8i_datatypes;
--
  p_package_recordtype3 := p_package_recordtype2;
  p_nonpackage_recordtype3 := p_nonpackage_recordtype2;
  p_rowtype3 := p_rowtype2;
  p_db_recordtype3 := p_db_recordtype2;
--
RETURN(p_rowtype3);
--
END;
--
function rt5(p_binary_integer  in binary_integer
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
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all8i_datatypes_typ
        /*     ,p_clob            in clob */
             ,p_package_recordtype1 in     recordType
             ,p_package_recordtype2 in out recordType
             ,p_package_recordtype3    out recordType
             ,p_nonpackage_recordtype1 in     record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype2 in out record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype3    out record_test2b_8i.recordType8i
             ,p_rowtype1 in     all8i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all8i_datatypes%ROWTYPE
             ,p_rowtype3    out all8i_datatypes%ROWTYPE
             ,p_db_recordtype1 in     rectest2_8itype
             ,p_db_recordtype2 in out rectest2_8itype
             ,p_db_recordtype3    out rectest2_8itype
             ,p_string2          in string) RETURN rectest2_8itype IS
--
BEGIN
--
  open p_outcursor FOR
  SELECT * from all8i_datatypes;
--
  open p_outcursor2 FOR
  SELECT * from all8i_datatypes;
--
  p_package_recordtype3 := p_package_recordtype2;
  p_nonpackage_recordtype3 := p_nonpackage_recordtype2;
  p_rowtype3 := p_rowtype2;
  p_db_recordtype3 := p_db_recordtype2;
--
RETURN(p_db_recordtype3);
--
--
END;
--
end;
.
/

show errors



create or replace package record_test2_9i as
--
TYPE all_9i_datatypes_typ IS REF CURSOR RETURN all_9i_datatypes%ROWTYPE;  -- strong
--
TYPE GenericCurTyp IS REF CURSOR;  -- weak
--
TYPE recordType IS RECORD (name varchar2(4000)
,name_char char(2000)
,seqno number
,seqno_big number(38,0)
,seqno_small number(2,-28)
, seqno_float float
,date_generic date
,a_raw raw(100)
/*,a_long_raw long raw */
/*,a_long long
,a_clob clob
,a_blob blob
,a_bfile bfile*/);
--
TYPE ANDRecordType IS RECORD (ast all_9i_datatypes%ROWTYPE);
TYPE AND2RecordType IS RECORD (ast all_9i_datatypes%ROWTYPE
                              ,flag VARCHAR2(1)
			      ,msg VARCHAR2(200)
                              ,real_flag boolean
                              ,ast2 recordType
                              ,ast3 record_test2b_9i.recordType9i
			      ,ast4 dbhell.rectest2_9itype);
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
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all_9i_datatypes_typ
	     ,p_clob            in clob 
	     ,p_package_recordtype1 in     recordType
	     ,p_package_recordtype2 in out recordType
	     ,p_package_recordtype3    out recordType
	     ,p_nonpackage_recordtype1 in     record_test2b_9i.recordType9i
	     ,p_nonpackage_recordtype2 in out record_test2b_9i.recordType9i
	     ,p_nonpackage_recordtype3    out record_test2b_9i.recordType9i
             ,p_rowtype1 in     all_9i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all_9i_datatypes%ROWTYPE
             ,p_rowtype3    out all_9i_datatypes%ROWTYPE
	     ,p_db_recordtype1 in     rectest2_9itype
	     ,p_db_recordtype2 in out rectest2_9itype
	     ,p_db_recordtype3    out rectest2_9itype
             ,p_string2          in string
             );
--
function rt2(p_binary_integer  in binary_integer
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
	     ,p_blob            in blob 
	     ,p_bfile           in bfile 
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
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all_9i_datatypes_typ
             ,p_clob            in clob 
             ,p_package_recordtype1 in     recordType
             ,p_package_recordtype2 in out recordType
             ,p_package_recordtype3    out recordType
             ,p_nonpackage_recordtype1 in     record_test2b_9i.recordType9i
             ,p_nonpackage_recordtype2 in out record_test2b_9i.recordType9i
             ,p_nonpackage_recordtype3    out record_test2b_9i.recordType9i
             ,p_rowtype1 in     all_9i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all_9i_datatypes%ROWTYPE
             ,p_rowtype3    out all_9i_datatypes%ROWTYPE
             ,p_db_recordtype1 in     rectest2_9itype
             ,p_db_recordtype2 in out rectest2_9itype
             ,p_db_recordtype3    out rectest2_9itype
             ,p_string2          in string) RETURN recordType;
--
function rt3(p_binary_integer  in binary_integer
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
	     ,p_blob            in blob 
	     ,p_bfile           in bfile 
             ,p_varchar         in varchar
             ,p_varchar2        in varchar2
             ,p_boolean         in boolean
             ,p_date            in date
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all_9i_datatypes_typ
             ,p_clob            in clob
             ,p_package_recordtype1 in     recordType
             ,p_package_recordtype2 in out recordType
             ,p_package_recordtype3    out recordType
             ,p_nonpackage_recordtype1 in     record_test2b_9i.recordType9i
             ,p_nonpackage_recordtype2 in out record_test2b_9i.recordType9i
             ,p_nonpackage_recordtype3    out record_test2b_9i.recordType9i
             ,p_rowtype1 in     all_9i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all_9i_datatypes%ROWTYPE
             ,p_rowtype3    out all_9i_datatypes%ROWTYPE
             ,p_db_recordtype1 in     rectest2_9itype
             ,p_db_recordtype2 in out rectest2_9itype
             ,p_db_recordtype3    out rectest2_9itype
             ,p_string2          in string) RETURN record_test2b_9i.recordType9i;
--
function rt4(p_binary_integer  in binary_integer
             ,p_dec             in dec
             ,p_decimal         in decimal
             ,p_double          in double precision
             ,p_float           in float
             ,p_int             in int
             ,p_integer         in integer
	     ,p_blob            in blob 
	     ,p_bfile           in bfile 
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
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all_9i_datatypes_typ
           ,p_clob            in clob 
             ,p_package_recordtype1 in     recordType
             ,p_package_recordtype2 in out recordType
             ,p_package_recordtype3    out recordType
             ,p_nonpackage_recordtype1 in     record_test2b_9i.recordType9i
             ,p_nonpackage_recordtype2 in out record_test2b_9i.recordType9i
             ,p_nonpackage_recordtype3    out record_test2b_9i.recordType9i
             ,p_rowtype1 in     all_9i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all_9i_datatypes%ROWTYPE
             ,p_rowtype3    out all_9i_datatypes%ROWTYPE
             ,p_db_recordtype1 in     rectest2_9itype
             ,p_db_recordtype2 in out rectest2_9itype
             ,p_db_recordtype3    out rectest2_9itype
             ,p_string2          in string) RETURN dbhell.all_9i_datatypes%ROWTYPE;
--
function rt5(p_binary_integer  in binary_integer
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
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all_9i_datatypes_typ
             ,p_clob            in clob 
             ,p_package_recordtype1 in     recordType
             ,p_package_recordtype2 in out recordType
             ,p_package_recordtype3    out recordType
             ,p_nonpackage_recordtype1 in     record_test2b_9i.recordType9i
	     ,p_blob            in blob 
	     ,p_bfile           in bfile 
             ,p_nonpackage_recordtype2 in out record_test2b_9i.recordType9i
             ,p_nonpackage_recordtype3    out record_test2b_9i.recordType9i
             ,p_rowtype1 in     all_9i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all_9i_datatypes%ROWTYPE
             ,p_rowtype3    out all_9i_datatypes%ROWTYPE
             ,p_db_recordtype1 in     rectest2_9itype
             ,p_db_recordtype2 in out rectest2_9itype
             ,p_db_recordtype3    out rectest2_9itype
             ,p_string2          in string) RETURN rectest2_9itype;
--
end;
.
/

show errors


create or replace package body record_test2_9i as
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
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all_9i_datatypes_typ
	     ,p_clob            in clob 
	     ,p_package_recordtype1 in     recordType
	     ,p_package_recordtype2 in out recordType
	     ,p_package_recordtype3    out recordType
	     ,p_nonpackage_recordtype1 in     record_test2b_9i.recordType9i
	     ,p_nonpackage_recordtype2 in out record_test2b_9i.recordType9i
	     ,p_nonpackage_recordtype3    out record_test2b_9i.recordType9i
             ,p_rowtype1 in     all_9i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all_9i_datatypes%ROWTYPE
             ,p_rowtype3    out all_9i_datatypes%ROWTYPE
	     ,p_db_recordtype1 in     rectest2_9itype
	     ,p_db_recordtype2 in out rectest2_9itype
	     ,p_db_recordtype3    out rectest2_9itype
             ,p_string2          in string
             ) IS
--
BEGIN
--
  open p_outcursor FOR
  SELECT * from all_9i_datatypes;
--
  open p_outcursor2 FOR
  SELECT * from all_9i_datatypes;
--
  p_package_recordtype3 := p_package_recordtype2;
  p_nonpackage_recordtype3 := p_nonpackage_recordtype2;
  p_rowtype3 := p_rowtype2;
  p_db_recordtype3 := p_db_recordtype2;
--
END;
--
function rt2(p_binary_integer  in binary_integer
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
	     ,p_blob            in blob 
	     ,p_bfile           in bfile 
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
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all_9i_datatypes_typ
             ,p_clob            in clob 
             ,p_package_recordtype1 in     recordType
             ,p_package_recordtype2 in out recordType
             ,p_package_recordtype3    out recordType
             ,p_nonpackage_recordtype1 in     record_test2b_9i.recordType9i
             ,p_nonpackage_recordtype2 in out record_test2b_9i.recordType9i
             ,p_nonpackage_recordtype3    out record_test2b_9i.recordType9i
             ,p_rowtype1 in     all_9i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all_9i_datatypes%ROWTYPE
             ,p_rowtype3    out all_9i_datatypes%ROWTYPE
             ,p_db_recordtype1 in     rectest2_9itype
             ,p_db_recordtype2 in out rectest2_9itype
             ,p_db_recordtype3    out rectest2_9itype
             ,p_string2          in string) RETURN recordType IS
--
BEGIN
--
  open p_outcursor FOR
  SELECT * from all_9i_datatypes;
--
  open p_outcursor2 FOR
  SELECT * from all_9i_datatypes;
--
  p_package_recordtype3 := p_package_recordtype2;
  p_nonpackage_recordtype3 := p_nonpackage_recordtype2;
  p_rowtype3 := p_rowtype2;
  p_db_recordtype3 := p_db_recordtype2;
--
RETURN(p_package_recordtype3);
--
END;
--
function rt3(p_binary_integer  in binary_integer
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
	     ,p_blob            in blob 
	     ,p_bfile           in bfile 
             ,p_varchar         in varchar
             ,p_varchar2        in varchar2
             ,p_boolean         in boolean
             ,p_date            in date
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all_9i_datatypes_typ
             ,p_clob            in clob 
             ,p_package_recordtype1 in     recordType
             ,p_package_recordtype2 in out recordType
             ,p_package_recordtype3    out recordType
             ,p_nonpackage_recordtype1 in     record_test2b_9i.recordType9i
             ,p_nonpackage_recordtype2 in out record_test2b_9i.recordType9i
             ,p_nonpackage_recordtype3    out record_test2b_9i.recordType9i
             ,p_rowtype1 in     all_9i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all_9i_datatypes%ROWTYPE
             ,p_rowtype3    out all_9i_datatypes%ROWTYPE
             ,p_db_recordtype1 in     rectest2_9itype
             ,p_db_recordtype2 in out rectest2_9itype
             ,p_db_recordtype3    out rectest2_9itype
             ,p_string2          in string) RETURN record_test2b_9i.recordType9i IS
--
BEGIN
--
  open p_outcursor FOR
  SELECT * from all_9i_datatypes;
--
  open p_outcursor2 FOR
  SELECT * from all_9i_datatypes;
--
  p_package_recordtype3 := p_package_recordtype2;
  p_nonpackage_recordtype3 := p_nonpackage_recordtype2;
  p_rowtype3 := p_rowtype2;
  p_db_recordtype3 := p_db_recordtype2;
--
RETURN(p_nonpackage_recordtype3);
--
END;
--
function rt4(p_binary_integer  in binary_integer
             ,p_dec             in dec
             ,p_decimal         in decimal
             ,p_double          in double precision
             ,p_float           in float
             ,p_int             in int
             ,p_integer         in integer
	     ,p_blob            in blob 
	     ,p_bfile           in bfile 
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
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all_9i_datatypes_typ
             ,p_clob            in clob 
             ,p_package_recordtype1 in     recordType
             ,p_package_recordtype2 in out recordType
             ,p_package_recordtype3    out recordType
             ,p_nonpackage_recordtype1 in     record_test2b_9i.recordType9i
             ,p_nonpackage_recordtype2 in out record_test2b_9i.recordType9i
             ,p_nonpackage_recordtype3    out record_test2b_9i.recordType9i
             ,p_rowtype1 in     all_9i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all_9i_datatypes%ROWTYPE
             ,p_rowtype3    out all_9i_datatypes%ROWTYPE
             ,p_db_recordtype1 in     rectest2_9itype
             ,p_db_recordtype2 in out rectest2_9itype
             ,p_db_recordtype3    out rectest2_9itype
             ,p_string2          in string) RETURN dbhell.all_9i_datatypes%ROWTYPE IS
--
BEGIN
--
  open p_outcursor FOR
  SELECT * from all_9i_datatypes;
--
  open p_outcursor2 FOR
  SELECT * from all_9i_datatypes;
--
  p_package_recordtype3 := p_package_recordtype2;
  p_nonpackage_recordtype3 := p_nonpackage_recordtype2;
  p_rowtype3 := p_rowtype2;
  p_db_recordtype3 := p_db_recordtype2;
--
RETURN(p_rowtype3);
--
END;
--
function rt5(p_binary_integer  in binary_integer
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
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all_9i_datatypes_typ
             ,p_clob            in clob 
             ,p_package_recordtype1 in     recordType
             ,p_package_recordtype2 in out recordType
             ,p_package_recordtype3    out recordType
             ,p_nonpackage_recordtype1 in     record_test2b_9i.recordType9i
	     ,p_blob            in blob 
	     ,p_bfile           in bfile 
             ,p_nonpackage_recordtype2 in out record_test2b_9i.recordType9i
             ,p_nonpackage_recordtype3    out record_test2b_9i.recordType9i
             ,p_rowtype1 in     all_9i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all_9i_datatypes%ROWTYPE
             ,p_rowtype3    out all_9i_datatypes%ROWTYPE
             ,p_db_recordtype1 in     rectest2_9itype
             ,p_db_recordtype2 in out rectest2_9itype
             ,p_db_recordtype3    out rectest2_9itype
             ,p_string2          in string) RETURN rectest2_9itype IS
--
BEGIN
--
  open p_outcursor FOR
  SELECT * from all_9i_datatypes;
--
  open p_outcursor2 FOR
  SELECT * from all_9i_datatypes;
--
  p_package_recordtype3 := p_package_recordtype2;
  p_nonpackage_recordtype3 := p_nonpackage_recordtype2;
  p_rowtype3 := p_rowtype2;
  p_db_recordtype3 := p_db_recordtype2;
--
RETURN(p_db_recordtype3);
--
--
END;
--
end;
.
/

show errors



