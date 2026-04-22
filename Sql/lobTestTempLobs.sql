DROP TABLE templob_test;

DROP SEQUENCE templob_seq;

DROP TYPE table_templob_test;
DROP TYPE type_templob_test;

create sequence templob_seq;

create table templob_test(seqno number
                        , clob_column clob
                        , blob_column blob
                        , bfile_column bfile) tablespace dbhell_lob;


CREATE OR REPLACE TYPE type_templob_test AS OBJECT
                         (seqno number
                        , clob_column clob
                        , blob_column blob
                        , bfile_column bfile);
.
/

show errors

CREATE OR REPLACE TYPE table_templob_test AS TABLE OF type_templob_test;
.
/
show errors

CREATE OR REPLACE PACKAGE temp_lob_test AS
--
PROCEDURE lob_test_sc(p_clob  in CLOB, p_seqno out number, p_out_clob  out CLOB
                  ,p_blob  in BLOB                    , p_out_blob  out BLOB
                  ,p_bfile in BFILE                   , p_out_bfile out BFILE);
--
PROCEDURE lob_test_rw(p_lobrow  in templob_test%ROWTYPE,  p_out  out templob_test%ROWTYPE);
--
PROCEDURE lob_test_ar(p_lobtab  in table_templob_test,  p_out  out table_templob_test);
--
END;
.
/


CREATE OR REPLACE PACKAGE BODY temp_lob_test AS
--
PROCEDURE lob_test_sc(p_clob  in CLOB, p_seqno out number, p_out_clob  out CLOB
                     ,p_blob  in BLOB                    , p_out_blob  out BLOB
                     ,p_bfile in BFILE                   , p_out_bfile out BFILE) IS
--
  l_out_clob CLOB;
  l_out_blob BLOB;
  l_out_bfile BFILE;
--
  BEGIN
--
  SELECT templob_seq.NEXTVAL INTO p_seqno FROM DUAL;
--
  INSERT INTO templob_test
  (seqno, clob_column, blob_column, bfile_column)
  VALUES
  (p_seqno,  p_clob, p_blob, p_bfile);
--
  COMMIT;
--
  SELECT clob_column, blob_column, bfile_column INTO l_out_clob, l_out_blob, l_out_bfile
  FROM  templob_test
  WHERE seqno = p_seqno
  FOR UPDATE OF clob_column, blob_column NOWAIT;
--
  p_out_clob := l_out_clob;
  p_out_blob := l_out_blob;
  p_out_bfile := l_out_bfile;
--
END;
--
PROCEDURE lob_test_rw(p_lobrow  in templob_test%ROWTYPE,  p_out  out templob_test%ROWTYPE) IS
--
  l_out templob_test%ROWTYPE;
--
BEGIN
--
  SELECT templob_seq.NEXTVAL INTO l_out.seqno FROM DUAL;
--
  l_out.clob_column := p_lobrow.clob_column;
  l_out.blob_column := p_lobrow.blob_column;
  l_out.bfile_column := p_lobrow.bfile_column;
--
  INSERT INTO templob_test
  (seqno, clob_column, blob_column, bfile_column)
  VALUES
  (l_out.seqno, l_out.clob_column, l_out.blob_column, l_out.bfile_column);
--
END;
--
PROCEDURE lob_test_ar(p_lobtab  in table_templob_test,  p_out  out table_templob_test) IS
--
BEGIN
--
p_out := p_lobtab;
--
END;
--
END;
.
/

show errors

