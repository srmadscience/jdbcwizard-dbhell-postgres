CREATE OR REPLACE PACKAGE wrapped_des AS
--
FUNCTION DESGetKey(seed_string IN VARCHAR2) RETURN VARCHAR2;
--
FUNCTION DESEncrypt(input_string     IN  VARCHAR2,
key_string       IN  VARCHAR2)
RETURN VARCHAR2;
--
FUNCTION DESDecrypt(input_string     IN     VARCHAR2,
key_string       IN  VARCHAR2)
RETURN VARCHAR2;
--
END;
/
