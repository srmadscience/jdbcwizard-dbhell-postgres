
CREATE OR REPLACE PACKAGE plsql_indexby_tables AS
--
TYPE indexByTabChar IS TABLE OF VARCHAR2(20) INDEX BY BINARY_INTEGER;
--
TYPE indexByTabNumber IS TABLE OF number(10,2) INDEX BY BINARY_INTEGER;
--
PROCEDURE proc_01 (p1 in     indexByTabChar
                  ,p2 in out indexByTabChar
                  ,p3    out indexByTabChar
                  , status OUT VARCHAR2);
--
PROCEDURE proc_02 (p1 in     indexByTabNumber
                  ,p2 in out indexByTabNumber
                  ,p3    out indexByTabNumber
                  , status OUT BOOLEAN);
--
END;
/


show errors

CREATE OR REPLACE PACKAGE BODY plsql_indexby_tables AS
--
PROCEDURE proc_01 (p1 in indexByTabChar
                  ,p2 in out indexByTabChar
                  ,p3    out indexByTabChar 
                  ,status OUT VARCHAR2) IS
--
BEGIN
--
  FOR i in 1..80 LOOP
--
    p3(i) := ltrim(to_char(i,'RN'));
--
  END LOOP;
--
  p3(97) := 'END';
--
  p2(2) := 'TWO';
--
END;
--
PROCEDURE proc_02 (p1 in     indexByTabNumber
                  ,p2 in out indexByTabNumber
                  ,p3    out indexByTabNumber
                  , status OUT BOOLEAN) IS
--
BEGIN
--
  FOR i in 1..80 LOOP
--
    p3(i) := i;
--
  END LOOP;
--
  p2(3) := p2(1) + p2(2);
--
  status := true;
--
END;
--
END;
/


show errors



exit


