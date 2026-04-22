

create or replace package record_test2_8i_lite as
--
TYPE all8i_datatypes_typ IS REF CURSOR RETURN all_8i_datatypes%ROWTYPE;  -- strong
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
/*,a_long long*/
,a_clob clob
,a_blob blob);
--
TYPE ANDRecordType IS RECORD (ast all_8i_datatypes%ROWTYPE);
TYPE AND2RecordType IS RECORD (ast all_8i_datatypes%ROWTYPE
                              ,flag VARCHAR2(1)
			      ,msg VARCHAR2(200)
                              ,real_flag boolean
                              ,ast2 recordType
                              ,ast3 record_test2b_8i.recordType8i
			      ,ast4 rectest2_8itype);
--
-- cursors not in 8.1.6
procedure rt0 (p_binary_integer  in binary_integer
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
             ,p_date            in date
             ,p_boolean         in boolean
	     ,p_package_recordtype1 in     recordType
	     ,p_package_recordtype2 in out recordType
	     ,p_package_recordtype3    out recordType
             ,p_rowtype1 in     all_8i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all_8i_datatypes%ROWTYPE
             ,p_rowtype3    out all_8i_datatypes%ROWTYPE
	     ,p_db_recordtype1 in     rectest2_8itype
	     ,p_db_recordtype2 in out rectest2_8itype
	     ,p_db_recordtype3    out rectest2_8itype
             );
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
/*
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all8i_datatypes_typ
*/
	     ,p_clob_in         in clob 
             ,p_blob_in         in blob
	     ,p_clob_in_out     in out clob 
             ,p_blob_in_out     in out blob
	     ,p_clob_out        out clob 
             ,p_blob_out         out blob
	     ,p_package_recordtype1 in     recordType
	     ,p_package_recordtype2 in out recordType
	     ,p_package_recordtype3    out recordType
	     ,p_nonpackage_recordtype1 in     record_test2b_8i.recordType8i
	     ,p_nonpackage_recordtype2 in out record_test2b_8i.recordType8i
	     ,p_nonpackage_recordtype3    out record_test2b_8i.recordType8i
             ,p_rowtype1 in     all_8i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all_8i_datatypes%ROWTYPE
             ,p_rowtype3    out all_8i_datatypes%ROWTYPE
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
/*
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all8i_datatypes_typ
*/
             ,p_clob_in         in clob
             ,p_blob_in         in blob
             ,p_clob_in_out     in out clob
             ,p_blob_in_out     in out blob
             ,p_clob_out        out clob 
             ,p_blob_out        out blob
             ,p_package_recordtype1 in     recordType
             ,p_package_recordtype2 in out recordType
             ,p_package_recordtype3    out recordType
             ,p_nonpackage_recordtype1 in     record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype2 in out record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype3    out record_test2b_8i.recordType8i
             ,p_rowtype1 in     all_8i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all_8i_datatypes%ROWTYPE
             ,p_rowtype3    out all_8i_datatypes%ROWTYPE
             ,p_db_recordtype1 in     rectest2_8itype
             ,p_db_recordtype2 in out rectest2_8itype
             ,p_db_recordtype3    out rectest2_8itype
             ,p_string2          in string) RETURN number;
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
/*
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all8i_datatypes_typ
*/
             ,p_clob_in         in clob
             ,p_blob_in         in blob
             ,p_clob_in_out     in out clob
             ,p_blob_in_out     in out blob
             ,p_clob_out        out clob 
             ,p_blob_out        out blob
             ,p_package_recordtype1 in     recordType
             ,p_package_recordtype2 in out recordType
             ,p_package_recordtype3    out recordType
             ,p_nonpackage_recordtype1 in     record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype2 in out record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype3    out record_test2b_8i.recordType8i
             ,p_rowtype1 in     all_8i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all_8i_datatypes%ROWTYPE
             ,p_rowtype3    out all_8i_datatypes%ROWTYPE
             ,p_db_recordtype1 in     rectest2_8itype
             ,p_db_recordtype2 in out rectest2_8itype
             ,p_db_recordtype3    out rectest2_8itype
             ,p_string2          in string) RETURN number;
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
/*
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all8i_datatypes_typ
*/
             ,p_clob_in         in clob
             ,p_blob_in         in blob
             ,p_clob_in_out     in out clob
             ,p_blob_in_out     in out blob
             ,p_clob_out       out clob 
             ,p_blob_out       out blob
             ,p_package_recordtype1 in     recordType
             ,p_package_recordtype2 in out recordType
             ,p_package_recordtype3    out recordType
             ,p_nonpackage_recordtype1 in     record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype2 in out record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype3    out record_test2b_8i.recordType8i
             ,p_rowtype1 in     all_8i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all_8i_datatypes%ROWTYPE
             ,p_rowtype3    out all_8i_datatypes%ROWTYPE
             ,p_db_recordtype1 in     rectest2_8itype
             ,p_db_recordtype2 in out rectest2_8itype
             ,p_db_recordtype3    out rectest2_8itype
             ,p_string2          in string) RETURN number;
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
/*
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all8i_datatypes_typ
*/
             ,p_clob_in         in clob
             ,p_blob_in         in blob
             ,p_clob_in_out     in out clob
             ,p_blob_in_out     in out blob
             ,p_clob_out        out clob 
             ,p_blob_out        out blob
             ,p_package_recordtype1 in     recordType
             ,p_package_recordtype2 in out recordType
             ,p_package_recordtype3    out recordType
             ,p_nonpackage_recordtype1 in     record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype2 in out record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype3    out record_test2b_8i.recordType8i
             ,p_rowtype1 in     all_8i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all_8i_datatypes%ROWTYPE
             ,p_rowtype3    out all_8i_datatypes%ROWTYPE
             ,p_db_recordtype1 in     rectest2_8itype
             ,p_db_recordtype2 in out rectest2_8itype
             ,p_db_recordtype3    out rectest2_8itype
             ,p_string2          in string) RETURN number;
