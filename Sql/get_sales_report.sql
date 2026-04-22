set feedback 0
set heading off
set pages 0
set lines 1024

spool sales_report.lst
 
select a_row
from sales_view_colon_xrate
order by hit_datetime;

spool off

exit



