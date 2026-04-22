drop table exchange_rates;

create table exchange_rates(from_currency varchar2(3)
                           ,to_currency   varchar2(3)
                           ,rate_date     date
                           ,rate_value    number(10,7)
                           ,constraint xrate_pk PRIMARY KEY(from_currency, to_currency, rate_date)
                                                USING INDEX tablespace osoft
                           ,constraint	xrate_day check (rate_date = trunc(rate_date))
)
tablespace osoft;



                           