--
end;
.
/

show errors


create or replace package body record_test2_8i_lite as
--
procedure rt0 (p_binary_integer  in binary_integer
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
             ,p_date            in date
             ,p_boolean         in boolean
	     ,p_package_recordtype1 in     recordType
	     ,p_package_recordtype2 in out recordType
	     ,p_package_recordtype3    out recordType
             ,p_rowtype1 in     all_8i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all_8i_datatypes%ROWTYPE
             ,p_rowtype3    out all_8i_datatypes%ROWTYPE
	     ,p_db_recordtype1 in     rectest2_8itype
	     ,p_db_recordtype2 in out rectest2_8itype
	     ,p_db_recordtype3    out rectest2_8itype
             ) IS
--
BEGIN
--
  null;
  p_rowtype3 := p_rowtype2;
  p_db_recordtype3 := p_db_recordtype2;
  p_package_recordtype3 := p_package_recordtype2;
--
--  open p_outcursor FOR
--  SELECT * from all8i_datatypes;
--
END;
--
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
/*
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all8i_datatypes_typ
*/
	     ,p_clob_in         in clob 
             ,p_blob_in         in blob
	     ,p_clob_in_out     in out clob 
             ,p_blob_in_out     in out blob
	     ,p_clob_out        out clob 
             ,p_blob_out         out blob
	     ,p_package_recordtype1 in     recordType
	     ,p_package_recordtype2 in out recordType
	     ,p_package_recordtype3    out recordType
	     ,p_nonpackage_recordtype1 in     record_test2b_8i.recordType8i
	     ,p_nonpackage_recordtype2 in out record_test2b_8i.recordType8i
	     ,p_nonpackage_recordtype3    out record_test2b_8i.recordType8i
             ,p_rowtype1 in     all_8i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all_8i_datatypes%ROWTYPE
             ,p_rowtype3    out all_8i_datatypes%ROWTYPE
	     ,p_db_recordtype1 in     rectest2_8itype
	     ,p_db_recordtype2 in out rectest2_8itype
	     ,p_db_recordtype3    out rectest2_8itype
             ,p_string2          in string
             ) IS
--
BEGIN
--
p_package_recordtype3 := p_package_recordtype2;
p_nonpackage_recordtype3 := p_nonpackage_recordtype2;
p_rowtype3 := p_rowtype2;
p_db_recordtype3 := p_db_recordtype2;
--
END;
--
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
/*
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all8i_datatypes_typ
*/
             ,p_clob_in         in clob
             ,p_blob_in         in blob
             ,p_clob_in_out     in out clob
             ,p_blob_in_out     in out blob
             ,p_clob_out        out clob 
             ,p_blob_out        out blob
             ,p_package_recordtype1 in     recordType
             ,p_package_recordtype2 in out recordType
             ,p_package_recordtype3    out recordType
             ,p_nonpackage_recordtype1 in     record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype2 in out record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype3    out record_test2b_8i.recordType8i
             ,p_rowtype1 in     all_8i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all_8i_datatypes%ROWTYPE
             ,p_rowtype3    out all_8i_datatypes%ROWTYPE
             ,p_db_recordtype1 in     rectest2_8itype
             ,p_db_recordtype2 in out rectest2_8itype
             ,p_db_recordtype3    out rectest2_8itype
             ,p_string2          in string) RETURN number IS
