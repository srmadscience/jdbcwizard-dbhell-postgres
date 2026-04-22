CREATE OR REPLACE PACKAGE BODY wrapped_des AS
--
FUNCTION DESGetKey(seed_string IN VARCHAR2) RETURN VARCHAR2
IS
--
BEGIN
--
-- We explicitly name the parameters to avoid the "too many declareations" message
--
  RETURN(dbms_obfuscation_toolkit.DESGetKey(seed_string => seed_string));
--
END;
--
FUNCTION DESEncrypt(input_string     IN  VARCHAR2,
                    key_string       IN  VARCHAR2)
RETURN VARCHAR2 IS
--
BEGIN
--
  RETURN(dbms_obfuscation_toolkit.DESEncrypt(input_string => input_string, key_string => key_string));
--
END;
--
--
--
FUNCTION DESDecrypt(input_string     IN  VARCHAR2,
                    key_string       IN  VARCHAR2)
RETURN VARCHAR2 IS 
--
BEGIN
--
  RETURN(dbms_obfuscation_toolkit.DESDecrypt(input_string => input_string, key_string => key_string));
--
END;
--
--
END;
/
