create table dbhell.nasty_key
(keycol1 number
,keycol2 date
,keycol3 varchar2(100)
,keycol4 number)
/

alter table dbhell.nasty_key add (constraint nasty_pk primary key 
(keycol1,keycol2,keycol3,keycol4));

alter table dbhell.nasty_key
add
(a_date date
,a_number number
,a_varchar2 varchar2(100)
,a_char    char(100));

grant all on dbhell.nasty_key to public;

create table dbhell.nasty_long
(a_keycol1 number
,a_keycol2 date
,a_keycol3 varchar2(100)
,a_keycol4 number
,b_keycol1 number
,b_keycol2 date
,b_keycol3 varchar2(100)
,b_keycol4 number
,a_long long)
/

alter table dbhell.nasty_long add (constraint nasty_long_pk primary key 
(a_keycol1,a_keycol2,a_keycol3,a_keycol4,b_keycol1,b_keycol2,b_keycol3,b_keycol4));


ALTER TABLE dbhell.nasty_long
       ADD  ( CONSTRAINT nlk_1 
              FOREIGN KEY (a_keycol1 ,a_keycol2 ,a_keycol3 ,a_keycol4)
              REFERENCES nasty_key
              ON DELETE CASCADE ) ;

ALTER TABLE dbhell.nasty_long
       ADD  ( CONSTRAINT nlk_2 
              FOREIGN KEY (b_keycol1 ,b_keycol2 ,b_keycol3 ,b_keycol4)
              REFERENCES nasty_key
              ON DELETE CASCADE ) ;


create table dbhell.nasty_long_raw
(a_keycol1 number
,a_keycol2 date
,a_keycol3 varchar2(100)
,a_keycol4 number
,b_keycol1 number
,b_keycol2 date
,b_keycol3 varchar2(100)
,b_keycol4 number
,a_raw raw(100)
,a_long long raw)
/

alter table dbhell.nasty_long_raw add (constraint nasty_long_raw_pk primary key
(a_keycol1,a_keycol2,a_keycol3,a_keycol4,b_keycol1,b_keycol2,b_keycol3,b_keycol4));


ALTER TABLE dbhell.nasty_long_raw
       ADD  ( CONSTRAINT nlr_1
              FOREIGN KEY (a_keycol1 ,a_keycol2 ,a_keycol3 ,a_keycol4)
              REFERENCES nasty_key
              ON DELETE CASCADE ) ;

ALTER TABLE dbhell.nasty_long_raw
       ADD  ( CONSTRAINT nlr_2
              FOREIGN KEY (b_keycol1 ,b_keycol2 ,b_keycol3 ,b_keycol4)
              REFERENCES nasty_key
              ON DELETE CASCADE ) ;

create table dbhell.nasty_lob
(a_keycol1 number
,a_keycol2 date
,a_keycol3 varchar2(100)
,a_keycol4 number
,b_keycol1 number
,b_keycol2 date
,b_keycol3 varchar2(100)
,b_keycol4 number
,a_clob    clob
,a_blob    blob
,a_bfile   bfile)
/

alter table dbhell.nasty_lob add (constraint nasty_lob_pk primary key
(a_keycol1,a_keycol2,a_keycol3,a_keycol4,b_keycol1,b_keycol2,b_keycol3,b_keycol4));


ALTER TABLE dbhell.nasty_lob
       ADD  ( CONSTRAINT nlb_1
              FOREIGN KEY (a_keycol1 ,a_keycol2 ,a_keycol3 ,a_keycol4)
              REFERENCES nasty_key
              ON DELETE CASCADE ) ;

ALTER TABLE dbhell.nasty_lob
       ADD  ( CONSTRAINT nlb_2
              FOREIGN KEY (b_keycol1 ,b_keycol2 ,b_keycol3 ,b_keycol4)
              REFERENCES nasty_key
              ON DELETE CASCADE ) ;

create view vw_nasty_key 
as
select 
keycol2
,keycol3 
,keycol4 
from dbhell.nasty_key
/
