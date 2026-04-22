drop database link db815_link;
create database link db815_link connect to dbhell identified by dbhell using 'DB815';

create synonym db815_do_nothing for do_nothing@db815_link;
create synonym db815_two_param_function for two_param_function@db815_link;


