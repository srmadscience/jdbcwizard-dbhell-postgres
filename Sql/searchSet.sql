set define '^'

create or replace function search_set(p_string varchar2) return varchar2 as
--
  mapped_string varchar2(1024);
--
BEGIN
--
  mapped_string := p_string;
--
  BEGIN
--
  mapped_string := UTL_URL.UNESCAPE(lower(p_string));
--
  IF mapped_string LIKE 'http://%search.yahoo.com/%search%' THEN
--
    IF greatest(instr(mapped_string, '?p='),instr(mapped_string, '&p=')) > 0 THEN
--
      mapped_string := substr(mapped_string, greatest(instr(mapped_string, '?p='),instr(mapped_string, '&p=')) +3);
--
    END IF;
--
  ELSIF mapped_string LIKE '%google%syndication%' THEN
--
    IF greatest( instr(mapped_string, '&url=')
                ,instr(mapped_string, '&url=')
                                          ) > 0 THEN
--
      mapped_string := substr(mapped_string,greatest( instr(mapped_string, '?url=')
              ,instr(mapped_string, '&url=')
                                          ) +5);
--
    END IF;
--
  ELSIF mapped_string LIKE '%search%' THEN
--
    IF greatest( instr(mapped_string, '?q=')
                ,instr(mapped_string, '&q=')
                                          ) > 0 THEN
--
      mapped_string := substr(mapped_string,greatest( instr(mapped_string, '?q=')
              ,instr(mapped_string, '&q=')
                                          ) +3);
--
    END IF;
--
    IF greatest( instr(mapped_string, '?as_q=')
              ,instr(mapped_string, '&as_q=')
                                          ) > 0 THEN
--
      mapped_string := substr(mapped_string,greatest(
               instr(mapped_string, '?as_q=')
              ,instr(mapped_string, '&as_q=')
                                          ) +5);
--
    END IF;
--

  END IF;
--
  IF instr(mapped_string, '&') > 3 THEN
--
    mapped_string := substr(mapped_string,1,instr(mapped_string, '&')-1);
--
  END IF;
--
  EXCEPTION WHEN OTHERS THEN
--
  mapped_string := sqlerrm; -- p_string;
--
  END;
--
RETURN (mapped_string);
--
END;
.
/

show errors

set define &

A
select request_referrer, search_set(request_referrer)
from osoft_rawlog
where request_referrer like '%google%search%'
and   request_referrer not like '%googlesyndication%'
and hit_datetime > ( sysdate - 10)
group by request_referrer, search_set(request_referrer)
/


