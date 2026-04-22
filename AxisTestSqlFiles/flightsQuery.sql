select  *
from flights
where rownum < &howmany /* Number */
/
