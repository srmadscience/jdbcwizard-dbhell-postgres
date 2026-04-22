insert into exchange_rates
select 'EUR','EUR',rate_date,1
from exchange_rates r
where from_currency = 'GBP'
and  not exists (select null 
                 from exchange_rates r2
                 where from_currency = 'EUR'
                 and   to_currency = 'EUR'
                 and   rate_date = r.rate_date) 
/


