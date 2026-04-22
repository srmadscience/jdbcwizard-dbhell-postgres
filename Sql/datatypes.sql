drop table clob_test;
drop table blob_test;
drop table bfile_test;
drop sequence clob_seq;
drop sequence blob_seq;
drop sequence bfile_seq;

create sequence clob_seq;
create table clob_test(seqno number, clob_column clob) tablespace dbhell_lob;
insert into clob_test values (0,'Hello World');

create sequence blob_seq;
create table blob_test(seqno number, blob_column blob) tablespace dbhell_lob;
insert into blob_test values (0,hextoraw('FF'));

create sequence bfile_seq;
create table bfile_test(seqno number, bfile_column bfile) tablespace dbhell_lob;

create or replace package dbhell.datatype_test as
--
function  number_func(in_param number) return number;
--
procedure number_proc(in_param in number
                     ,out_param out number
                     ,in_out_param in out number);
--
function  date_func(in_param date) return date;
--
procedure date_proc(in_param in date
                     ,out_param out date
                     ,in_out_param in out date);
--
function  binary_integer_func(in_param binary_integer) return binary_integer;
--
procedure binary_integer_proc(in_param in binary_integer
                     ,out_param out binary_integer
                     ,in_out_param in out binary_integer);
--
function  natural_func(in_param natural) return natural;
--
procedure natural_proc(in_param in natural
                     ,out_param out natural
                     ,in_out_param in out natural);
--
function  naturaln_func(in_param naturaln) return naturaln;
--
procedure naturaln_proc(in_param in naturaln
          --           ,out_param out naturaln 
                     ,in_out_param in out naturaln);
--
function  positive_func(in_param positive) return positive;
--
procedure positive_proc(in_param in positive
                     ,out_param out positive
                     ,in_out_param in out positive);
--
function  positiven_func(in_param positiven) return positiven;
--
procedure positiven_proc(in_param in positiven
               --       ,out_param out positiven
                     ,in_out_param in out positiven);
--
function  signtype_func(in_param signtype) return signtype;
--
procedure signtype_proc(in_param in signtype
                     ,out_param out signtype
                     ,in_out_param in out signtype);
--
function  dec_func(in_param dec) return dec;
--
procedure dec_proc(in_param in dec
                     ,out_param out dec
                     ,in_out_param in out dec);
--
function  decimal_func(in_param decimal) return decimal;
--
procedure decimal_proc(in_param in decimal
                     ,out_param out decimal
                     ,in_out_param in out decimal);
--
function  double_precision_func(in_param double precision) return double precision;
--
procedure double_precision_proc(in_param in double precision
                     ,out_param out double precision
                     ,in_out_param in out double precision);
--
function  float_func(in_param float) return float;
--
procedure float_proc(in_param in float
                     ,out_param out float
                     ,in_out_param in out float);
--
function  integer_func(in_param integer) return integer;
--
procedure integer_proc(in_param in integer
                     ,out_param out integer
                     ,in_out_param in out integer);
--
function  int_func(in_param int) return int;
--
procedure int_proc(in_param in int
                     ,out_param out int
                     ,in_out_param in out int);
--
function  numeric_func(in_param numeric) return numeric;
--
procedure numeric_proc(in_param in numeric
                     ,out_param out numeric
                     ,in_out_param in out numeric);
--
--
function  real_func(in_param real) return real;
--
procedure real_proc(in_param in real
                     ,out_param out real
                     ,in_out_param in out real);
--
--
function  smallint_func(in_param smallint) return smallint;
--
procedure smallint_proc(in_param in smallint
                     ,out_param out smallint
                     ,in_out_param in out smallint);
--
--
function  pls_integer_func(in_param pls_integer) return pls_integer;
--
procedure pls_integer_proc(in_param in pls_integer
                     ,out_param out pls_integer
                     ,in_out_param in out pls_integer);
--
--
function  boolean_func(in_param boolean) return boolean;
--
procedure boolean_proc(in_param in boolean
                     ,out_param out boolean
                     ,in_out_param in out boolean);
--
--
--
function  character_func(in_param character) return character;
--
procedure character_proc(in_param in character
                     ,out_param out character
                     ,in_out_param in out character);
--
function  char_func(in_param char) return char;
--
procedure char_proc(in_param in char
                     ,out_param out char
                     ,in_out_param in out char);
--
function  long_func(in_param long) return long;
--
procedure long_proc(in_param in long
                     ,out_param out long
                     ,in_out_param in out long);
--