--
BEGIN
--
--
p_package_recordtype3 := p_package_recordtype2;
p_nonpackage_recordtype3 := p_nonpackage_recordtype2;
p_rowtype3 := p_rowtype2;
p_db_recordtype3 := p_db_recordtype2;
--
return (42);
--
END;
--
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
/*
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all8i_datatypes_typ
*/
             ,p_clob_in         in clob
             ,p_blob_in         in blob
             ,p_clob_in_out     in out clob
             ,p_blob_in_out     in out blob
             ,p_clob_out        out clob 
             ,p_blob_out        out blob
             ,p_package_recordtype1 in     recordType
             ,p_package_recordtype2 in out recordType
             ,p_package_recordtype3    out recordType
             ,p_nonpackage_recordtype1 in     record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype2 in out record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype3    out record_test2b_8i.recordType8i
             ,p_rowtype1 in     all_8i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all_8i_datatypes%ROWTYPE
             ,p_rowtype3    out all_8i_datatypes%ROWTYPE
             ,p_db_recordtype1 in     rectest2_8itype
             ,p_db_recordtype2 in out rectest2_8itype
             ,p_db_recordtype3    out rectest2_8itype
             ,p_string2          in string) RETURN number IS
--
BEGIN
--
--
  p_package_recordtype3 := p_package_recordtype2;
p_nonpackage_recordtype3 := p_nonpackage_recordtype2;
p_rowtype3 := p_rowtype2;
p_db_recordtype3 := p_db_recordtype2;
--
return (42);
--
END;
--
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
/*
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all8i_datatypes_typ
*/
             ,p_clob_in         in clob
             ,p_blob_in         in blob
             ,p_clob_in_out     in out clob
             ,p_blob_in_out     in out blob
             ,p_clob_out       out clob 
             ,p_blob_out       out blob
             ,p_package_recordtype1 in     recordType
             ,p_package_recordtype2 in out recordType
             ,p_package_recordtype3    out recordType
             ,p_nonpackage_recordtype1 in     record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype2 in out record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype3    out record_test2b_8i.recordType8i
             ,p_rowtype1 in     all_8i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all_8i_datatypes%ROWTYPE
             ,p_rowtype3    out all_8i_datatypes%ROWTYPE
             ,p_db_recordtype1 in     rectest2_8itype
             ,p_db_recordtype2 in out rectest2_8itype
             ,p_db_recordtype3    out rectest2_8itype
             ,p_string2          in string) RETURN number IS
--
BEGIN
--
p_package_recordtype3 := p_package_recordtype2;
p_nonpackage_recordtype3 := p_nonpackage_recordtype2;
  p_rowtype3 := p_rowtype2;
p_db_recordtype3 := p_db_recordtype2;
--
return (42);
--
END;
--
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
/*
             ,p_outcursor       out GenericCurTyp
             ,p_outcursor2      out all8i_datatypes_typ
*/
             ,p_clob_in         in clob
             ,p_blob_in         in blob
             ,p_clob_in_out     in out clob
             ,p_blob_in_out     in out blob
             ,p_clob_out        out clob 
             ,p_blob_out        out blob
             ,p_package_recordtype1 in     recordType
             ,p_package_recordtype2 in out recordType
             ,p_package_recordtype3    out recordType
             ,p_nonpackage_recordtype1 in     record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype2 in out record_test2b_8i.recordType8i
             ,p_nonpackage_recordtype3    out record_test2b_8i.recordType8i
             ,p_rowtype1 in     all_8i_datatypes%ROWTYPE
             ,p_rowtype2 in out dbhell.all_8i_datatypes%ROWTYPE
             ,p_rowtype3    out all_8i_datatypes%ROWTYPE
             ,p_db_recordtype1 in     rectest2_8itype
             ,p_db_recordtype2 in out rectest2_8itype
             ,p_db_recordtype3    out rectest2_8itype
             ,p_string2          in string) RETURN number IS
--
BEGIN
--
--
p_package_recordtype3 := p_package_recordtype2;
p_nonpackage_recordtype3 := p_nonpackage_recordtype2;
p_rowtype3 := p_rowtype2;
  p_db_recordtype3 := p_db_recordtype2;
--
return (42);
--
END;
--
--
end;
.
/

show errors




