
CREATE OR REPLACE FUNCTION McInitcap (name IN VARCHAR2) RETURN VARCHAR2 IS
BEGIN
   RETURN REPLACE(LTRIM(INITCAP(' '||REPLACE(UPPER(name),' MC',' MC~'))),'~','');
END McInitcap;
/

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
   -- NLS_TERRITORY, and the first working day of the week. In the UK  US this is
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

   
CREATE OR REPLACE PACKAGE converter AS
   /*
   ||  CONVERTER Package
   ||
   ||  (c) 1999  Chris Hunt, Extra Connections Ltd
   ||
   ||  This code is made freely available for use in both private and commercial
   ||  applications.
   ||
   ||  Whilst every effort has been made to ensure these routines operate
   ||  accurately and properly, no liability will be accepted for any problems
   ||  they may cause on your system.
   ||
   ||  This package was written and tested on Oracle 7.3.2, but should work on
   ||  any version 7+ database.
   ||
   ||  The latest version of this file (and other goodies) can be found at
   ||  http://www.extracon.com
   ||
   ||  ========
   ||  Overview
   ||  ========
   ||
   ||  This package contains a set of functions which convert numbers between
   ||  different bases. The functions cope with any base up to and including
   ||  base 36.
   ||
   ||  The package expects numbers passed to it to be positive integers, any
   ||  sign and/or decimal part will be removed before conversion begins.
   ||  Conversely, no assumptions are made about particular bits marking a
   ||  number as negative - all numbers are converted to their positive
   ||  equivalents.
   ||
   ||  Decimal values are expressed and accepted as NUMBERs, other bases use
   ||  data type VARCHAR2. This is because, for bases in excess of base 10,
   ||  capital letters are used as digits (This is why the upper limit is
   ||  base 36 - 10 digits + 26 letters).
   ||
   ||  ====================
   ||  Function Definitions
   ||  ====================
   ||
   ||  basen_to_dec (number, base)           Converts a number (held in a
   ||                                        character string) from the
   ||                                        specified base into its decimal
   ||                                        equivalent. If any unexpected
   ||                                        characters (including minus signs  
   ||                                        decimal points) are encountered, an
   ||                                        "invalid number" error is raised.
   ||                                        If base is more than 36 an
   ||                                        "argument out of range" error is
   ||                                        raised.
   ||
   ||  dec_to_basen (number, base)           Converts a decimal number into the
   ||                                        specified base. Typical choices for
   ||                                        base would be 2 (binary), 8 (octal) 
   ||                                        and 16 (hexadecimal). A negative
   ||                                        sign or decimal part in either
   ||                                        parameter will be ignored. If base
   ||                                        is more than 36 an "argument out of
   ||                                        range" error is raised.
   ||
   ||  basen_to_basem (number, basen, basem) Converts a number (expressed as a
   ||                                        string) from one base to another.
   ||                                        The same limits apply as are shown
   ||                                        above.
   ||
   || ========
   || Examples
   || ========
   ||
   || converter.basen_to_dec ('100110',2)    Returns the decimal equivalent of
   ||                                        binary number 100110, i.e. 38.
   ||
   || converter.dec_to_basen (123,16)        Returns the number 123 expressed in
   ||                                        hexadecimal, i.e. '7B'.
   ||
   || converter.basen_to_basem ('110',8,2)   Returns the binary version of the
   ||                                        octal number 110 (72 decimal),
   ||                                        i.e. 1001000.
   ||
   */
   --
   FUNCTION BaseN_to_Dec (p_num IN VARCHAR2, p_base IN NUMBER) RETURN NUMBER;
   PRAGMA RESTRICT_REFERENCES (BaseN_to_Dec, WNDS, RNDS, WNPS, RNPS);
   --
   FUNCTION Dec_to_BaseN (p_num IN NUMBER,   p_base IN NUMBER) RETURN VARCHAR2;
   PRAGMA RESTRICT_REFERENCES (Dec_to_BaseN, WNDS, RNDS, WNPS, RNPS);
   --
   FUNCTION BaseN_to_BaseM (p_num IN VARCHAR2, p_baseN IN NUMBER, p_baseM IN NUMBER)
   RETURN VARCHAR2;
   PRAGMA RESTRICT_REFERENCES (BaseN_to_BaseM, WNDS, RNDS, WNPS, RNPS);