function  long_raw_func(in_param long raw) return long raw;
--
procedure long_raw_proc(in_param in long raw
                     ,out_param out long raw
                     ,in_out_param in out long raw);
--
function  raw_func(in_param raw) return raw;
--
procedure raw_proc(in_param in raw
                     ,out_param out raw
                     ,in_out_param in out raw);
--

function  rowid_func(in_param rowid) return rowid;
--
procedure rowid_proc(in_param in  rowid
                     ,out_param out rowid
                     ,in_out_param in out rowid);
--

function  urowid_func(in_param urowid) return urowid;
--
procedure urowid_proc(in_param in urowid
                     ,out_param out urowid
                     ,in_out_param in out urowid);
--

function  string_func(in_param string) return string;
--
procedure string_proc(in_param in string
                     ,out_param out string
                     ,in_out_param in out string);
--

function  varchar_func(in_param varchar) return varchar;
--
procedure varchar_proc(in_param in varchar
                     ,out_param out varchar
                     ,in_out_param in out varchar);
--
function  varchar2_func(in_param varchar2) return varchar2;
--
procedure varchar2_proc(in_param in varchar2
                     ,out_param out varchar2
                     ,in_out_param in out varchar2);
--

function  nchar_func(in_param nchar) return nchar;
--
procedure nchar_proc(in_param in nchar
                     ,out_param out nchar
                     ,in_out_param in out nchar);
--

function  nvarchar2_func(in_param nvarchar2) return nvarchar2;
--
procedure nvarchar2_proc(in_param in nvarchar2
                     ,out_param out nvarchar2
                     ,in_out_param in out nvarchar2);
--
function  bfile_func(in_param varchar2) return bfile;
--
procedure bfile_proc(in_param in bfile
                     ,out_param out bfile
                     ,out_seqno out number
                     ,in_out_param in out bfile);
--
--
function  blob_func_simpleblob return blob;
--
function  blob_func_newblob return blob;
--
function  blob_func(in_param blob) return blob;
--
procedure blob_proc(in_param in blob
                     ,out_param out blob
                     ,in_out_param in out blob);
--
procedure blob_proc_1(out_param out blob
                     ,out_seqno out number);
--
procedure blob_proc_2(out_param out blob
                     ,in_seqno number);
--
function  clob_func_simpleclob return clob;
--
function  clob_func_getclob(in_param number) return clob;
--
function  clob_func_newclob return clob;
--
function  clob_func(in_param clob) return clob;
--
procedure clob_proc(in_param in clob
                     ,out_param out clob
                     ,in_out_param in out clob);
--
procedure clob_proc_1(out_param out clob
                     ,out_seqno out number);
--
procedure clob_proc_2(out_param out clob
                     ,in_seqno number);
--
function  nclob_func(in_param nclob) return nclob;
--
procedure nclob_proc(in_param in nclob
                     ,out_param out nclob
                     ,in_out_param in out nclob);
--
end;
.
/

show errors;

create or replace package body dbhell.datatype_test
as
function  number_func(in_param number) return number is
--
BEGIN
--
  return(in_param);
--
END;
--
procedure number_proc(in_param in number
                     ,out_param out number
                     ,in_out_param in out number) is
BEGIN
--
  out_param := in_param + in_out_param;
--
END;
--
function  date_func(in_param date) return date is
--
BEGIN
--
  return(in_param);
--
END;
--
procedure date_proc(in_param in date
                   ,out_param out date
                   ,in_out_param in out date) is
BEGIN
--
  out_param := in_out_param + 1;
--
END;
--
function  varchar2_func(in_param varchar2) return varchar2 is
--
BEGIN
--
  IF in_param = 'BREAK' THEN
--
    RAISE_APPLICATION_ERROR
        (-20101, 'BREAK requested');
--
  END IF;
--
  return(in_param);
--
END;
--
procedure varchar2_proc(in_param in varchar2
                       ,out_param out varchar2
                       ,in_out_param in out varchar2) is
BEGIN
--
  out_param := in_param ||  in_out_param;
--
END;
--
function  binary_integer_func(in_param binary_integer) return binary_integer is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure binary_integer_proc(in_param in binary_integer
                     ,out_param out binary_integer
                     ,in_out_param in out binary_integer)
is
BEGIN
--
  out_param := in_param + in_out_param;
--
END;
--
--
function  natural_func(in_param natural) return natural is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure natural_proc(in_param in natural
                     ,out_param out natural
                     ,in_out_param in out natural)
is
BEGIN
--
  out_param := in_param + in_out_param;
