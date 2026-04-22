
set echo on
set feedback on
set showmode on

connect system/manager@&1


grant connect, resource,dba to fitab identified by fitab;

connect fitab/fitab@&1

drop table fitab;

create table fitab
(varchar2_column varchar2(100)
,date_column     date
,number_column   number);

insert into fitab
values
('A String',to_date('01-jan-2004 12:43:00','DD-MON-YYYY HH24:MI:SS')
,43.3);

create index fitab_string on fitab
(upper(varchar2_column)
,date_column
,number_column);

create index fitab_string_short on fitab
(upper(varchar2_column));

create index fitab_date on fitab
(varchar2_column
,trunc(date_column)
,number_column);

create index fitab_number on fitab
(varchar2_column
,date_column
,trunc(number_column));

create index itab_all on fitab
(upper(varchar2_column)
,trunc(date_column)
,trunc(number_column));

grant select on fitab to dbhell;

exit