END converter;
/
CREATE OR REPLACE PACKAGE BODY converter AS
   /*
   ||  CONVERTER Package
   ||
   ||  (c) 1999  Chris Hunt, Extra Connections Ltd
   ||
   ||  This code is made freely available for use in both private and commercial
   ||  applications.
   ||
   ||  Whilst every effort has been made to ensure these routines operate
   ||  accurately and properly, no liability will be accepted for any problems
   ||  they may cause on your system.
   ||
   ||  Please consult the package header for full details of this package
   ||
   ||  The latest version of this file (and other goodies) can be found at
   ||  http://www.extracon.com
   */
   c_digits CONSTANT VARCHAR2(36) := '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
   --
   invalid_number         EXCEPTION;
   PRAGMA EXCEPTION_INIT (invalid_number,-1722);
   --
   argument_out_of_range  EXCEPTION; 
   PRAGMA EXCEPTION_INIT (argument_out_of_range,-1428);
   --
   FUNCTION BaseN_to_Dec (p_num IN VARCHAR2, p_base IN NUMBER) RETURN NUMBER IS
      v_digit  NUMBER;
      v_pos    NUMBER;
      v_total  NUMBER := 0;
      v_factor NUMBER := 1;
      v_base   NUMBER;
   BEGIN
      --
      -- Strip out any sign or fraction from the specified base, the result must
      -- be between 2 and 36.
      --
      v_base := ABS(TRUNC(p_base));
      IF v_base < 2 OR v_base > LENGTH(c_digits) THEN
         RAISE argument_out_of_range;
      END IF;
      --
      -- Examine each digit, starting with the rightmost
      --
      FOR v_pos IN REVERSE 1 .. LENGTH(p_num) LOOP
         v_digit := INSTR(c_digits,UPPER(SUBSTR(p_num,v_pos,1))) - 1;
         --
         IF v_digit = -1 THEN   -- invalid digit
            RAISE invalid_number;
         ELSE
            v_total := v_total + (v_digit * v_factor);
         END IF;
         --
         v_factor := v_factor * v_base;
      END LOOP;
      --
      RETURN v_total;
   END BaseN_To_Dec;
   --
   FUNCTION Dec_to_BaseN (p_num IN NUMBER,   p_base IN NUMBER) RETURN VARCHAR2 IS
      v_remaining   NUMBER;
      v_digit       NUMBER;
      v_factor      NUMBER := 1;
      v_number      VARCHAR2(255);  -- big enough for anything!
      v_base        NUMBER;
   BEGIN
      --
      -- Strip out any sign or fraction from the specified base, the result must
      -- be between 2 and 36.
      --
      v_base := ABS(TRUNC(p_base));
      IF v_base < 2 OR v_base > LENGTH(c_digits) THEN
         RAISE argument_out_of_range;
      END IF;
      --
      v_remaining := TRUNC(ABS(p_num));  -- Remove any sign or fraction from number
      --
      -- Consider each power of p_base in turn, building up a number digit-by-digit
      -- from the right hand side. v_factor will have values of 1, 10, 100, 1000, etc
      -- (in whatever base we're using) in successive iterations of the loop.
      --
      WHILE v_remaining > 0 LOOP
         --
         -- Work out the value for this digit...
         --
         v_digit := MOD(TRUNC(v_remaining / v_factor), v_base);
         --
         -- ...append the appropriate character to the left of the number...
         --
         v_number:= SUBSTR(c_digits,(v_digit + 1),1)||v_number;
         --
         -- ...and deduct it from the amount remaining to be expressed
         --
         v_remaining := v_remaining - (v_digit * v_factor);
         v_factor := v_factor * v_base;
      END LOOP;
      RETURN v_number;
   END Dec_To_BaseN;
   --
   FUNCTION BaseN_to_BaseM (p_num IN VARCHAR2, p_baseN IN NUMBER, p_baseM IN NUMBER)
   RETURN VARCHAR2 IS
   BEGIN
      --
      -- Convert p_num to decimal, then convert the result to base M
      -- There's no need to validate any of these parameters, as this will be done
      -- by the called functions
      --
      RETURN Dec_To_BaseN(BaseN_To_Dec(p_num,p_baseN),p_baseM);
   END BaseN_To_BaseM;
END converter; 
/
  CREATE OR REPLACE PACKAGE bitwise AS
   /*
   ||  BITWISE Package
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
   ||  http://www.extracon.com
   ||
   ||  ========
   ||  Overview
   ||  ========
   ||
   ||  This package contains a number of functions which perform bitwise logical
   ||  operations on numbers.
   ||
   ||  To perform these operations, each number is converted to binary and the
   ||  corresponding bits are compared according to the following table:
   ||
   ||   A    B  | A AND B  A OR B  A XOR B  NOT A
   ||  ===  === | =======  ======  =======  =====
   ||   0    0  |    0        0       0       1
   ||   0    1  |    0        1       1       1
   ||   1    0  |    0        1       1       0
   ||   1    1  |    1        1       0       0
   ||
   ||  The resultant bits form the answer returned by the function
   ||
   ||  All the functions defined here have the necessary "purity level" to be used
   ||  in SQL SELECT and WHERE clauses as well as PL/SQL.
   ||
   ||  ====================
   ||  Function Definitions
   ||  ====================
   ||
   ||  AND_fn (a, b)   Performs a bitwise AND between a and b. 
   ||
   ||  OR_fn  (a, b)   Performs a bitwise OR between a and b.
   ||
   ||  XOR_fn (a, b)   Performs a bitwise exclusive OR between a and b.
   ||
   ||  NOT (a)         Performs a bitwise NOT on a.
   ||
   ||  ========
   ||  Examples
   ||  ========
   ||
   ||  bitwise.AND_fn(11,13) returns 9 (1011 AND 1101 = 1001)
   ||
   ||  bitwise.OR_fn(11,13) returns 15 (1011 OR 1101 = 1111)
   ||
   ||  bitwise.XOR_fn(11,13) returns 6 (1011 XOR 1101 = 0110)
   ||
   ||  bitwise.NOT_fn(11) returns 4 (NOT 1011 = 0100)
   ||
   */
   FUNCTION AND_fn (numA IN NUMBER,numB IN NUMBER) RETURN NUMBER;
   PRAGMA RESTRICT_REFERENCES (AND_fn, WNDS, WNPS, RNDS, RNPS);
   --
   FUNCTION OR_fn (numA IN NUMBER,numB IN NUMBER) RETURN NUMBER;
   PRAGMA RESTRICT_REFERENCES (OR_fn, WNDS, WNPS, RNDS, RNPS);
   --
   FUNCTION XOR_fn (numA IN NUMBER,numB IN NUMBER) RETURN NUMBER;
   PRAGMA RESTRICT_REFERENCES (XOR_fn, WNDS, WNPS, RNDS, RNPS);
   --
   FUNCTION NOT_fn (p_number IN NUMBER) RETURN NUMBER;
   PRAGMA RESTRICT_REFERENCES (NOT_fn, WNDS, WNPS, RNDS, RNPS);
END bitwise;
/

CREATE OR REPLACE PACKAGE BODY bitwise AS
   /*
   ||  BITWISE Package Body
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
   ||  http://www.extracon.com
   ||
   */
   /*
   || bin_digit (local procedure)
   ||
   || Returns the relevant binary digit (1 or 0) from p_number
   || corresponding to power of two p_power (1, 2, 4, 8, ...)
   ||
   */
   FUNCTION bin_digit (p_number IN NUMBER, p_power IN NUMBER)
   RETURN NUMBER IS
   BEGIN
      RETURN MOD(TRUNC(p_number/p_power),2);
   END;
   /*
   || AND_fn
   ||
   || Performs a bitwise AND operation between the two arguments
   ||
   */
   FUNCTION AND_fn (numA IN NUMBER,numB IN NUMBER) RETURN NUMBER IS
      power NUMBER  := 1;
      answer NUMBER := 0;
   BEGIN
      IF numA IS NULL OR numB IS NULL THEN
         RETURN NULL;
      END IF;
      --
      WHILE numA >= power OR numB >= power LOOP
         IF  bin_digit (numA,power) = 1
         AND bin_digit (numB,power) = 1 THEN
            answer := answer + power;
         END IF;
         power := power * 2;
      END LOOP;
      --
      RETURN answer;
   END;
   /*
   || OR_fn
   ||
   || Performs a bitwise OR operation between the two arguments
   ||
   */
   FUNCTION OR_fn (numA IN NUMBER,numB IN NUMBER) RETURN NUMBER IS
      power NUMBER  := 1;
      answer NUMBER := 0;
   BEGIN
      IF numA IS NULL OR numB IS NULL THEN
         RETURN NULL;
      END IF;
      --
      WHILE numA >= power OR numB >= power LOOP
         IF bin_digit (numA,power) = 1
         OR bin_digit (numB,power) = 1 THEN
            answer := answer + power;
         END IF;
         power := power * 2;
      END LOOP;
      --
      RETURN answer;
   END;
   /*
   || XOR_fn
   ||
   || Performs a bitwise exclusive OR operation between the two arguments
   ||
   */
   FUNCTION XOR_fn (numA IN NUMBER,numB IN NUMBER) RETURN NUMBER IS
      power NUMBER  := 1;
      answer NUMBER := 0;
   BEGIN
      IF numA IS NULL OR numB IS NULL THEN
         RETURN NULL;
      END IF;
      --
      WHILE numA >= power OR numB >= power LOOP
         IF  bin_digit (numA,power) <> bin_digit (numB,power) THEN
            answer := answer + power;
         END IF;
         power := power * 2;
      END LOOP;
      --
      RETURN answer;
   END;
   /*
   || NOT_fn
   ||
   || Performs a bitwise NOT operation on the specified number
   ||
   */
   FUNCTION NOT_fn (p_number IN NUMBER) RETURN NUMBER IS
      power NUMBER  := 1;
      answer NUMBER := 0;
   BEGIN
      IF p_number IS NULL THEN
         RETURN NULL;
      END IF;
      --
      WHILE p_number >= power LOOP
         IF  bin_digit (p_number,power) = 0 THEN
            answer := answer + power;
         END IF;
         power := power * 2;
      END LOOP;
      --
      RETURN answer;
   END;
END bitwise;
/



REM bittest.sql - Tests/demonstrates the functions in the bitwise package
REM (bitwise.sql must be run before this script will work)
REM (c) Chris Hunt 1999
REM  
REM ACCEPT a PROMPT "Enter a value for A: "
REM ACCEPT b PROMPT "Enter a value for B: "
REM 
REM SET verify OFF
REM SET head ON
REM 
REM SELECT bitwise.AND_fn (&&a, &&b) "A AND B",
REM        bitwise.OR_fn  (&&a, &&b) "A OR B",
REM        bitwise.XOR_fn (&&a, &&b) "A XOR B",
REM        bitwise.NOT_fn (&&a) "NOT A",
REM        bitwise.NOT_fn (&&b) "NOT B"
REM FROM   dual
REM /

CREATE OR REPLACE PACKAGE cheque AS
   /*
   ||  CHEQUE Package
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
   ||  http://www.extracon.com
   ||
   ||  ========
   ||  Overview
   ||  ========
   ||
   ||  This package contains functions which express a numeric amount of
   ||  money in words, for use on a cheque.
   ||
   ||  This code is adapted from an example in Steven Feuerstein's book "Oracle
   ||  PL/SQL Programming". I've improved the quality of the output and the
   ||  efficiency of the procedure.
   ||
   ||  All the functions defined here have the necessary "purity level" to be used
   ||  in SQL SELECT and WHERE clauses as well as PL/SQL.
   ||
   ||  ============
   ||  Localisation
   ||  ============
   ||
   ||  As written, this package returns amounts in pounds and pence expressed
   ||  in english. To change the currency, simply change the values of the
   ||  constants c_dollar, c_dollars, c_cent and c_cents to the singular and
   ||  plural forms appropriate to your currency.
   ||
   ||  To change the language, you're on your own. I'm unable to write a
   ||  routine that works in all languages. Be aware, though, that the package
   ||  relies in part on the TO_CHAR function to get its numbers, so changing
   ||  the database NLS settings may have adverse affects on this package.
   ||
   ||  ====================
   ||  Function Definitions
   ||  ====================
   ||
   ||  int2words (number)   Expresses number (which must be an integer) in words. 
   ||
   ||  amt2words (number)   Expresses number as an amount in pounds and pence.
   ||
   ||  ========
   ||  Examples
   ||  ========
   ||
   ||  cheque.int2words(1113)   returns "One Thousand, One Hundred and
   ||                           Thirteen"
   ||
   ||  cheque.amt2words(123.45) returns "One Hundred and Twenty-three Pounds
   ||                           and Forty-Five pence"
   ||
   */
   FUNCTION int2words (number_in IN NUMBER) RETURN VARCHAR2;
	PRAGMA RESTRICT_REFERENCES (int2words, WNDS, RNDS, WNPS, RNPS);
   FUNCTION amt2words (number_in IN NUMBER) RETURN VARCHAR2;
	PRAGMA RESTRICT_REFERENCES (amt2words, WNDS, RNDS, WNPS, RNPS);
END cheque;
/
	
CREATE OR REPLACE PACKAGE BODY cheque AS
   /*
   || Constants
   ||
   || These are the text names of the currency to be printed out on the cheque.
   || Swap these for Dollars, Francs, Marks, cowrie shells, camels or whatever
   || other kind of beer token you want to use.
   */
   c_dollar   CONSTANT VARCHAR2(6) := 'Pound'; 
   c_dollars  CONSTANT VARCHAR2(6) := 'Pounds'; 
   c_cent     CONSTANT VARCHAR2(6) := 'penny'; 
   c_cents    CONSTANT VARCHAR2(6) := 'pence'; 
   /*
   || Functions
   */
   FUNCTION int2words (number_in IN NUMBER) RETURN VARCHAR2
   IS
      my_number NUMBER;
      remainder NUMBER;
   BEGIN
      --
      -- Should already be an integer, but just in case!
      --
      my_number := FLOOR (number_in);
      --
      -- Return NULL if zero or negative
      --
      IF my_number <= 0 THEN
         RETURN NULL;
      END IF;

      --
      -- Break down the passed number into its component parts, making recursive calls
      -- to int2words as required.
      --
      /* 1,000,000+ */
      IF my_number >= 1000000 THEN
         -- Break up into two recursive calls to int2words.
         remainder := MOD (my_number, 1000000);
         IF remainder = 0 THEN
            RETURN int2words (my_number/1000000) || ' Million';
         ELSIF remainder BETWEEN 1 AND 99 THEN
            RETURN int2words (my_number/1000000)||' Million and '||
                   int2words (remainder);
         ELSE
            RETURN int2words (my_number/1000000)||' Million, '||
                   int2words (remainder);
         END IF;
      END IF;

      /* 1,000-9,999 */
      IF my_number >= 1000 THEN
         -- Break up into two recursive calls to int2words.
         remainder := MOD (my_number, 1000);
         IF remainder = 0 THEN
            RETURN int2words (my_number/1000) || ' Thousand';
         ELSIF remainder BETWEEN 1 AND 99 THEN
            RETURN int2words (my_number/1000)||' Thousand and '||
                   int2words (remainder);
         ELSE
            RETURN int2words (my_number/1000)||' Thousand, '||
                   int2words (remainder);
         END IF;
      END IF;

      /* 100-999 */
      IF my_number >= 100 THEN
         -- Break up into two recursive calls to num2words.
         remainder := MOD (my_number, 100);
         IF remainder BETWEEN 1 AND 99 THEN
            RETURN int2words (my_number/100)||' Hundred and '||
                   int2words (remainder);
         ELSE
            RETURN int2words (my_number/100) || ' Hundred';
         END IF;
      END IF;

      /* 1-99 (devious use of TO_DATE coming up!)*/

      RETURN TO_CHAR(TO_DATE(TO_CHAR(my_number),'YYYY'),'Year');
   END int2words;

   FUNCTION amt2words (number_in IN NUMBER) RETURN VARCHAR2
   IS
      dollars    NUMBER;
      cents      NUMBER (2);
      --
      output     VARCHAR2 (200) := '';
   BEGIN
      dollars := FLOOR (number_in);
      cents   := FLOOR (MOD(number_in * 100,100));
      --
      IF number_in < 0.01 THEN
         RETURN NULL;
      END IF;
      --
      IF dollars > 1 THEN
         output := int2words(dollars)||' '||c_dollars;
      ELSIF dollars = 1 THEN
         output := int2words(dollars)||' '||c_dollar;
      END IF;
      --
      IF cents = 0 THEN
         output := output || ' only';
      ELSE
         IF dollars > 0 THEN
            output := output || ' and';
         END IF;
         IF cents = 1 THEN
            output := output ||' '|| int2words(cents) ||' '||c_cent;
         ELSIF cents > 1 THEN
            output := output ||' '|| int2words(cents) ||' '||c_cents;
         END IF;
      END IF;

      RETURN LTRIM(output);
   END amt2words;
END cheque;
/