--
END;
--
--
function  naturaln_func(in_param naturaln) return naturaln is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure naturaln_proc(in_param in naturaln
--                     ,out_param out naturaln 
                     ,in_out_param in out naturaln)
is
BEGIN
--
  in_out_param := NVL(in_param,0) + NVL(in_out_param,0);
--
END;
--
--
function  positive_func(in_param positive) return positive is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure positive_proc(in_param in positive
                     ,out_param out positive
                     ,in_out_param in out positive)
is
BEGIN
--
  out_param := in_param + in_out_param;
--
END;
--
--
function  positiven_func(in_param positiven) return positiven is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure positiven_proc(in_param in positiven
              --       ,out_param out positiven
                     ,in_out_param in out positiven)
is
BEGIN
--
  in_out_param := in_param + in_out_param;
--
END;
--
--
function  signtype_func(in_param signtype) return signtype is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure signtype_proc(in_param in signtype
                     ,out_param out signtype
                     ,in_out_param in out signtype)
is
BEGIN
--
  out_param := in_param + in_out_param;
--
END;
--
--
function  dec_func(in_param dec) return dec is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure dec_proc(in_param in dec
                     ,out_param out dec
                     ,in_out_param in out dec)
is
BEGIN
--
  out_param := in_param + in_out_param;
--
END;
--
--
function  decimal_func(in_param decimal) return decimal is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure decimal_proc(in_param in decimal
                     ,out_param out decimal
                     ,in_out_param in out decimal)
is
BEGIN
--
  out_param := in_param + in_out_param;
--
END;
--
--
function  double_precision_func(in_param double precision) return double precision is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure double_precision_proc(in_param in double precision
                     ,out_param out double precision
                     ,in_out_param in out double precision)
is
BEGIN
--
  out_param := in_param + in_out_param;
--
END;
--
--
function  float_func(in_param float) return float is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure float_proc(in_param in float
                     ,out_param out float
                     ,in_out_param in out float)
is
BEGIN
--
  out_param := in_param + in_out_param;
--
END;
--
--
function  integer_func(in_param integer) return integer is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure integer_proc(in_param in integer
                     ,out_param out integer
                     ,in_out_param in out integer)
is
BEGIN
--
  out_param := in_param + in_out_param;
--
END;
--
--
function  int_func(in_param int) return int is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure int_proc(in_param in int
                     ,out_param out int
                     ,in_out_param in out int)
is
BEGIN
--
  out_param := in_param + in_out_param;
--
END;
--
--
function  numeric_func(in_param numeric) return numeric is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure numeric_proc(in_param in numeric
                     ,out_param out numeric
                     ,in_out_param in out numeric)
is
BEGIN
--
  out_param := in_param + in_out_param;
--
END;
--
--
--
function  real_func(in_param real) return real is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure real_proc(in_param in real
                     ,out_param out real
                     ,in_out_param in out real)
is
BEGIN
--
  out_param := in_param + in_out_param;
--
END;
--
--
--
function  smallint_func(in_param smallint) return smallint is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure smallint_proc(in_param in smallint
                     ,out_param out smallint
                     ,in_out_param in out smallint)
is
BEGIN
--
  out_param := in_param + in_out_param;
--
END;
--
--
--
function  pls_integer_func(in_param pls_integer) return pls_integer is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure pls_integer_proc(in_param in pls_integer
                     ,out_param out pls_integer
                     ,in_out_param in out pls_integer)
is
BEGIN
--
  out_param := in_param + in_out_param;
--
END;
--
--
--
function  boolean_func(in_param boolean) return boolean is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure boolean_proc(in_param in boolean
                     ,out_param out boolean
                     ,in_out_param in out boolean)
is
BEGIN
--
  out_param := in_param;
--
  if  in_out_param then
--
    out_param := false;
--
  END if;
--
END;
--
--
--
--
function  character_func(in_param character) return character is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure character_proc(in_param in character
                     ,out_param out character
                     ,in_out_param in out character) is
BEGIN
--
  out_param := greatest(in_param,in_out_param);
--
END;
--
--
function  char_func(in_param char) return char is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure char_proc(in_param in char
                     ,out_param out char
                     ,in_out_param in out char) is
BEGIN
--
  out_param := greatest(in_param,in_out_param) ;
--
END;
--
--
function  long_func(in_param long) return long is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure long_proc(in_param in long
                     ,out_param out long
                     ,in_out_param in out long) is
BEGIN
--
  out_param := in_param ||  in_out_param;
--
END;
--
--

