set echo on
set feedback on
set showmode on

connect dbhell/dbhell@&1

create synonym test_seq_1_priv_syn for test_seq_1;

create synonym suser_generic_from_dbhell for synuser.synuser_package;
create synonym suser_2 for synuser.two_param_function;

create synonym suser_do_zilch for synuser.synuser_do_nothing;
create synonym suser_do_something for synuser.synuser_do_something;



CREATE SYNONYM syn_record_test2b_8i FOR synuser.record_test2b_8i;
CREATE SYNONYM syn_record_test2b_9i FOR synuser.record_test2b_9i;
CREATE SYNONYM syn_record_test2_8i FOR synuser.record_test2_8i;
CREATE SYNONYM syn_record_test2_8i_lite FOR synuser.record_test2_8i_lite;
CREATE SYNONYM syn_record_test2_9i FOR synuser.record_test2_9i;
CREATE SYNONYM syn_record_test_2_8i_sal_rt1 FOR synuser.record_test_2_8i_sal_rt1;
CREATE SYNONYM syn_record_test_2_8i_sal_rt2 FOR synuser.record_test_2_8i_sal_rt2;
CREATE SYNONYM syn_record_test_2_8i_sal_rt3 FOR synuser.record_test_2_8i_sal_rt3;
CREATE SYNONYM syn_record_test_2_8i_sal_rt4 FOR synuser.record_test_2_8i_sal_rt4;
CREATE SYNONYM syn_record_test_2_8i_sal_rt5 FOR synuser.record_test_2_8i_sal_rt5;
CREATE SYNONYM syn_record_test_2_9i_sal_rt1 FOR synuser.record_test_2_9i_sal_rt1;
CREATE SYNONYM syn_record_test_2_9i_sal_rt2 FOR synuser.record_test_2_9i_sal_rt2;
CREATE SYNONYM syn_record_test_2_9i_sal_rt3 FOR synuser.record_test_2_9i_sal_rt3;
CREATE SYNONYM syn_record_test_2_9i_sal_rt4 FOR synuser.record_test_2_9i_sal_rt4;
CREATE SYNONYM syn_record_test_2_9i_sal_rt5 FOR synuser.record_test_2_9i_sal_rt5;
CREATE SYNONYM syn_rectest2_8itype FOR synuser.rectest2_8itype;
CREATE SYNONYM syn_rectest2_9itype FOR synuser.rectest2_9itype;


exit



