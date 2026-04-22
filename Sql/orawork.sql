CREATE OR REPLACE PACKAGE workdays AS
   /*
   ||  WORKDAYS Package
   ||
   ||  (c) 1999  Chris Hunt, Extra Connections Ltd
   ||
   ||  This code is made freely available for use in both private and commercial
   ||  applications.
   ||
   ||  Whilst every effort has been made to ensure these routines operates accurately
   ||  and properly, no liability will be accepted for any problems they may cause on
   ||  your system.
   ||
   ||  This package was written and tested on Oracle 7.3.2, but should work on any
   ||  version 7+ database.
   ||
   ||  The latest version of this file (and other goodies) can be found at
   ||  http://www.foobar.co.uk/dialin/chunt
   ||
   ||  ========
   ||  Overview
   ||  ========
   ||
   ||  This package contains a number of functions which manipulate date values with
   ||  regard to "working days".
   ||
   ||  For the purposes of this package working days are Monday to Friday inclusive, 
   ||  Saturday and Sunday are not working days. Users with a different week pattern
   ||  will need to amend the code accordingly. In addition, different values of 
   ||  parameter NLS_TERRITORY can give rise to different values for the first day
   ||  of the week (see the Oracle7 Server Reference Manual). This package expects
   ||  Sunday to be day number 1. If your settings are different change the constant
   ||  day_adj as directed in the code.
   ||
   ||  No account is taken by this package of holidays, fixed or otherwise. If you
   ||  need to deal with them, you'll have to write the appropriate code.
   ||
   ||  All the functions defined here have the necessary "purity level" to be used
   ||  in SQL SELECT and WHERE clauses as well as PL/SQL.
   ||
   ||  ====================
   ||  Function Definitions
   ||  ====================
   ||
   ||  add_workdays (date, days)   Adds a number of working days (positive or negative)
   ||                              to the specified date. If zero days are added to a
   ||                              Saturday or Sunday, the Monday following is returned.
   ||                              Thus add_workdays(mydate,0) will always be a working
   ||                              day.
   ||
   ||  workdays_between (from, to) Calculates the number of working days between the
   ||                              specified dates. If "to" comes before "from", this
   ||                              value will be negative. Note that if the dates include
   ||                              a time component, the returned value will include a
   ||                              fraction. TRUNC() the dates if you don't want this.
   ||
   ||  first_workday (date, unit)  Returns the first working day in the time unit
   ||                              containing the specified date (similar to the Oracle
   ||                              TRUNC and ROUND functions for dates). Possible units
   ||                              are:
   ||
   ||                                 Century:  CC, SSC, C or CENTURY
   ||                                 Year:     YYYY, SYYYY, YYY, YY, Y, YEAR, SYEAR or RR
   ||                                 ISO Year: IYYY, IYY, IY OR I
   ||                                 Quarter:  Q or QUARTER
   ||                                 Month:    MONTH, MON, MM, M or RM
   ||                                 Week      WEEK, WW or W
   ||
   ||                              None of these values are case sensitive
   ||
   ||  last_workday (date, unit)   Returns the last working day in the time unit
   ||                              containing the specified date. Possible units are
   ||                              the same as listed above.
   ||
   ||  next_workday (date)         Returns the next working day after the specified date
   ||
   ||  prev_workday (date)         Returns the working day previous to the specified date
   ||
   */
   FUNCTION add_workdays (p_date IN DATE,
                          p_workdays IN NUMBER) RETURN DATE;
   PRAGMA RESTRICT_REFERENCES (add_workdays, WNDS, WNPS);
   --
   FUNCTION workdays_between (p_from IN DATE,
                              p_to   IN DATE) RETURN NUMBER;
   PRAGMA RESTRICT_REFERENCES (workdays_between, WNDS, WNPS);
   --
   FUNCTION first_workday (p_date IN DATE,
                           p_unit IN VARCHAR2 := 'MON') RETURN DATE;
   PRAGMA RESTRICT_REFERENCES (first_workday, WNDS, WNPS);
   --
   FUNCTION last_workday (p_date IN DATE,
                          p_unit IN VARCHAR2 := 'MON') RETURN DATE;
   PRAGMA RESTRICT_REFERENCES (last_workday, WNDS, WNPS);
   --
   FUNCTION next_workday (p_date IN DATE) RETURN DATE;
   PRAGMA RESTRICT_REFERENCES (next_workday, WNDS, WNPS);
   --
   FUNCTION prev_workday (p_date IN DATE) RETURN DATE;
   PRAGMA RESTRICT_REFERENCES (prev_workday, WNDS, WNPS);