function  long_raw_func(in_param long raw) return long raw is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure long_raw_proc(in_param in long raw
                     ,out_param out long raw
                     ,in_out_param in out long raw) is
BEGIN
--
  out_param := in_param ;
--
END;
--
--
function  raw_func(in_param raw) return raw is
--
new_raw raw_example.gifdata%TYPE;
--
BEGIN
--
  IF in_param IS NOT NULL THEN
--
    SELECT gifdata||in_param INTO new_raw
    FROM raw_example
    WHERE name = 'LESLIE2';
-- 
  ELSE
--
    new_raw := in_param;
--
  END IF;
--
RETURN new_raw ;
--
END;
--
--
procedure raw_proc(in_param in raw
                     ,out_param out raw
                     ,in_out_param in out raw) is
BEGIN
--
  out_param := in_param ||  in_out_param;
  in_out_param := in_param;
--
END;
--
--

function  rowid_func(in_param rowid) return rowid is
--
new_rowid ROWID := null;
--
BEGIN
--
--
  IF in_param IS NOT NULL THEN
--
  SELECT min(rowid) INTO new_rowid FROM number_test;
--
  END IF;
--
  RETURN new_rowid;
--
END;
--
--
procedure rowid_proc(in_param in  rowid
                     ,out_param out rowid
                     ,in_out_param in out rowid) is
--
new_rowid ROWID := null;
--
BEGIN
--
  SELECT min(rowid) INTO new_rowid FROM number_test;
--
  SELECT min(rowid) INTO new_rowid 
  FROM  number_test
  WHERE rowid = new_rowid;
--
  out_param := new_rowid;
  in_out_param := new_rowid;
--
END;
--
--

function  urowid_func(in_param urowid) return urowid is
--
new_rowid UROWID := null;
--
BEGIN
--
  IF in_param IS NOT NULL THEN
--
  SELECT min(rowid) INTO new_rowid FROM countries;
--
  END IF;
--
  RETURN new_rowid;
--
END;
--
procedure urowid_proc(in_param in urowid
                     ,out_param out urowid
                     ,in_out_param in out urowid) is
--
new_rowid UROWID := null;
--
BEGIN
--
--
  SELECT min(rowid) INTO new_rowid FROM countries;
--
  SELECT min(rowid) INTO new_rowid
  FROM  countries;
--  WHERE rowid = new_rowid;
--
  out_param := new_rowid;
  in_out_param := new_rowid;
----
END;
--
--

function  string_func(in_param string) return string is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure string_proc(in_param in string
                     ,out_param out string
                     ,in_out_param in out string) is
BEGIN
--
  out_param := in_param ||  in_out_param;
--
END;
--
--

function  varchar_func(in_param varchar) return varchar is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure varchar_proc(in_param in varchar
                     ,out_param out varchar
                     ,in_out_param in out varchar) is
BEGIN
--
  out_param := in_param ||  in_out_param;
--
END;
--
--

function  nchar_func(in_param nchar) return nchar is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure nchar_proc(in_param in nchar
                     ,out_param out nchar
                     ,in_out_param in out nchar) is
BEGIN
--
  out_param := in_param ||  in_out_param;
--
END;
--
--

function  nvarchar2_func(in_param nvarchar2) return nvarchar2 is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure nvarchar2_proc(in_param in nvarchar2
                     ,out_param out nvarchar2
                     ,in_out_param in out nvarchar2) is
BEGIN
--
  out_param := in_param ||  in_out_param;
--
END;
--
--
function  bfile_func(in_param varchar2) return bfile is
-- 
return_value bfile := null;
--
BEGIN
--
  IF in_param IS NOT NULL THEN
--
  SELECT bfiledata
  INTO return_value
  FROM bfile_example
  WHERE name = in_param;
--
  END IF;
--
  return(return_value);
--
END;
--
--
procedure bfile_proc(in_param in bfile
                     ,out_param out bfile
                     ,out_seqno out number
                     ,in_out_param in out bfile) is
--
  new_seqno number := null;
--
BEGIN
--
  SELECT bfile_seq.nextval
  INTO new_seqno
  FROM dual;
--
  INSERT INTO bfile_test
  (seqno, bfile_column)
  VALUES
  (new_seqno,in_param);
--
  out_param := in_param;
  out_seqno := new_seqno;
--
  SELECT bfile_column
  INTO   in_out_param
  FROM   bfile_test b
  WHERE b.seqno = (SELECT max(seqno) FROM bfile_test c);
--
END;
--
--
function  clob_func_getclob(in_param number) return clob IS
--
--
  new_clob clob := null;
  new_seqno number := null;
