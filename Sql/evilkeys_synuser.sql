

create table synuser.nasty_key_synuser
(keycol1 number
,keycol2 date
,keycol3 varchar2(100)
,keycol4 number)
/

alter table synuser.nasty_key_synuser add (constraint nasty_pk primary key 
(keycol1,keycol2,keycol3,keycol4));

create table synuser.nasty_long_synuser
(a_keycol1 number
,a_keycol2 date
,a_keycol3 varchar2(100)
,a_keycol4 number
,b_keycol1 number
,b_keycol2 date
,b_keycol3 varchar2(100)
,b_keycol4 number
,a_long long
,a_string varchar2(100))
/

alter table synuser.nasty_long_synuser add (constraint nasty_long_pk primary key
(a_keycol1,a_keycol2,a_keycol3,a_keycol4,b_keycol1,b_keycol2,b_keycol3,b_keycol4));


ALTER TABLE synuser.nasty_long_synuser
       ADD  ( CONSTRAINT nlk_1
              FOREIGN KEY (a_keycol1 ,a_keycol2 ,a_keycol3 ,a_keycol4)
              REFERENCES dbhell.nasty_key
              ON DELETE CASCADE ) ;

ALTER TABLE synuser.nasty_long_synuser
       ADD  ( CONSTRAINT nlk_2
              FOREIGN KEY (b_keycol1 ,b_keycol2 ,b_keycol3 ,b_keycol4)
              REFERENCES synuser.nasty_key_synuser
              ON DELETE CASCADE ) ;

create public synonym pub_nasty_key_synuser for nasty_key_synuser;
grant all on nasty_key to public;

create public synonym pub_nasty_long_synuser for nasty_long_synuser;
grant all on nasty_long_synuser to public;

create table synuser.nast_long_synuser_privsyn
(a_keycol1 number
,a_keycol2 date
,a_keycol3 varchar2(100)
,a_keycol4 number
,b_keycol1 number
,b_keycol2 date
,b_keycol3 varchar2(100)
,b_keycol4 number
,a_long long
,a_string varchar2(100))
/

alter table synuser.nast_long_synuser_privsyn add (constraint nasty_long_synunser_privsyn_pk 
primary key 
(a_keycol1,a_keycol2,a_keycol3,a_keycol4,b_keycol1,b_keycol2,b_keycol3,b_keycol4));


ALTER TABLE synuser.nast_long_synuser_privsyn
       ADD  ( CONSTRAINT nlk_1ps 
              FOREIGN KEY (a_keycol1 ,a_keycol2 ,a_keycol3 ,a_keycol4)
              REFERENCES dbhell.nasty_key
              ON DELETE CASCADE ) ;

ALTER TABLE synuser.nast_long_synuser_privsyn
       ADD  ( CONSTRAINT nlk_2ps 
              FOREIGN KEY (b_keycol1 ,b_keycol2 ,b_keycol3 ,b_keycol4)
              REFERENCES synuser.nasty_key_synuser
              ON DELETE CASCADE ) ;


grant all on nast_long_synuser_privsyn to public;


create table synuser.nast_long_synuser_nosyn
(a_keycol1 number
,a_keycol2 date
,a_keycol3 varchar2(100)
,a_keycol4 number
,b_keycol1 number
,b_keycol2 date
,b_keycol3 varchar2(100)
,b_keycol4 number
,a_long long
,a_string varchar2(100))
/

alter table synuser.nast_long_synuser_nosyn add (constraint nasty_long_synunser_nosyn_pk 
primary key
(a_keycol1,a_keycol2,a_keycol3,a_keycol4,b_keycol1,b_keycol2,b_keycol3,b_keycol4));


ALTER TABLE synuser.nast_long_synuser_nosyn
       ADD  ( CONSTRAINT nlk_1ns
              FOREIGN KEY (a_keycol1 ,a_keycol2 ,a_keycol3 ,a_keycol4)
              REFERENCES dbhell.nasty_key
              ON DELETE CASCADE ) ;

ALTER TABLE synuser.nast_long_synuser_nosyn
       ADD  ( CONSTRAINT nlk_2ns
              FOREIGN KEY (b_keycol1 ,b_keycol2 ,b_keycol3 ,b_keycol4)
              REFERENCES synuser.nasty_key_synuser
              ON DELETE CASCADE ) ;


grant all on nast_long_synuser_nosyn to public;


create view vw_nasty_key 
as
select 
keycol2
,keycol3 
,keycol4 
from synuser.nasty_key_synuser
/

grant select on vw_nasty_key to public;

exit