END workdays;
/

CREATE OR REPLACE PACKAGE BODY workdays AS
   /*
   ||  WORKDAYS Package Body
   ||
   ||  (c) 1999  Chris Hunt, Extra Connections Ltd
   ||
   ||  This code is made freely available for use in both private and commercial
   ||  applications.
   ||
   ||  Whilst every effort has been made to ensure these routines operates accurately
   ||  and properly, no liability will be accepted for any problems they may cause on
   ||  your system.
   ||
   ||  Please consult the package header for full details of this package.
   ||
   ||  The latest version of this file (and other goodies) can be found at
   ||  http://www.foobar.co.uk/dialin/chunt
   ||
   */
   century_formats   CONSTANT VARCHAR2(50) := '|CC|SSC|CENTURY|C|';
   year_formats      CONSTANT VARCHAR2(50) := '|YYYY|SYYYY|YYY|YY|Y|YEAR|SYEAR|RR|';
   iso_year_formats  CONSTANT VARCHAR2(50) := '|IYYY|IYY|IY|I|';
   quarter_formats   CONSTANT VARCHAR2(50) := '|Q|QUARTER|';
   month_formats     CONSTANT VARCHAR2(50) := '|MONTH|MON|MM|RM|M|';
   week_formats      CONSTANT VARCHAR2(50) := '|WEEK|WW|W|';
   --
   -- day_adj is the number of days between the first day of the week, as defined by
   -- NLS_TERRITORY, and the first working day of the week. In the UK & US this is
   -- the difference between Sun and Mon, i.e. 1 day. If oracle starts your week on
   -- Monday, this value should be zero.
   --
   day_adj           CONSTANT NUMBER := 1;
   --
   FUNCTION add_workdays (p_date IN DATE,
                          p_workdays IN NUMBER) RETURN DATE IS
      weeks     NUMBER;
      days      NUMBER;
      startday  NUMBER;
      BEGIN
      --
      -- Convert p_workdays into a number of whole weeks and the remainder of days
      --
      weeks := TRUNC(p_workdays / 5);
      days  := MOD  (p_workdays,5);
      --
      -- Adjust accordingly if the odd days cross the weekend
      --
      startday := TO_NUMBER(TO_CHAR(p_date - day_adj,'D'));
      IF days = 0 THEN
         --
         -- If starting from a Sat or Sun, move on to the next Monday
         --
         IF startday > 5 THEN
            days := 8 - startday;
         END IF;
      ELSIF days > 0 THEN
         --
         -- If starting from a Saturday, move on to the Sunday
         --
         IF startday = 6 THEN
            days := days + 1;
         END IF;
         --
         -- If finishing in or beyond the weekend, add 2 days to compensate
         --
         IF startday + days > 5 AND startday < 6 THEN
            days := days + 2;
         END IF;
      ELSE          -- days < 0
         --
         -- If starting from a Sunday, move back to the Saturday
         --
         IF startday = 7 THEN
            days := days - 1;
         END IF;
         --
         -- If finishing in or before the weekend, subtract a further 2 days to compensate
         --
         IF startday + days < 1  AND startday < 6 THEN
            days := days - 2;
         END IF;
      END IF;
      --
      RETURN p_date + (weeks * 7) + days;
   END;
   --
   FUNCTION workdays_between (p_from IN DATE,
                              p_to   IN DATE) RETURN NUMBER IS
      first_date   DATE;
      last_date    DATE;
      weeks        NUMBER;
      days         NUMBER;
   BEGIN
      --
      -- from and to dates might be in any order, find the first and last 
      --
      first_date := LEAST(p_from,p_to);
      last_date  := GREATEST(p_from,p_to);
      --
      -- Move first and last dates to the nearest working day
      --
      first_date := add_workdays(first_date,0);
      last_date  := add_workdays(last_date,0);
      --
      -- Work out weeks and days between the two dates
      --
      weeks := TRUNC((last_date - first_date)/7);
      days  := MOD((last_date - first_date),7);
      --
      IF TO_NUMBER(TO_CHAR(last_date  - day_adj,'D')) 
       < TO_NUMBER(TO_CHAR(first_date - day_adj,'D')) THEN
         days := days - 2;
      END IF;
      --
      RETURN ((weeks * 5) + days) * SIGN(p_to - p_from);
   END;
   --
   FUNCTION first_workday (p_date IN DATE,
                           p_unit IN VARCHAR2 := 'MON') RETURN DATE IS
      first_day   DATE;
      bad_format  EXCEPTION;
      PRAGMA EXCEPTION_INIT (bad_format,-1821);
   BEGIN
      IF INSTR(month_formats, '|'||UPPER(p_unit)||'|') > 0 THEN
         first_day := TRUNC (p_date, 'MON');
      ELSIF INSTR(week_formats, '|'||UPPER(p_unit)||'|') > 0 THEN
         first_day := TRUNC (p_date, 'DAY');  -- Weirdly, this truncates to the start of week
      ELSIF INSTR(quarter_formats, '|'||UPPER(p_unit)||'|') > 0 THEN
         first_day := TRUNC (p_date, 'Q');
      ELSIF INSTR(year_formats, '|'||UPPER(p_unit)||'|') > 0 THEN
         first_day := TRUNC (p_date, 'YYYY');
      ELSIF INSTR(iso_year_formats, '|'||UPPER(p_unit)||'|') > 0 THEN
         first_day := TRUNC (p_date, 'IYYY');
      ELSIF INSTR(century_formats, '|'||UPPER(p_unit)||'|') > 0 THEN
         first_day := TRUNC (p_date, 'CC');
      ELSE
         RAISE bad_format;
      END IF;

      RETURN workdays.add_workdays (first_day,0);
   EXCEPTION
      WHEN bad_format THEN
         RETURN NULL;
   END;
   --
   FUNCTION last_workday (p_date IN DATE,
                           p_unit IN VARCHAR2 := 'MON') RETURN DATE IS
      first_day   DATE;
      bad_format  EXCEPTION;
      PRAGMA EXCEPTION_INIT (bad_format,-1821);
   BEGIN
      --
      -- Find the first day of the NEXT specified unit
      --
      IF INSTR(month_formats, '|'||UPPER(p_unit)||'|') > 0 THEN
         first_day := ADD_MONTHS(TRUNC (p_date, 'MON'),1);
      ELSIF INSTR(week_formats, '|'||UPPER(p_unit)||'|') > 0 THEN
         first_day := TRUNC (p_date, 'DAY') + 7;
      ELSIF INSTR(quarter_formats, '|'||UPPER(p_unit)||'|') > 0 THEN
         first_day := ADD_MONTHS(TRUNC (p_date, 'Q'),3);
      ELSIF INSTR(year_formats, '|'||UPPER(p_unit)||'|') > 0 THEN
         first_day := ADD_MONTHS(TRUNC (p_date, 'YYYY'),12);
      ELSIF INSTR(iso_year_formats, '|'||UPPER(p_unit)||'|') > 0 THEN
         first_day := TRUNC (ADD_MONTHS(p_date,12), 'IYYY');
      ELSIF INSTR(century_formats, '|'||UPPER(p_unit)||'|') > 0 THEN
         first_day := ADD_MONTHS(TRUNC (p_date, 'CC'),1200);
      ELSE
         RAISE bad_format;
      END IF;
      --
      -- The last working day will be the working day BEFORE the day found above
      --
      RETURN workdays.add_workdays (first_day,-1);
   EXCEPTION
      WHEN bad_format THEN
         RETURN NULL;
   END;
   --
   FUNCTION next_workday (p_date IN DATE) RETURN DATE IS
   BEGIN
      RETURN add_workdays(P_date,1);
   END;
   --
   FUNCTION prev_workday (p_date IN DATE) RETURN DATE IS
   BEGIN
      RETURN add_workdays(P_date,-1);
   END;
END workdays;
/

   
   