--
BEGIN
--
  select clob_column
  into new_clob
  from clob_test
  where seqno = in_param
  for update of clob_column NOWAIT;
--
  return(new_clob);
--
end;
--
--
function  clob_func_newclob return clob is
--
  new_clob clob := null;
  new_seqno number := null;
--
BEGIN
--
  select clob_seq.nextval into new_seqno from dual;
--
  insert into clob_test 
  (seqno, clob_column)
  values
  (new_seqno, empty_clob());
--
  select clob_column
  into new_clob
  from clob_test
  where seqno = new_seqno
  for update of clob_column NOWAIT;
--
  return(new_clob);
--
END;
--
--
function  clob_func_simpleclob return clob is
--
  new_clob clob := null;
  new_seqno number := null;
--
BEGIN
--
  select clob_column
  into new_clob
  from clob_test
  where seqno = 0
  for update of clob_column NOWAIT;
--
  return(new_clob);
--
END;
--
--
function  clob_func(in_param clob) return clob is
--
out_param clob;
--
BEGIN
--
  -- out_param := empty_clob();
  -- dbms_lob.copy(out_param,in_param, dbms_lob.getlength(in_param));
  out_param := in_param;
  dbms_lob.append(out_param,in_param);
  return(out_param);
--
END;
--
--
procedure clob_proc_1(out_param out clob
                     ,out_seqno out number) is
--
--
  new_clob clob := null;
  new_seqno number := null;
--
BEGIN
--
  select clob_seq.nextval into new_seqno from dual;
--
  insert into clob_test
  (seqno, clob_column)
  values
  (new_seqno, empty_clob());
--
  select clob_column, seqno
  into out_param, out_seqno
  from clob_test
  where seqno = new_seqno
  for update of clob_column NOWAIT;
--
END;
--
procedure clob_proc_2(out_param out clob
                     ,in_seqno number) is
--
BEGIN
--
  select clob_column
  into out_param
  from clob_test
  where seqno = in_seqno
  for update of clob_column NOWAIT;
--
END;
--
procedure clob_proc(in_param in clob
                     ,out_param out clob
                     ,in_out_param in out clob) is
BEGIN
--
  out_param := in_param;
--
END;
--
--
function  blob_func_newblob return blob is
--
  new_blob blob := null;
  new_seqno number := null;
--
BEGIN
--
  select blob_seq.nextval into new_seqno from dual;
--
  insert into blob_test 
  (seqno, blob_column)
  values
  (new_seqno, empty_blob());
--
  select blob_column
  into new_blob
  from blob_test
  where seqno = new_seqno
  for update of blob_column NOWAIT;
--
  return(new_blob);
--
END;
--
--
function  blob_func_simpleblob return blob is
--
  new_blob blob := null;
  new_seqno number := null;
--
BEGIN
--
  select blob_column
  into new_blob
  from blob_test
  where seqno = 0
  for update of blob_column NOWAIT;
--
  return(new_blob);
--
END;
--
--
function  blob_func(in_param blob) return blob is
--
out_param blob;
--
BEGIN
--
  -- out_param := empty_blob();
  -- dbms_lob.copy(out_param,in_param, dbms_lob.getlength(in_param));
  out_param := in_param;
  dbms_lob.append(out_param,in_param);
  return(out_param);
--
END;
--
--
procedure blob_proc_1(out_param out blob
                     ,out_seqno out number) is
--
--
  new_blob blob := null;
  new_seqno number := null;
--
BEGIN
--
  select blob_seq.nextval into new_seqno from dual;
--
  insert into blob_test
  (seqno, blob_column)
  values
  (new_seqno, empty_blob());
--
  select blob_column, seqno
  into out_param, out_seqno
  from blob_test
  where seqno = new_seqno
  for update of blob_column NOWAIT;
--
END;
--
procedure blob_proc_2(out_param out blob
                     ,in_seqno number) is
--
BEGIN
--
  select blob_column
  into out_param
  from blob_test
  where seqno = in_seqno
  for update of blob_column NOWAIT;
--
END;
--
procedure blob_proc(in_param in blob
                     ,out_param out blob
                     ,in_out_param in out blob) is
BEGIN
--
  out_param := in_param;
--
END;
--
--
function  nclob_func(in_param nclob) return nclob is
--
BEGIN
--
  return(in_param);
--
END;
--
--
procedure nclob_proc(in_param in nclob
                     ,out_param out nclob
                     ,in_out_param in out nclob) is
BEGIN
--
  out_param := in_param;
--
END;
--
--
--
END;
.
/

show errors




