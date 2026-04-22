create table nullandsize
(seqno number(1) not null
,a_mand_textcol varchar2(100) not null
,an_optional_numcol number
,a_mand_numcol_noplaces number(2) not null
,a_mand_numcol_3places number (6,3) not null
,a_mand_numcol_thousands number(10,-3) not null
,a_mand_datecol date not null
,a_clobcol clob null 
,a_raw raw(100) null
,a_raw_mand raw(50) not null) 
tablespace dbhell;


alter table nullandsize
add
(constraint nas_index0 primary key
(seqno) using index tablespace dbhell);

