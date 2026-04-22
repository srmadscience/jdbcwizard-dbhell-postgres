SELECT *
FROM   flights f
/* Because we give both parameters the same name the generated code
   will have one parameter which it uses twice. */
WHERE  departure_city = ? /* city string */
OR     arrival_city   = ? /* city String */
ORDER BY departure_time