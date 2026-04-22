set echo on
set feedback on
set showmode on

connect synuser/synuser@&1

drop public synonym test_seq_1_pub ;
create public synonym test_seq_1_pub for synuser.test_seq_1;

drop public synonym all_normal_datatypes;
create public synonym all_normal_datatypes for synuser.all_normal_datatypes;

grant select on synuser.all_normal_datatypes to public;

grant select on synuser.all_normal_datatypes_9i to public;


grant execute on synuser.very_simple_function to dbhell;
grant execute on synuser.one_param_function to dbhell;
grant execute on synuser.two_param_function to dbhell;

drop public synonym very_simple_function ;
drop public synonym very_simple_function_pub ;
create public synonym very_simple_function_pub for synuser.very_simple_function ;


grant execute on synuser.synuser_package to dbhell;
grant execute on synuser.two_param_function to dbhell;

drop public synonym suser_generic;
create public synonym suser_generic for synuser.synuser_package;

grant execute on synuser_do_nothing to public; 
drop public synonym sdn;
create public synonym sdn for synuser_do_nothing;

grant execute on synuser_do_something to public;
drop public synonym sds;
create public synonym sds for synuser_do_something;

REM recordtest2 grants

grant select on all_8i_datatypes to public;
grant select on all_9i_datatypes to public;

grant execute on record_test2_8i_lite to public;
grant execute on record_test2b_8i to public;
grant execute on record_test2b_9i to public;
grant execute on record_test2_8i to public;
grant execute on record_test2_9i to public;

grant execute on record_test_2_8i_sal_rt1 to public;
grant execute on record_test_2_8i_sal_rt2 to public;
grant execute on record_test_2_8i_sal_rt3 to public;
grant execute on record_test_2_8i_sal_rt4 to public;
grant execute on record_test_2_8i_sal_rt5 to public;

grant execute on record_test_2_9i_sal_rt1 to public;
grant execute on record_test_2_9i_sal_rt2 to public;
grant execute on record_test_2_9i_sal_rt3 to public;
grant execute on record_test_2_9i_sal_rt4 to public;
grant execute on record_test_2_9i_sal_rt5 to public;



DROP PUBLIC SYNONYM pubsyn_record_test2b_8i;
DROP PUBLIC SYNONYM pubsyn_record_test2b_9i;
DROP PUBLIC SYNONYM pubsyn_record_test2_8i_lite;
DROP PUBLIC SYNONYM pubsyn_record_test2_8i;
DROP PUBLIC SYNONYM pubsyn_record_test2_9i;
DROP PUBLIC SYNONYM pubsyn_record_test_2_8i_sal_rt1;
DROP PUBLIC SYNONYM pubsyn_record_test_2_8i_sal_rt2;
DROP PUBLIC SYNONYM pubsyn_record_test_2_8i_sal_rt3;
DROP PUBLIC SYNONYM pubsyn_record_test_2_8i_sal_rt4;
DROP PUBLIC SYNONYM pubsyn_record_test_2_8i_sal_rt5;
DROP PUBLIC SYNONYM pubsyn_record_test_2_9i_sal_rt1;
DROP PUBLIC SYNONYM pubsyn_record_test_2_9i_sal_rt2;
DROP PUBLIC SYNONYM pubsyn_record_test_2_9i_sal_rt3;
DROP PUBLIC SYNONYM pubsyn_record_test_2_9i_sal_rt4;
DROP PUBLIC SYNONYM pubsyn_record_test_2_9i_sal_rt5;
DROP PUBLIC SYNONYM pubsyn_rectest2_8itype;
DROP PUBLIC SYNONYM pubsyn_rectest2_9itype;

CREATE PUBLIC SYNONYM pubsyn_record_test2b_8i FOR record_test2b_8i;
CREATE PUBLIC SYNONYM pubsyn_record_test2b_9i FOR record_test2b_9i;
CREATE PUBLIC SYNONYM pubsyn_record_test2_8i_lite FOR record_test2_8i_lite;
CREATE PUBLIC SYNONYM pubsyn_record_test2_8i FOR record_test2_8i;
CREATE PUBLIC SYNONYM pubsyn_record_test2_9i FOR record_test2_9i;
CREATE PUBLIC SYNONYM pubsyn_record_test_2_8i_sal_rt1 FOR record_test_2_8i_sal_rt1;
CREATE PUBLIC SYNONYM pubsyn_record_test_2_8i_sal_rt2 FOR record_test_2_8i_sal_rt2;
CREATE PUBLIC SYNONYM pubsyn_record_test_2_8i_sal_rt3 FOR record_test_2_8i_sal_rt3;
CREATE PUBLIC SYNONYM pubsyn_record_test_2_8i_sal_rt4 FOR record_test_2_8i_sal_rt4;
CREATE PUBLIC SYNONYM pubsyn_record_test_2_8i_sal_rt5 FOR record_test_2_8i_sal_rt5;
CREATE PUBLIC SYNONYM pubsyn_record_test_2_9i_sal_rt1 FOR record_test_2_9i_sal_rt1;
CREATE PUBLIC SYNONYM pubsyn_record_test_2_9i_sal_rt2 FOR record_test_2_9i_sal_rt2;
CREATE PUBLIC SYNONYM pubsyn_record_test_2_9i_sal_rt3 FOR record_test_2_9i_sal_rt3;
CREATE PUBLIC SYNONYM pubsyn_record_test_2_9i_sal_rt4 FOR record_test_2_9i_sal_rt4;
CREATE PUBLIC SYNONYM pubsyn_record_test_2_9i_sal_rt5 FOR record_test_2_9i_sal_rt5;
CREATE PUBLIC SYNONYM pubsyn_rectest2_8itype FOR rectest2_8itype;
CREATE PUBLIC SYNONYM pubsyn_rectest2_9itype FOR rectest2_9itype;


exit



