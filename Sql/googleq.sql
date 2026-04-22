select replace(lower(substr(substr(request_referrer,instr(request_referrer,'?'),instr(request_referrer,'&')-instr(request_referrer,'?')),4)),'%2f','/'), count(*)
from osoft_rawlog
where request_referrer like '%google%search?q=%'
group by replace(lower(substr(substr(request_referrer,instr(request_referrer,'?'),instr(request_referrer,'&')-instr(request_referrer,'?')),4
)),'%2f','/')
order by count(*)
/
