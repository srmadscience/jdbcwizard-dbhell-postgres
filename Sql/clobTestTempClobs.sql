
CREATE OR REPLACE PROCEDURE temp_clob_test(p_clob in CLOB, p_seqno out number, p_out  out CLOB) AS
--
  l_out CLOB;
--
  BEGIN
--
  SELECT clob_seq.NEXTVAL INTO p_seqno FROM DUAL;
--
  INSERT INTO clob_test
  (seqno, clob_column)
  VALUES
  (p_seqno,  p_clob);
--
  COMMIT;
--
  SELECT clob_column INTO l_out
  FROM  clob_test
  WHERE seqno = p_seqno
  FOR UPDATE OF clob_column NOWAIT;
--
  p_out := l_out;
--
END;
.
/


