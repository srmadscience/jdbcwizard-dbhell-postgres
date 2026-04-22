UPDATE CUSTOMERS
/* parameters can be specified using either the '?' JDBC syntax or the ampersand syntax
   that is used in SQL*Plus. Note that '' characters on either side of a parameter will 
   be removed, as will any trailing semi-colons or slashes at the end of the statement */
SET address   = NVL('&address',address)  /* string */
  , city      = NVL('&city',city)        /* string */
  , state     = NVL('&state',state)      /* string */
  , zip       = NVL(&zip,zip)            /* number */
  , birthdate = NVL('&bdate', birthdate) /* date */
  , phone     = NVL('&phone',phone)      /* string */
where name = '&name' /*  String */
/



