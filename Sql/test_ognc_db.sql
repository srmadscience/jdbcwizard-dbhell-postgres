spool ognc_db.lst
connect system/manager@&1
set echo on 
set timing on

drop user ognc        cascade;

grant connect,resource,dba to ognc        identified by ognc;

grant unlimited tablespace to ognc;

connect ognc/ognc@&1;

drop tablespace mu_bigtab including contents;
drop tablespace mu_tinytab including contents;
drop tablespace mu_bigind including contents;
drop tablespace mu_tinyind including contents;
drop tablespace mu_blobspace including contents;
drop tablespace mu_summarytab including contents;
drop tablespace mu_summaryind including contents;

drop tablespace mu_audittab including contents;
drop tablespace mu_minimutab including contents;
drop tablespace mu_minimuind including contents;



/*******

Before you run this script you should replace the following 
tokens using sed. 

Create a file called dev.sed (or test.sed or prod.sed) containing:

1,$s,PARAM_BIGIND_TS,/foo/bar/bigind.dbs,g
1,$s,PARAM_TINYIND_TS,/foo/bar/tinyind.dbs,g
1,$s,PARAM_BIGTAB_TS,/foo/bar/bigtab.dbs,g
1,$s,PARAM_TINYTAB_TS,/foo/bar/tinytab.dbs,g
1,$s,PARAM_BIGIND_SIZE,1024M,g
1,$s,PARAM_TINYIND_SIZE,12M,g
1,$s,PARAM_BIGTAB_SIZE,1024M,g
1,$s,PARAM_TINYTAB_SIZE,12M,g

Then create your *real* script by entering:

sed -f dev.sed < shamu_ddl.sql > shamu_dev.sql

PARAM_BIGIND_TS - Name of First Big Index Tablespace File
PARAM_TINYIND_TS - Name of First Tiny Index Tablespace File
PARAM_BIGTAB_TS - Name of First Big table Tablespace File
PARAM_TINYTAB_TS - Name of First Tiny Table Tablespace File

Adding additional data files where needed comes under the jurisdiction of the DBA group.

PARAM_BIGIND_SIZE - Size of First Big Index Tablespace File
PARAM_TINYIND_SIZE - Size of First Tiny Index Tablespace File
PARAM_BIGTAB_SIZE - Size of First Big table Tablespace File
PARAM_TINYTAB_SIZE - Size of First Tiny Table Tablespace File


********/


pause



/*
Create and Rebuild various sequences.

Note that the sequence usually shares the same name as the column(s) that it will be used to populate. This makes
it possible to write a meta data query that searches for values > the CURRVAL of a given sequence.

*/


DROP SEQUENCE   ADDRESSID;

CREATE SEQUENCE ADDRESSID MAXVALUE 9999999999999999999999999 CYCLE CACHE 100;

DROP SEQUENCE   APPLICATIONID;

CREATE SEQUENCE APPLICATIONID MAXVALUE 9999999999999999999999999 CYCLE CACHE 100;

DROP SEQUENCE   BORROWERID;

CREATE SEQUENCE BORROWERID MAXVALUE 9999999999999999999999999 CYCLE CACHE 100;

DROP SEQUENCE   USERID;

CREATE SEQUENCE USERID START WITH 3501 MAXVALUE 9999999999999999999999999 CYCLE CACHE 100;

DROP SEQUENCE   EMPLOYMENTID;

CREATE SEQUENCE EMPLOYMENTID MAXVALUE 9999999999999999999999999 CYCLE CACHE 100;

DROP SEQUENCE   REALESTATEID;

CREATE SEQUENCE REALESTATEID MAXVALUE 9999999999999999999999999 CYCLE CACHE 100;

DROP SEQUENCE   ASSETID;

CREATE SEQUENCE ASSETID MAXVALUE 9999999999999999999999999 CYCLE CACHE 100;

DROP SEQUENCE   LIABILTYID;

CREATE SEQUENCE LIABILITYID MAXVALUE 9999999999999999999999999 CYCLE CACHE 100;

DROP SEQUENCE   RESIDENCEID;

CREATE SEQUENCE RESIDENCEID MAXVALUE 9999999999999999999999999 CYCLE CACHE 100;

DROP SEQUENCE   NOTEBOOKITEMID;

CREATE SEQUENCE NOTEBOOKITEMID START WITH 3500 MAXVALUE 9999999999999999999999999 CYCLE CACHE 100;

DROP SEQUENCE   PROPERTYLOANID;

CREATE SEQUENCE PROPERTYLOANID MAXVALUE 9999999999999999999999999 CYCLE CACHE 100;

/* 
Special Sequence for when you need a unique number for something that isnt covered above...
*/

DROP SEQUENCE   GENERIC_SEQ;

CREATE SEQUENCE GENERIC_SEQ MAXVALUE 9999999999999999999999999 CYCLE CACHE 100;

/*
Sequences for Search Engine...
*/

DROP SEQUENCE   PAGEKEYWORDID;

CREATE SEQUENCE PAGEKEYWORDID MAXVALUE 9999999999999999999999999 CYCLE CACHE 100;

DROP SEQUENCE   SITEPAGEID;

CREATE SEQUENCE SITEPAGEID MAXVALUE 9999999999999999999999999 CYCLE CACHE 100;


/***
Sequences for MINIMU
***/

DROP SEQUENCE   EMPLOYEEID;

CREATE SEQUENCE EMPLOYEEID START WITH 3500 MAXVALUE 9999999999999999999999999 CYCLE CACHE 100;



CREATE TABLESPACE MU_AUDITTAB
       DATAFILE '/export/data/oradata/&1/W_AUDITTAB_TS.dbf' size 100M REUSE
       DEFAULT
       STORAGE ( 
       INITIAL 4096K
       NEXT 4096K
       PCTINCREASE 0
       ) 
  ;
CREATE TABLESPACE MU_BIGIND
       DATAFILE '/export/data/oradata/&1/W_BIGIND_TS.dbf' SIZE 200M REUSE
       DEFAULT
       STORAGE ( 
       INITIAL 194304
       NEXT 194304
       MINEXTENTS 1
       MAXEXTENTS 505
       PCTINCREASE 0
       ) 
  ;
CREATE TABLESPACE MU_BIGTAB
       DATAFILE '/export/data/oradata/&1/W_BIGTAB_TS.dbf' size 100M REUSE
       DEFAULT
       STORAGE ( 
       INITIAL 1096K
       NEXT 1096K
       PCTINCREASE 0
       ) 
  ;
CREATE TABLESPACE MU_BLOBSPACE
       DATAFILE '/export/data/oradata/&1/W_BLOBSPACE_TS.dbf' size 100M REUSE
       DEFAULT
       STORAGE ( 
       INITIAL 1096K
       NEXT 1096K
       PCTINCREASE 0
       ) 
  ;
CREATE TABLESPACE MU_MINIMUIND
       DATAFILE '/export/data/oradata/&1/W_MINIMUIND_TS.dbf' SIZE 100M REUSE
       DEFAULT
       STORAGE ( 
       INITIAL 1194304
       NEXT 1194304
       MINEXTENTS 1
       MAXEXTENTS 505
       PCTINCREASE 0
       ) 
  ;
CREATE TABLESPACE MU_MINIMUTAB
       DATAFILE '/export/data/oradata/&1/W_MINIMUTAB_TS.dbf' SIZE 100M REUSE
       DEFAULT
       STORAGE ( 
       INITIAL 1194304
       NEXT 1194304
       MINEXTENTS 1
       MAXEXTENTS 505
       PCTINCREASE 0
       ) 
  ;
CREATE TABLESPACE MU_SUMMARYIND
       DATAFILE '/export/data/oradata/&1/W_SUMMARYIND_TS.dbf' size 100M REUSE
       DEFAULT
       STORAGE ( 
       INITIAL 1096K
       NEXT 1096K
       PCTINCREASE 0
       ) 
  ;
CREATE TABLESPACE MU_SUMMARYTAB
       DATAFILE '/export/data/oradata/&1/W_SUMMARYTAB_TS.dbf' size 100M REUSE
       DEFAULT
       STORAGE ( 
       INITIAL 1096K
       NEXT 1096K
       PCTINCREASE 0
       ) 
  ;
CREATE TABLESPACE MU_TINYIND
       DATAFILE '/export/data/oradata/&1/W_TINYIND_TS.dbf' size 100M REUSE
       DEFAULT
       STORAGE ( 
       INITIAL 32K
       NEXT 32K
       PCTINCREASE 0
       ) 
  ;
CREATE TABLESPACE MU_TINYTAB
       DATAFILE '/export/data/oradata/&1/W_TINYTAB_TS.dbf' size 100M REUSE
       DEFAULT
       STORAGE ( 
       INITIAL 32K
       NEXT 32K
       PCTINCREASE 0
       ) 
  ;

CREATE TABLE HgLookups (
       Domain_Name          VARCHAR2(80) NOT NULL,
       Lookup_Description   VARCHAR2(80) NOT NULL,
       Lookup_Name          VARCHAR2(80) DEFAULT 'GENERIC' NOT NULL
                                   CONSTRAINT STRING_NOSPACE1008
                                          CHECK (Lookup_Name = Replace(Lookup_Name, ' ','')),
       SORT_ORDER           NUMBER DEFAULT 0 NULL,
       CONSTRAINT LOOK_INDEX0 
              PRIMARY KEY (Domain_Name, Lookup_Name)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

/**
This index won't work in Oracle Versions 
prior to 8i. Not having this index is not
the end of the world.
**/

CREATE INDEX GLOS_INDEX1 ON HGGlossary
(UPPER(termname)
,UPPER(termCategory))
TABLESPACE MU_BIGIND
;


CREATE TABLE EmailCategoryDomain (
       OtherName            VARCHAR2(80) NOT NULL,
       ECAT_NAME            VARCHAR2(40) NOT NULL,
       Description          VARCHAR2(30) NOT NULL,
       LongDescription      VARCHAR2(200) NULL,
       SORTORDER            NUMBER(27) NULL,
       CONSTRAINT ECAT_INDEX0 
              PRIMARY KEY (ECAT_NAME)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

COMMENT ON COLUMN EmailCategoryDomain.ECAT_NAME IS '%AttDef';
CREATE INDEX ECAT_INDEX1 ON EmailCategoryDomain
(
       OtherName                      ASC
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE PrepayPenaltyDomain (
       OtherName            VARCHAR2(80) NOT NULL,
       PPPY_NAME            VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37765
                                          CHECK (PPPY_NAME = Upper(PPPY_NAME)),
       Description          VARCHAR2(30) NOT NULL,
       LongDescription      VARCHAR2(200) NULL,
       SORTORDER            NUMBER(27) NULL,
       CONSTRAINT PPPY_INDEX0 
              PRIMARY KEY (PPPY_NAME)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

COMMENT ON COLUMN PrepayPenaltyDomain.PPPY_NAME IS '%AttDef';
CREATE INDEX PPPY_INDEX1 ON PrepayPenaltyDomain
(
       OtherName                      ASC
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE PaymentCapDomain (
       OtherName            VARCHAR2(80) NOT NULL,
       PCAP_NAME            VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37766
                                          CHECK (PCAP_NAME = Upper(PCAP_NAME)),
       Description          VARCHAR2(30) NOT NULL,
       LongDescription      VARCHAR2(200) NULL,
       SORTORDER            NUMBER(27) NULL,
       CONSTRAINT PCAP_INDEX0 
              PRIMARY KEY (PCAP_NAME)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

COMMENT ON COLUMN PaymentCapDomain.PCAP_NAME IS '%AttDef';
CREATE INDEX PCAP_INDEX1 ON PaymentCapDomain
(
       OtherName                      ASC
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE NegativeAmortDomain (
       OtherName            VARCHAR2(80) NOT NULL,
       NEGA_NAME            VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37767
                                          CHECK (NEGA_NAME = Upper(NEGA_NAME)),
       Description          VARCHAR2(30) NOT NULL,
       LongDescription      VARCHAR2(200) NULL,
       SORTORDER            NUMBER(27) NULL,
       CONSTRAINT NEGA_INDEX0 
              PRIMARY KEY (NEGA_NAME)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

COMMENT ON COLUMN NegativeAmortDomain.NEGA_NAME IS '%AttDef';
CREATE INDEX NEGA_INDEX1 ON NegativeAmortDomain
(
       OtherName                      ASC
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE LoanProductDomain (
       OtherName            VARCHAR2(200) NOT NULL,
       LPRO_NAME            VARCHAR2(200) NOT NULL
                                   CONSTRAINT STRING_UCASE37768
                                          CHECK (LPRO_NAME = Upper(LPRO_NAME)),
       Description          VARCHAR2(200) NOT NULL,
       LongDescription      VARCHAR2(200) NULL,
       SORTORDER            NUMBER(27) NULL,
       CONSTRAINT LPRO_INDEX0 
              PRIMARY KEY (LPRO_NAME)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

COMMENT ON COLUMN LoanProductDomain.LPRO_NAME IS '%AttDef';
CREATE INDEX LPRO_INDEX1 ON LoanProductDomain
(
       OtherName                      ASC
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE USPSStateDomain (
       OtherName            VARCHAR2(80) NOT NULL,
       USST_NAME            VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37769
                                          CHECK (USST_NAME = Upper(USST_NAME)),
       Description          VARCHAR2(30) NOT NULL,
       LongDescription      VARCHAR2(200) NULL,
       SORTORDER            NUMBER(27) NULL,
       CONSTRAINT USST_INDEX0 
              PRIMARY KEY (USST_NAME)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

COMMENT ON COLUMN USPSStateDomain.USST_NAME IS '%AttDef';
CREATE INDEX USST_INDEX1 ON USPSStateDomain
(
       OtherName                      ASC
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE WAMUCountryDomain (
       OtherName            VARCHAR2(80) NOT NULL,
       WACY_NAME            VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37770
                                          CHECK (WACY_NAME = Upper(WACY_NAME)),
       Description          VARCHAR2(30) NOT NULL,
       LongDescription      VARCHAR2(200) NULL,
       SORTORDER            NUMBER(27) NULL,
       CONSTRAINT WACY_INDEX0 
              PRIMARY KEY (WACY_NAME)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

COMMENT ON COLUMN WAMUCountryDomain.WACY_NAME IS '%AttDef';
CREATE INDEX WACY_INDEX1 ON WAMUCountryDomain
(
       OtherName                      ASC
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE ISOCountryDomain (
       OtherName            VARCHAR2(80) NOT NULL,
       ISOC_NAME            VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37771
                                          CHECK (ISOC_NAME = Upper(ISOC_NAME)),
       Description          VARCHAR2(30) NOT NULL,
       LongDescription      VARCHAR2(200) NULL,
       SORTORDER            NUMBER(27) NULL,
       CONSTRAINT ISOC_INDEX0 
              PRIMARY KEY (ISOC_NAME)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

COMMENT ON COLUMN ISOCountryDomain.ISOC_NAME IS '%AttDef';
CREATE INDEX ISOC_INDEX1 ON ISOCountryDomain
(
       OtherName                      ASC
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE OwnershipInterestDomain (
       OtherName            VARCHAR2(80) NOT NULL,
       OINT_NAME            VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37772
                                          CHECK (OINT_NAME = Upper(OINT_NAME)),
       Description          VARCHAR2(30) NOT NULL,
       LongDescription      VARCHAR2(200) NULL,
       SORTORDER            NUMBER(27) NULL,
       CONSTRAINT OINT_INDEX0 
              PRIMARY KEY (OINT_NAME)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

COMMENT ON COLUMN OwnershipInterestDomain.OINT_NAME IS '%AttDef';
CREATE INDEX OINT_INDEX1 ON OwnershipInterestDomain
(
       OtherName                      ASC
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE WAMURoleDomain (
       OtherName            VARCHAR2(80) NOT NULL,
       WARO_NAME            VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37773
                                          CHECK (WARO_NAME = Upper(WARO_NAME)),
       Description          VARCHAR2(30) NOT NULL,
       LongDescription      VARCHAR2(200) NULL,
       SORTORDER            NUMBER(27) NULL,
       CONSTRAINT WARO_INDEX0 
              PRIMARY KEY (WARO_NAME)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

COMMENT ON COLUMN WAMURoleDomain.WARO_NAME IS '%AttDef';
CREATE INDEX WARO_INDEX1 ON WAMURoleDomain
(
       OtherName                      ASC
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE NextpaymentAdjustDomain (
       OtherName            VARCHAR2(80) NOT NULL,
       NEXP_NAME            VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37774
                                          CHECK (NEXP_NAME = Upper(NEXP_NAME)),
       Description          VARCHAR2(30) NOT NULL,
       LongDescription      VARCHAR2(200) NULL,
       SORTORDER            NUMBER(27) NULL,
       CONSTRAINT NEXP_INDEX0 
              PRIMARY KEY (NEXP_NAME)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

COMMENT ON COLUMN NextpaymentAdjustDomain.NEXP_NAME IS '%AttDef';
CREATE INDEX NEXP_INDEX1 ON NextpaymentAdjustDomain
(
       OtherName                      ASC
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE FirstPaymentAdjustDomain (
       OtherName            VARCHAR2(80) NOT NULL,
       ONEP_NAME            VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37775
                                          CHECK (ONEP_NAME = Upper(ONEP_NAME)),
       Description          VARCHAR2(30) NOT NULL,
       LongDescription      VARCHAR2(200) NULL,
       SORTORDER            NUMBER(27) NULL,
       CONSTRAINT ONEP_INDEX0 
              PRIMARY KEY (ONEP_NAME)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

COMMENT ON COLUMN FirstPaymentAdjustDomain.ONEP_NAME IS '%AttDef';
CREATE INDEX ONEP_INDEX1 ON FirstPaymentAdjustDomain
(
       OtherName                      ASC
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE AmortizationTermDomain (
       OtherName            VARCHAR2(80) NOT NULL,
       AMTZ_NAME            VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37776
                                          CHECK (AMTZ_NAME = Upper(AMTZ_NAME)),
       Description          VARCHAR2(30) NOT NULL,
       LongDescription      VARCHAR2(200) NULL,
       SORTORDER            NUMBER(27) NULL,
       CONSTRAINT AMTZ_INDEX0 
              PRIMARY KEY (AMTZ_NAME)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

COMMENT ON COLUMN AmortizationTermDomain.AMTZ_NAME IS '%AttDef';
CREATE INDEX AMTZ_INDEX1 ON AmortizationTermDomain
(
       OtherName                      ASC
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE ApplicationStageDomain (
       OtherName            VARCHAR2(80) NOT NULL,
       ASTG_NAME            VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37777
                                          CHECK (ASTG_NAME = Upper(ASTG_NAME)),
       Description          VARCHAR2(30) NOT NULL,
       LongDescription      VARCHAR2(200) NULL,
       SORTORDER            NUMBER(27) NULL,
       CONSTRAINT ASTG_INDEX0 
              PRIMARY KEY (ASTG_NAME)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

CREATE INDEX ASTG_INDEX1 ON ApplicationStageDomain
(
       OtherName                      ASC
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE PropertyUsageDomain (
       OtherName            VARCHAR2(80) NOT NULL,
       PDSP_NAME            VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37778
                                          CHECK (PDSP_NAME = Upper(PDSP_NAME)),
       Description          VARCHAR2(30) NOT NULL,
       LongDescription      VARCHAR2(200) NULL,
       SORTORDER            NUMBER(27) NULL,
       CONSTRAINT PDSP_INDEX0 
              PRIMARY KEY (PDSP_NAME)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

CREATE INDEX PDSP_INDEX1 ON PropertyUsageDomain
(
       OtherName                      ASC
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE WAMUTitleDomain (
       OtherName            VARCHAR2(80) NOT NULL,
       WATI_NAME            VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37779
                                          CHECK (WATI_NAME = Upper(WATI_NAME)),
       Description          VARCHAR2(30) NOT NULL,
       LongDescription      VARCHAR2(200) NULL,
       SORTORDER            NUMBER(27) NULL,
       CONSTRAINT WATI_INDEX0 
              PRIMARY KEY (WATI_NAME)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

COMMENT ON COLUMN WAMUTitleDomain.WATI_NAME IS '%AttDef';
CREATE INDEX WATI_INDEX1 ON WAMUTitleDomain
(
       OtherName                      ASC
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE WAMU_EMPLOYEE (
       EMPLOYEEID           NUMBER(27) NOT NULL,
       WAMU_TITLE_DOMAIN    VARCHAR2(40) NULL
                                   CONSTRAINT STRING_UCASE37780
                                          CHECK (WAMU_TITLE_DOMAIN = Upper(WAMU_TITLE_DOMAIN)),
       LAST_NAME            VARCHAR2(80) NOT NULL,
       FIRST_NAME           VARCHAR2(80) NULL,
       PHONE_EXTENSION      VARCHAR2(5) NULL,
       WAMU_ID              VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37781
                                          CHECK (WAMU_ID = Upper(WAMU_ID)),
       EMAIL_ADDRESS        VARCHAR2(80) NULL,
       PASSWORD_STRING      VARCHAR2(30) NOT NULL,
       INACTIVE_YN          VARCHAR2(1) DEFAULT 'N' NOT NULL
                                   CONSTRAINT IS_Y_OR_N7388
                                          CHECK (INACTIVE_YN IN ('Y','N')),
       DELETED_YN           VARCHAR2(1) DEFAULT 'N' NOT NULL
                                   CONSTRAINT IS_Y_OR_N7389
                                          CHECK (DELETED_YN IN ('Y','N')),
       DELETE_DATETIME      DATE NULL,
       MOTD                 VARCHAR2(200) NULL,
       CONSTRAINT WAEP_INDEX0 
              PRIMARY KEY (EMPLOYEEID)
       USING INDEX
              TABLESPACE MU_MINIMUIND, 
       CONSTRAINT R_153
              FOREIGN KEY (WAMU_TITLE_DOMAIN)
                             REFERENCES WAMUTitleDomain,
       CONSTRAINT WAEP_INDEX1
       UNIQUE (
              WAMU_ID
       )
       USING INDEX
              TABLESPACE MU_MINIMUIND
)
       TABLESPACE MU_MINIMUTAB
       CACHE 
;

COMMENT ON COLUMN WAMU_EMPLOYEE.WAMU_TITLE_DOMAIN IS '%AttDef';
CREATE INDEX WAEP_INDEX2 ON WAMU_EMPLOYEE
(
       WAMU_TITLE_DOMAIN              ASC
)
       TABLESPACE MU_MINIMUIND
;

CREATE INDEX WAEP_INDEX3 ON WAMU_EMPLOYEE
(
       LAST_NAME                      ASC
)
       TABLESPACE MU_MINIMUIND
;

CREATE INDEX WAEP_INDEX4 ON WAMU_EMPLOYEE
(
       FIRST_NAME                     ASC
)
       TABLESPACE MU_MINIMUIND
;

CREATE INDEX WAEP_INDEX5 ON WAMU_EMPLOYEE
(
       EMAIL_ADDRESS                  ASC
)
       TABLESPACE MU_MINIMUIND
;


CREATE OR REPLACE TRIGGER WAMU_EMPLOYEE_NO_UPD_DEL
BEFORE DELETE OR UPDATE ON WAMU_EMPLOYEE
FOR EACH ROW
--
BEGIN
--
IF :old.employeeId <0 THEN
--
  RAISE_APPLICATION_ERROR(-20105,'WAMU_EMPLOYEE records with negative identifiers can not be deleted');
--
END IF;
--
END;
/

show errors



CREATE TABLE OwnershipDurationDomain (
       OtherName            VARCHAR2(80) NOT NULL,
       MSTD_NAME            VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37782
                                          CHECK (MSTD_NAME = Upper(MSTD_NAME)),
       Description          VARCHAR2(30) NOT NULL,
       LongDescription      VARCHAR2(200) NULL,
       SORTORDER            NUMBER(27) NULL,
       CONSTRAINT MSTD_INDEX0 
              PRIMARY KEY (MSTD_NAME)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

CREATE INDEX MSTD_INDEX1 ON OwnershipDurationDomain
(
       OtherName                      ASC
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE UPAddress (
       AddressID            NUMBER(27) NOT NULL,
       StreetName           VARCHAR2(80) NULL
                                   CONSTRAINT STRING_UCASE37783
                                          CHECK (StreetName = Upper(StreetName)),
       StreetName2          VARCHAR2(80) NULL
                                   CONSTRAINT STRING_UCASE37784
                                          CHECK (StreetName2 = Upper(StreetName2)),
       City                 VARCHAR2(30) NULL
                                   CONSTRAINT STRING_UCASE37785
                                          CHECK (City = Upper(City)),
       State                VARCHAR2(20) NULL,
       County               VARCHAR2(40) NULL,
       ZipCode              VARCHAR2(20) NULL,
       Country              VARCHAR2(40) NULL
                                   CONSTRAINT STRING_UCASE37786
                                          CHECK (Country = Upper(Country)),
       CONSTRAINT ADDR_INDEX0 
              PRIMARY KEY (AddressID)
       USING INDEX
              TABLESPACE MU_BIGIND
)
       TABLESPACE MU_BIGTAB
;

COMMENT ON COLUMN UPAddress.StreetName IS 're-ap-xx-xx.a015,re-ap-xx-xx.a055,re-ap-xx-xx.a090a,re-ap-xx-xx.a125a,hb-ap-xx-xx.a040,hb-ap-xx-xx.a040a,hb-ap-xx-xx.a090a,hb-ap-xx-xx.a125a';
COMMENT ON COLUMN UPAddress.StreetName2 IS 're-ap-xx-xx.a015,re-ap-xx-xx.a055,re-ap-xx-xx.a090a,re-ap-xx-xx.a125a,hb-ap-xx-xx.a040,hb-ap-xx-xx.a040a,hb-ap-xx-xx.a090a,hb-ap-xx-xx.a125a';
COMMENT ON COLUMN UPAddress.City IS 're-ap-xx-xx.a015,re-ap-xx-xx.a055,re-ap-xx-xx.a090a,re-ap-xx-xx.a125a,hb-ap-xx-xx.a040,hb-ap-xx-xx.a040a,hb-ap-xx-xx.a090a,hb-ap-xx-xx.a125a';
COMMENT ON COLUMN UPAddress.County IS 're-ap-xx-xx.a015,re-ap-xx-xx.a055,re-ap-xx-xx.a090a,re-ap-xx-xx.a125a,hb-ap-xx-xx.a040,hb-ap-xx-xx.a040a,hb-ap-xx-xx.a090a,hb-ap-xx-xx.a125a';
COMMENT ON COLUMN UPAddress.State IS 're-ap-xx-xx.a015,re-ap-xx-xx.a055,re-ap-xx-xx.a090a,re-ap-xx-xx.a125a,hb-ap-xx-xx.a040,hb-ap-xx-xx.a040a,hb-ap-xx-xx.a090a,hb-ap-xx-xx.a125a';
COMMENT ON COLUMN UPAddress.ZipCode IS 're-ap-xx-xx.a015,re-ap-xx-xx.a055,re-ap-xx-xx.a090a,re-ap-xx-xx.a125a,hb-ap-xx-xx.a040,hb-ap-xx-xx.a040a,hb-ap-xx-xx.a090a,hb-ap-xx-xx.a125a';
COMMENT ON COLUMN UPAddress.Country IS 're-ap-xx-xx.a015,re-ap-xx-xx.a055,re-ap-xx-xx.a090a,re-ap-xx-xx.a125a,hb-ap-xx-xx.a040,hb-ap-xx-xx.a040a,hb-ap-xx-xx.a090a,hb-ap-xx-xx.a125a';
CREATE INDEX ADDR_INDEX1 ON UPAddress
(
       Country                        ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX ADDR_INDEX2 ON UPAddress
(
       ZipCode                        ASC,
       State                          ASC,
       City                           ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX ADDR_INDEX3 ON UPAddress
(
       State                          ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX ADDR_INDEX4 ON UPAddress
(
       City                           ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX ADDR_INDEX6 ON UPAddress
(
       County                         ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX ADDR_INDEX5 ON UPAddress
(
       StreetName                     ASC
)
       TABLESPACE MU_BIGIND
;


CREATE OR REPLACE TRIGGER UPAddress_NO_UPDATE_OR_DELETE
BEFORE DELETE OR UPDATE ON UPAddress
--
BEGIN
--
RAISE_APPLICATION_ERROR(-20104,'UPAddress records can not be changed after creation');
--
END;
/


CREATE TABLE TypeOfPropertyDomain (
       OtherName            VARCHAR2(80) NOT NULL,
       PRTY_NAME            VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37787
                                          CHECK (PRTY_NAME = Upper(PRTY_NAME)),
       Description          VARCHAR2(30) NOT NULL,
       LongDescription      VARCHAR2(200) NULL,
       SORTORDER            NUMBER(27) NULL,
       CONSTRAINT PRTY_INDEX0 
              PRIMARY KEY (PRTY_NAME)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

CREATE INDEX PRTY_INDEX1 ON TypeOfPropertyDomain
(
       OtherName                      ASC
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE PropertyOccupancyDomain (
       OtherName            VARCHAR2(80) NOT NULL,
       PROC_NAME            VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37788
                                          CHECK (PROC_NAME = Upper(PROC_NAME)),
       Description          VARCHAR2(30) NOT NULL,
       LongDescription      VARCHAR2(200) NULL,
       SORTORDER            NUMBER(27) NULL,
       CONSTRAINT PROC_INDEX0 
              PRIMARY KEY (PROC_NAME)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

CREATE INDEX PROC_INDEX1 ON PropertyOccupancyDomain
(
       OtherName                      ASC
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE WAMUStateDomain (
       OtherName            VARCHAR2(80) NOT NULL,
       AITY_NAME            VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37789
                                          CHECK (AITY_NAME = Upper(AITY_NAME)),
       Description          VARCHAR2(30) NOT NULL,
       LongDescription      VARCHAR2(200) NULL,
       SORTORDER            NUMBER(27) NULL,
       CONSTRAINT AITY_INDEX0 
              PRIMARY KEY (AITY_NAME)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

CREATE INDEX AITY_INDEX1 ON WAMUStateDomain
(
       OtherName                      ASC
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE UP_USER (
       UserID               NUMBER(27) NOT NULL,
       PassWord             VARCHAR2(30) NOT NULL,
       NickName             VARCHAR2(80) NULL,
       Title                VARCHAR2(30) NULL,
       Email                VARCHAR2(80) NOT NULL,
       ForgotPasswordClue   VARCHAR2(200) NULL,
       brandid              NUMBER(27) NULL,
       username             VARCHAR2(80) NULL,
       forgotpasswordanswer VARCHAR2(200) NULL,
       birthdate            DATE NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6454
                                          CHECK (birthdate = TRUNC(birthdate)),
       MOTHERS_UNMARRIED_NAME VARCHAR2(80) NULL,
       CONSTRAINT SUSR_INDEX0 
              PRIMARY KEY (UserID)
       USING INDEX
              TABLESPACE MU_BIGIND,
       CONSTRAINT SUSR_INDEX1
       UNIQUE (
              Email
       )
       USING INDEX
              TABLESPACE MU_BIGIND
)
       TABLESPACE MU_BIGTAB
;


CREATE TABLE TitleHeldDomain (
       OtherName            VARCHAR2(80) NOT NULL,
       TLHD_NAME            VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37790
                                          CHECK (TLHD_NAME = Upper(TLHD_NAME)),
       Description          VARCHAR2(30) NOT NULL,
       LongDescription      VARCHAR2(200) NULL,
       SORTORDER            NUMBER(27) NULL,
       CONSTRAINT TLHD_INDEX0 
              PRIMARY KEY (TLHD_NAME)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

CREATE INDEX TLHD_INDEX1 ON TitleHeldDomain
(
       OtherName                      ASC
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE LoanPurposeDomain (
       OtherName            VARCHAR2(80) NULL,
       LPUR_NAME            VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37791
                                          CHECK (LPUR_NAME = Upper(LPUR_NAME)),
       Description          VARCHAR2(30) NOT NULL,
       LongDescription      VARCHAR2(200) NULL,
       SORTORDER            NUMBER(27) NULL,
       CONSTRAINT LPUR_INDEX0 
              PRIMARY KEY (LPUR_NAME)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

CREATE INDEX LPUR_INDEX1 ON LoanPurposeDomain
(
       OtherName                      ASC
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE UPApplication (
       APPLICATIONID        NUMBER(27) NOT NULL,
       USERID               NUMBER(27) NOT NULL,
       APPLICATION_STAGE_DOMAIN VARCHAR2(40) DEFAULT 'UNASSIGNED' NOT NULL
                                   CONSTRAINT STRING_UCASE37792
                                          CHECK (APPLICATION_STAGE_DOMAIN = Upper(APPLICATION_STAGE_DOMAIN)),
       PRE_STATE_DOMAIN     VARCHAR2(40) NULL
                                   CONSTRAINT STRING_UCASE37793
                                          CHECK (PRE_STATE_DOMAIN = Upper(PRE_STATE_DOMAIN)),
       APPLICATION_STAGE_EMPLOYEEID NUMBER(27) NULL,
       SUBMIT_DATETIME      DATE NULL,
       PRE_OCCUPANCY_DOMAIN VARCHAR2(40) NULL
                                   CONSTRAINT STRING_UCASE37794
                                          CHECK (PRE_OCCUPANCY_DOMAIN = Upper(PRE_OCCUPANCY_DOMAIN)),
       SUBMIT_USER          VARCHAR2(30) DEFAULT USER NOT NULL
                                   CONSTRAINT STRING_IS_UCASE2785
                                          CHECK (Upper(SUBMIT_USER) = SUBMIT_USER),
       MODIFY_DATETIME      DATE DEFAULT SYSDATE NOT NULL,
       PRE_PROPERTYTYPE_DOMAIN VARCHAR2(40) NULL
                                   CONSTRAINT STRING_UCASE37795
                                          CHECK (PRE_PROPERTYTYPE_DOMAIN = Upper(PRE_PROPERTYTYPE_DOMAIN)),
       MODIFY_USER          VARCHAR2(30) DEFAULT USER NULL
                                   CONSTRAINT STRING_IS_UCASE2786
                                          CHECK (Upper(MODIFY_USER) = MODIFY_USER),
       PRE_ESTIMATED_SALES_PRICE NUMBER(12,2) NULL,
       REQUESTED_AMOUNT     NUMBER(12,2) NULL,
       PRE_ESTIMATED_LOAN_AMOUNT NUMBER(12,2) NULL,
       RECO_LOAN_AMORT_MONTHS NUMBER(3) NULL
                                   CONSTRAINT GTR_EQ_08827
                                          CHECK (RECO_LOAN_AMORT_MONTHS >= 0),
       PROPERTY_ADDRESS_ID  NUMBER(27) NULL,
       OCCUPANCY_DOMAIN     VARCHAR2(40) NULL
                                   CONSTRAINT STRING_UCASE37796
                                          CHECK (OCCUPANCY_DOMAIN = Upper(OCCUPANCY_DOMAIN)),
       YEAR_BUILT           DATE NULL
                                   CONSTRAINT DATE_GTR_AD0233
                                          CHECK (YEAR_BUILT >= TO_DATE('01-JAN-1500','DD-MON-YYYY')),
       PROPERTY_TYPE_DOMAIN VARCHAR2(40) NULL
                                   CONSTRAINT STRING_UCASE37797
                                          CHECK (PROPERTY_TYPE_DOMAIN = Upper(PROPERTY_TYPE_DOMAIN)),
       PRE_TITLEHELD_DOMAIN VARCHAR2(40) NULL
                                   CONSTRAINT STRING_UCASE37798
                                          CHECK (PRE_TITLEHELD_DOMAIN = Upper(PRE_TITLEHELD_DOMAIN)),
       SELLER_FIRSTNAME     VARCHAR2(80) NULL,
       REFI_MTH_CURRENT_MORTGAGE NUMBER(12,2) NULL,
       SELLER_LASTNAME      VARCHAR2(80) NULL,
       REFI_CURR_MORTGAGE_HOLDER NUMBER(12,2) NULL,
       ESTIMATED_PROPERTY_PRICE NUMBER(12,2) NULL,
       REFI_CURR_MORTGAGE_NUMBER VARCHAR2(20) NULL,
       REFI_BAL_CURR_MORTGAGE NUMBER(12,2) NULL,
       SELLER_ADDRESS_ID    NUMBER(27) NULL,
       CURRENT_PROPERTY_USAGE_DOMAIN VARCHAR2(40) NULL
                                   CONSTRAINT STRING_UCASE37799
                                          CHECK (CURRENT_PROPERTY_USAGE_DOMAIN = Upper(CURRENT_PROPERTY_USAGE_DOMAIN)),
       LOAN_DOWNPAY_BORROWED_AMT NUMBER(12,2) NULL,
       LOAN_DOWNPAY_GIFT_AMT NUMBER(12,2) NULL,
       MTH_PROP_TAXES       NUMBER(12,2) NULL,
       MTH_HAZARD_INSURANCE NUMBER(12,2) NULL,
       MTH_FLOOD_INSURE     NUMBER(12,2) NULL,
       MTH_HOMEOWNERS_DUES  NUMBER(12,2) NULL,
       PRI_OWNERSHIP_YEARS_DOMAIN VARCHAR2(40) NULL
                                   CONSTRAINT STRING_UCASE37800
                                          CHECK (PRI_OWNERSHIP_YEARS_DOMAIN = Upper(PRI_OWNERSHIP_YEARS_DOMAIN)),
       HOMEOWNERS_ASSOC_NAME VARCHAR2(80) NULL,
       PRI_LOAN_GOAL        VARCHAR2(1) NULL,
       PRI_LESS_INCOME_DOCS_YN VARCHAR2(1) NULL
                                   CONSTRAINT IS_Y_OR_N7390
                                          CHECK (PRI_LESS_INCOME_DOCS_YN IN ('Y','N')),
       LOAN_REALTOR_FIRSTNAME VARCHAR2(80) NULL,
       PRI_INCOME_TREND     VARCHAR2(1) NULL,
       HOMEOWNERS_ASSOC_PHONE VARCHAR2(20) NULL
                                   CONSTRAINT STRING_IS_NUMBERS231
                                          CHECK (Replace(HOMEOWNERS_ASSOC_PHONE,'0123467890','') = ''),
       PRI_GROWING_FAMILY_YN VARCHAR2(1) NULL
                                   CONSTRAINT IS_Y_OR_N7391
                                          CHECK (PRI_GROWING_FAMILY_YN IN ('Y','N')),
       LOAN_REALTOR_PHONE   VARCHAR2(20) NULL,
       PRI_COLLEGE_TUITION_YN VARCHAR2(1) NULL
                                   CONSTRAINT IS_Y_OR_N7392
                                          CHECK (PRI_COLLEGE_TUITION_YN IN ('Y','N')),
       DESIRED_CLOSE_DATE   DATE NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6455
                                          CHECK (DESIRED_CLOSE_DATE = TRUNC(DESIRED_CLOSE_DATE)),
       PRI_INVESTING_YN     VARCHAR2(1) NULL
                                   CONSTRAINT IS_Y_OR_N7393
                                          CHECK (PRI_INVESTING_YN IN ('Y','N')),
       PRI_DISPOSABLE_INCOME_YN VARCHAR2(1) NULL
                                   CONSTRAINT IS_Y_OR_N7394
                                          CHECK (PRI_DISPOSABLE_INCOME_YN IN ('Y','N')),
       LOAN_REALTOR_FIRM_NAME VARCHAR2(80) NULL,
       ESCROW_TAXES_YN      VARCHAR2(1) NULL
                                   CONSTRAINT IS_Y_OR_N7395
                                          CHECK (ESCROW_TAXES_YN IN ('Y','N')),
       PRIOR_OWNERSHIP_DOMAIN VARCHAR2(40) NULL
                                   CONSTRAINT STRING_UCASE37801
                                          CHECK (PRIOR_OWNERSHIP_DOMAIN = Upper(PRIOR_OWNERSHIP_DOMAIN)),
       PRI_RETIREMENT_YN    VARCHAR2(1) NULL
                                   CONSTRAINT IS_Y_OR_N7396
                                          CHECK (PRI_RETIREMENT_YN IN ('Y','N')),
       PRI_CONSERVE_INVESTOR_YN VARCHAR2(1) NULL
                                   CONSTRAINT IS_Y_OR_N7397
                                          CHECK (PRI_CONSERVE_INVESTOR_YN IN ('Y','N')),
       PRI_PREPAY_PENALTY_OK_DOMAIN VARCHAR2(40) NULL
                                   CONSTRAINT STRING_UCASE37802
                                          CHECK (PRI_PREPAY_PENALTY_OK_DOMAIN = Upper(PRI_PREPAY_PENALTY_OK_DOMAIN)),
       ESCROW_INSURE_YN     VARCHAR2(1) NULL
                                   CONSTRAINT IS_Y_OR_N7398
                                          CHECK (ESCROW_INSURE_YN IN ('Y','N')),
       AUTOPAY_YN           VARCHAR2(1) NULL
                                   CONSTRAINT IS_Y_OR_N7399
                                          CHECK (AUTOPAY_YN IN ('Y','N')),
       PRI_INVEST_RETURN    VARCHAR(5) NULL,
       PRI_RATE_LOCK_PERIOD NUMBER(3) DEFAULT 30 NULL,
       RECO_LOAN_TYPE       VARCHAR2(200) NULL,
       RECO_LOAN_AMOUNT     NUMBER(12,2) NULL,
       LOAN_REALTOR_LASTNAME VARCHAR2(80) NULL,
       RECO_LOAN_DOWNPAYMENT NUMBER(12,2) NULL,
       RECO_MTH_PAYMENT     NUMBER(12,2) NULL,
       RECO_MTH_MORTGAGE_INSURE NUMBER(12,2) NULL,
       TITLEHELD_DOMAIN     VARCHAR2(40) NULL
                                   CONSTRAINT STRING_UCASE37803
                                          CHECK (TITLEHELD_DOMAIN = Upper(TITLEHELD_DOMAIN)),
       RECO_LOAN_RATE       NUMBER(6,3) NULL,
       LOAN_PURPOSE_DOMAIN  VARCHAR2(40) DEFAULT 'PURCHASE' NULL
                                   CONSTRAINT STRING_UCASE37804
                                          CHECK (LOAN_PURPOSE_DOMAIN = Upper(LOAN_PURPOSE_DOMAIN)),
       RECO_LOAN_APR        NUMBER(6,3) NULL,
       RECO_LOAN_AIR        NUMBER(6,3) NULL,
       RECO_LOAN_MARGIN     NUMBER(5,3) NULL,
       PRE_DOWNPAYMENT_GIFT_AMT NUMBER(12,2) NULL,
       PRE_DOWNPAYMENT_BORROWED_AMT NUMBER(12,2) NULL,
       RECO_LOAN_FEE_POINTS NUMBER NULL,
       LAND_IS_LEASED_YN    VARCHAR2(1) DEFAULT 'Y' NULL
                                   CONSTRAINT IS_Y_OR_N7400
                                          CHECK (LAND_IS_LEASED_YN IN ('Y','N')),
       CREATEDATE           DATE DEFAULT SYSDATE NOT NULL,
       RECO_1ST_PAYMENT_ADJUST NUMBER(3) NULL
                                   CONSTRAINT GTR_EQ_08828
                                          CHECK (RECO_1ST_PAYMENT_ADJUST >= 0),
       RECO_LOAN_AMORT_MONTHS_DOMAIN VARCHAR2(40) NULL
                                   CONSTRAINT STRING_UCASE37805
                                          CHECK (RECO_LOAN_AMORT_MONTHS_DOMAIN = Upper(RECO_LOAN_AMORT_MONTHS_DOMAIN)),
       RECO_NEXT_PAYMENT_ADJUST NUMBER(3) NULL
                                   CONSTRAINT GTR_EQ_08829
                                          CHECK (RECO_NEXT_PAYMENT_ADJUST >= 0),
       RECO_1ST_PAYMENT_ADJUST_DOMAIN VARCHAR2(40) NULL
                                   CONSTRAINT STRING_UCASE37806
                                          CHECK (RECO_1ST_PAYMENT_ADJUST_DOMAIN = Upper(RECO_1ST_PAYMENT_ADJUST_DOMAIN)),
       RECO_PERIODIC_RATE_CAP NUMBER(6,3) NULL,
       RECO_PAYMENT_CAP     VARCHAR2(80) NULL,
       RECO_NEXT_PAYMENT_ADJ_DOMAIN VARCHAR2(40) NULL
                                   CONSTRAINT STRING_UCASE37807
                                          CHECK (RECO_NEXT_PAYMENT_ADJ_DOMAIN = Upper(RECO_NEXT_PAYMENT_ADJ_DOMAIN)),
       RECO_LIFE_CAP        NUMBER(6,3) NULL,
       RECO_NEGATIVE_AMORT_DOMAIN VARCHAR2(40) NULL
                                   CONSTRAINT STRING_UCASE37808
                                          CHECK (RECO_NEGATIVE_AMORT_DOMAIN = Upper(RECO_NEGATIVE_AMORT_DOMAIN)),
       AGENCY_CASE_NUMBER   VARCHAR2(20) NULL,
       LENDER_CASE_NUMBER   VARCHAR2(20) NULL,
       LEGAL_DESCRIPTION    VARCHAR2(80) NULL,
       LOAN_PURPOSE         VARCHAR2(80) NULL,
       REFI_PURPOSE         VARCHAR2(80) NULL,
       REFI_IMPROVEMENTS_MADE NUMBER(12,2) NULL,
       REFI_IMPROVEMENTS_TO_BE_MADE NUMBER(12,2) NULL,
       LOAN_TITLE_HELD_NAME VARCHAR2(80) NULL,
       DOWNPAYMENT_EXPLANATION VARCHAR2(200) NULL,
       LOAN_LEASE_EXPIRY_DATE DATE NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6456
                                          CHECK (LOAN_LEASE_EXPIRY_DATE = TRUNC(LOAN_LEASE_EXPIRY_DATE)),
       CONSTRAINT PROP_INDEX0 
              PRIMARY KEY (APPLICATIONID)
       USING INDEX
              TABLESPACE MU_BIGIND, 
       CONSTRAINT R_191
              FOREIGN KEY (RECO_NEXT_PAYMENT_ADJ_DOMAIN)
                             REFERENCES NextpaymentAdjustDomain, 
       CONSTRAINT R_190
              FOREIGN KEY (RECO_1ST_PAYMENT_ADJUST_DOMAIN)
                             REFERENCES FirstPaymentAdjustDomain, 
       CONSTRAINT R_181
              FOREIGN KEY (RECO_LOAN_AMORT_MONTHS_DOMAIN)
                             REFERENCES AmortizationTermDomain, 
       CONSTRAINT R_180
              FOREIGN KEY (RECO_NEGATIVE_AMORT_DOMAIN)
                             REFERENCES NegativeAmortDomain, 
       CONSTRAINT R_179
              FOREIGN KEY (PRI_PREPAY_PENALTY_OK_DOMAIN)
                             REFERENCES PrepayPenaltyDomain, 
       CONSTRAINT R_170
              FOREIGN KEY (CURRENT_PROPERTY_USAGE_DOMAIN)
                             REFERENCES PropertyUsageDomain, 
       CONSTRAINT R_169
              FOREIGN KEY (PRIOR_OWNERSHIP_DOMAIN)
                             REFERENCES OwnershipInterestDomain, 
       CONSTRAINT R_161
              FOREIGN KEY (APPLICATION_STAGE_EMPLOYEEID)
                             REFERENCES WAMU_EMPLOYEE, 
       CONSTRAINT R_144
              FOREIGN KEY (PRI_OWNERSHIP_YEARS_DOMAIN)
                             REFERENCES OwnershipDurationDomain, 
       CONSTRAINT R_136
              FOREIGN KEY (SELLER_ADDRESS_ID)
                             REFERENCES UPAddress, 
       CONSTRAINT R_135
              FOREIGN KEY (PROPERTY_TYPE_DOMAIN)
                             REFERENCES TypeOfPropertyDomain, 
       CONSTRAINT R_134
              FOREIGN KEY (PROPERTY_ADDRESS_ID)
                             REFERENCES UPAddress, 
       CONSTRAINT R_133
              FOREIGN KEY (PRE_PROPERTYTYPE_DOMAIN)
                             REFERENCES TypeOfPropertyDomain
                             ON DELETE CASCADE, 
       CONSTRAINT R_132
              FOREIGN KEY (PRE_OCCUPANCY_DOMAIN)
                             REFERENCES PropertyOccupancyDomain, 
       CONSTRAINT R_131
              FOREIGN KEY (OCCUPANCY_DOMAIN)
                             REFERENCES PropertyOccupancyDomain, 
       CONSTRAINT R_129
              FOREIGN KEY (PRE_STATE_DOMAIN)
                             REFERENCES WAMUStateDomain, 
       CONSTRAINT R_128
              FOREIGN KEY (APPLICATION_STAGE_DOMAIN)
                             REFERENCES ApplicationStageDomain, 
       CONSTRAINT R_99
              FOREIGN KEY (USERID)
                             REFERENCES UP_USER
                             ON DELETE CASCADE, 
       CONSTRAINT R_73
              FOREIGN KEY (TITLEHELD_DOMAIN)
                             REFERENCES TitleHeldDomain, 
       CONSTRAINT R_72
              FOREIGN KEY (LOAN_PURPOSE_DOMAIN)
                             REFERENCES LoanPurposeDomain
)
       TABLESPACE MU_BIGTAB
;

COMMENT ON COLUMN UPApplication.APPLICATIONID IS 'Internal';
COMMENT ON COLUMN UPApplication.USERID IS 'Internal';
COMMENT ON COLUMN UPApplication.APPLICATION_STAGE_DOMAIN IS 'Internal';
COMMENT ON COLUMN UPApplication.CREATEDATE IS 'Record creation timestamp.';
COMMENT ON COLUMN UPApplication.SUBMIT_DATETIME IS 'When Application was created in DB.';
COMMENT ON COLUMN UPApplication.SUBMIT_USER IS 'Oracle User who created application';
COMMENT ON COLUMN UPApplication.LOAN_PURPOSE_DOMAIN IS 'REFI or LOAN';
COMMENT ON COLUMN UPApplication.PRE_STATE_DOMAIN IS 'PreApproval US State. hb-ap-xx-xx.a030';
COMMENT ON COLUMN UPApplication.PRE_OCCUPANCY_DOMAIN IS 'preApproval Occupany Type. hb-ap-xx-xx.a030';
COMMENT ON COLUMN UPApplication.PRE_PROPERTYTYPE_DOMAIN IS 'PreApproval property Type. hb-ap-xx-xx.a030';
COMMENT ON COLUMN UPApplication.PRE_ESTIMATED_SALES_PRICE IS 'Preapproval estimated sales price. hb-ap-xx-xx.a030';
COMMENT ON COLUMN UPApplication.PRE_ESTIMATED_LOAN_AMOUNT IS 'Preapproval estimated load amount. hb-ap-xx-xx.a030';
COMMENT ON COLUMN UPApplication.PRE_DOWNPAYMENT_BORROWED_AMT IS 'Preapproval AnyPartOfDonwpaymentBorrowed flag. hb-ap-xx-xx.a030';
COMMENT ON COLUMN UPApplication.PRE_DOWNPAYMENT_GIFT_AMT IS 'Preapproval any part of downpayment a gift. hb-ap-xx-xx.a030';
COMMENT ON COLUMN UPApplication.PRE_TITLEHELD_DOMAIN IS 'Preapproval title held in. hb-ap-xx-xx.a030';
COMMENT ON COLUMN UPApplication.PROPERTY_ADDRESS_ID IS 'Interrnal ID of propertyaddress. re-ap-xx-xx.a015,hb-ap-xx-xx.a040,1003-II-SubjectPropertyAddress';
COMMENT ON COLUMN UPApplication.YEAR_BUILT IS 're-ap-xx-xx.a015,hb-ap-xx-xx.a040,1003-II-YearBuilt';
COMMENT ON COLUMN UPApplication.OCCUPANCY_DOMAIN IS 'Occupancy Type for property. re-ap-xx-xx.a015,hb-ap-xx-xx.a040,1003-II-PropertyWillBe';
COMMENT ON COLUMN UPApplication.PROPERTY_TYPE_DOMAIN IS 'Type of Proeprty . re-ap-xx-xx.a015,hb-ap-xx-xx.a040';
COMMENT ON COLUMN UPApplication.LAND_IS_LEASED_YN IS 'Whether land is leased or not. re-ap-xx-xx.a015,hb-ap-xx-xx.a040';
COMMENT ON COLUMN UPApplication.SELLER_FIRSTNAME IS 'CO Property Seller First Name. hb-ap-xx-xx.a040a';
COMMENT ON COLUMN UPApplication.SELLER_LASTNAME IS 'CO Property Seller Last name. hb-ap-xx-xx.a040a';
COMMENT ON COLUMN UPApplication.SELLER_ADDRESS_ID IS 'CO Property Seller Address Identifer. hb-ap-xx-xx.a040a';
COMMENT ON COLUMN UPApplication.ESTIMATED_PROPERTY_PRICE IS 'Property price. re-ap-xx-xx.a040,hb-ap-xx-xx.a045,1003-II-RefineceOriginalCost,1003-VII-PurchasePrice';
COMMENT ON COLUMN UPApplication.REQUESTED_AMOUNT IS 'Requested Amount. re-ap-xx-xx.a040,hb-ap-xx-xx.a045';
COMMENT ON COLUMN UPApplication.LOAN_DOWNPAY_BORROWED_AMT IS 'Any part of loan downpayment borrowed flag. hb-ap-xx-xx.a045';
COMMENT ON COLUMN UPApplication.LOAN_DOWNPAY_GIFT_AMT IS 'Any part of loan downpayment gift flag. hb-ap-xx-xx.a045';
COMMENT ON COLUMN UPApplication.REFI_MTH_CURRENT_MORTGAGE IS 'Current Mortgage if refinancing. re-ap-xx-xx.a040';
COMMENT ON COLUMN UPApplication.REFI_CURR_MORTGAGE_HOLDER IS 'mortgage holder  if refinancing.re-ap-xx-xx.a040';
COMMENT ON COLUMN UPApplication.REFI_CURR_MORTGAGE_NUMBER IS 'Current mortgage account number  if refinancing.re-ap-xx-xx.a040';
COMMENT ON COLUMN UPApplication.REFI_BAL_CURR_MORTGAGE IS 'Balance of current mortgage  ifrefinancing. re-ap-xx-xx.a040,1003-II-AmountExistingLiens';
COMMENT ON COLUMN UPApplication.MTH_PROP_TAXES IS 'Mpnthly proprerty taxes. re-ap-xx-xx.a040,hb-ap-xx-xx.a045';
COMMENT ON COLUMN UPApplication.MTH_HAZARD_INSURANCE IS 'Monthly Hazard Insurance. re-ap-xx-xx.a040,hb-ap-xx-xx.a045';
COMMENT ON COLUMN UPApplication.MTH_FLOOD_INSURE IS 'Monthly Flood insurance. re-ap-xx-xx.a040,hb-ap-xx-xx.a045';
COMMENT ON COLUMN UPApplication.MTH_HOMEOWNERS_DUES IS 'Monthly Homeowners association dues. re-ap-xx-xx.a040,hb-ap-xx-xx.a045';
COMMENT ON COLUMN UPApplication.HOMEOWNERS_ASSOC_NAME IS 'Homeowners association Name. re-ap-xx-xx.a040,hb-ap-xx-xx.a045';
COMMENT ON COLUMN UPApplication.HOMEOWNERS_ASSOC_PHONE IS 'Homeowners association phone number. re-ap-xx-xx.a040,hb-ap-xx-xx.a045';
COMMENT ON COLUMN UPApplication.TITLEHELD_DOMAIN IS 'Form title will be held in. re-ap-xx-xx.a040,hb-ap-xx-xx.a045,1003-II-Manner';
COMMENT ON COLUMN UPApplication.DESIRED_CLOSE_DATE IS 'Desired Close Date. re-ap-xx-xx.a040,hb-ap-xx-xx.a045';
COMMENT ON COLUMN UPApplication.ESCROW_TAXES_YN IS 'Put taxes in Escrow YN. re-ap-xx-xx.a040,hb-ap-xx-xx.a045';
COMMENT ON COLUMN UPApplication.ESCROW_INSURE_YN IS 'Put insurance in Escrow YN. re-ap-xx-xx.a040,hb-ap-xx-xx.a045';
COMMENT ON COLUMN UPApplication.AUTOPAY_YN IS 'Make payments automaticly YN. re-ap-xx-xx.a040,hb-ap-xx-xx.a045';
COMMENT ON COLUMN UPApplication.LOAN_REALTOR_FIRSTNAME IS 'Realtor first Name. hb-ap-xx-xx.a045';
COMMENT ON COLUMN UPApplication.LOAN_REALTOR_LASTNAME IS 'Realtor Last Name. hb-ap-xx-xx.a045';
COMMENT ON COLUMN UPApplication.LOAN_REALTOR_PHONE IS 'Realtor Phone Number. hb-ap-xx-xx.a045';
COMMENT ON COLUMN UPApplication.LOAN_REALTOR_FIRM_NAME IS 'Real estate agency name. hb-ap-xx-xx.a045';
COMMENT ON COLUMN UPApplication.PRIOR_OWNERSHIP_DOMAIN IS '%AttDef';
COMMENT ON COLUMN UPApplication.PRI_OWNERSHIP_YEARS_DOMAIN IS 'Priorities: How long will be owned? re-ap-xx-xx.a155,hb-ap-xx-xx.a155';
COMMENT ON COLUMN UPApplication.PRI_LOAN_GOAL IS 'Priorities: Lowest X. re-ap-xx-xx.a155,hb-ap-xx-xx.a155 (7,8,9,10,12)';
COMMENT ON COLUMN UPApplication.PRI_LESS_INCOME_DOCS_YN IS 'Priorities: less documentation of income. re-ap-xx-xx.a155,hb-ap-xx-xx.a155';
COMMENT ON COLUMN UPApplication.PRI_PREPAY_PENALTY_OK_DOMAIN IS '%AttDef';
COMMENT ON COLUMN UPApplication.PRI_INCOME_TREND IS 'Priorities:Will my income go up or down? re-ap-xx-xx.a155,hb-ap-xx-xx.a155';
COMMENT ON COLUMN UPApplication.PRI_GROWING_FAMILY_YN IS 'Priorities: Have growing family. re-ap-xx-xx.a155,hb-ap-xx-xx.a155';
COMMENT ON COLUMN UPApplication.PRI_COLLEGE_TUITION_YN IS 'Priorities: College tuition. re-ap-xx-xx.a155,hb-ap-xx-xx.a155';
COMMENT ON COLUMN UPApplication.PRI_INVESTING_YN IS 'Priorities: Investing  re-ap-xx-xx.a155,hb-ap-xx-xx.a155';
COMMENT ON COLUMN UPApplication.PRI_DISPOSABLE_INCOME_YN IS 'Priorities: Having disposable income. re-ap-xx-xx.a155,hb-ap-xx-xx.a155';
COMMENT ON COLUMN UPApplication.PRI_RETIREMENT_YN IS 'Priorities: Approaching retirement. re-ap-xx-xx.a155,hb-ap-xx-xx.a155';
COMMENT ON COLUMN UPApplication.PRI_CONSERVE_INVESTOR_YN IS 'Priorities: Conservative investor. re-ap-xx-xx.a155,hb-ap-xx-xx.a155';
COMMENT ON COLUMN UPApplication.PRI_INVEST_RETURN IS 'Priorities: Expected return on investments. re-ap-xx-xx.a155,hb-ap-xx-xx.a155';
COMMENT ON COLUMN UPApplication.PRI_RATE_LOCK_PERIOD IS 'Priorities:: Rate lock period. re-ap-xx-xx.a160,hb-ap-xx-xx.a160  (defaults to 30 days)';
COMMENT ON COLUMN UPApplication.RECO_LOAN_TYPE IS 'Recomended Loan Type. re-ap-xx-xx.a160,re-ap-xx-xx.a170,hb-ap-xx-xx.a160,hb-ap-xx-xx.a170,1003-I-MortageAppliedFor';
COMMENT ON COLUMN UPApplication.RECO_LOAN_AMOUNT IS 'Recomended Loan Amount. re-ap-xx-xx.a160,re-ap-xx-xx.a170,1003-I-Amount,1003-VIII-m';
COMMENT ON COLUMN UPApplication.RECO_LOAN_DOWNPAYMENT IS 'Recomended Loan: Downpayment re-ap-xx-xx.a160,hb-ap-xx-xx.a160';
COMMENT ON COLUMN UPApplication.RECO_MTH_PAYMENT IS 'Recomended Monthly Payment.re-ap-xx-xx.a160,re-ap-xx-xx.a170,hb-ap-xx-xx.a160,hb-ap-xx-xx.a170';
COMMENT ON COLUMN UPApplication.RECO_MTH_MORTGAGE_INSURE IS 'Recomended Loan monthly insurance. re-ap-xx-xx.a160,re-ap-xx-xx.a170,hb-ap-xx-xx.a160,hb-ap-xx-xx.a170,1003-VIII-n';
COMMENT ON COLUMN UPApplication.RECO_LOAN_RATE IS 'Recomended Loan: Rate. re-ap-xx-xx.a160,re-ap-xx-xx.a170,hb-ap-xx-xx.a160,hb-ap-xx-xx.a170';
COMMENT ON COLUMN UPApplication.RECO_LOAN_APR IS 'Recomended Loan: APR. re-ap-xx-xx.a160,re-ap-xx-xx.a170,hb-ap-xx-xx.a160,hb-ap-xx-xx.a170,1003-I-InterestRate';
COMMENT ON COLUMN UPApplication.RECO_LOAN_AIR IS 'Recomended Loan: AIR re-ap-xx-xx.a160,hb-ap-xx-xx.a160';
COMMENT ON COLUMN UPApplication.RECO_LOAN_MARGIN IS 'Recomended Loan: Margin. re-ap-xx-xx.a160,hb-ap-xx-xx.a160';
COMMENT ON COLUMN UPApplication.RECO_LOAN_FEE_POINTS IS 'Recomended Loan: Fee Points. re-ap-xx-xx.a160,hb-ap-xx-xx.a160,1003-VII-n';
COMMENT ON COLUMN UPApplication.RECO_LOAN_AMORT_MONTHS IS 'Recomended Loan: Amortization Months. re-ap-xx-xx.a170,hb-ap-xx-xx.a170,1003-I-NoOfMonths';
COMMENT ON COLUMN UPApplication.RECO_LOAN_AMORT_MONTHS_DOMAIN IS '%AttDef';
COMMENT ON COLUMN UPApplication.RECO_1ST_PAYMENT_ADJUST IS 'Recomended Loan: 1st Payment  adjustment. re-ap-xx-xx.a170,hb-ap-xx-xx.a170';
COMMENT ON COLUMN UPApplication.RECO_1ST_PAYMENT_ADJUST_DOMAIN IS '%AttDef';
COMMENT ON COLUMN UPApplication.RECO_NEXT_PAYMENT_ADJUST IS 'Recomended Loan: Next payment adjustment. re-ap-xx-xx.a170,hb-ap-xx-xx.a170';
COMMENT ON COLUMN UPApplication.RECO_NEXT_PAYMENT_ADJ_DOMAIN IS '%AttDef';
COMMENT ON COLUMN UPApplication.RECO_PERIODIC_RATE_CAP IS 'Recomended Loan: Periodic Rate cap. re-ap-xx-xx.a170,hb-ap-xx-xx.a170';
COMMENT ON COLUMN UPApplication.RECO_PAYMENT_CAP IS 'Recomended Loan: Payment cap. re-ap-xx-xx.a170,hb-ap-xx-xx.a170';
COMMENT ON COLUMN UPApplication.RECO_LIFE_CAP IS 'Recomended Loan: Lifetime cap. re-ap-xx-xx.a170,hb-ap-xx-xx.a170';
COMMENT ON COLUMN UPApplication.RECO_NEGATIVE_AMORT_DOMAIN IS '%AttDef';
COMMENT ON COLUMN UPApplication.AGENCY_CASE_NUMBER IS '1003-I-AgencyCaseNumber';
COMMENT ON COLUMN UPApplication.LENDER_CASE_NUMBER IS '1003-I-LenderCaseNumber';
COMMENT ON COLUMN UPApplication.LEGAL_DESCRIPTION IS '1003-II-LegalDescription';
COMMENT ON COLUMN UPApplication.LOAN_PURPOSE IS '1003-II-LoanPurpose';
COMMENT ON COLUMN UPApplication.REFI_PURPOSE IS '1003-II-PurposeOfRefinance';
COMMENT ON COLUMN UPApplication.REFI_IMPROVEMENTS_MADE IS '1003-II-DecribeImprovementsMade';
COMMENT ON COLUMN UPApplication.REFI_IMPROVEMENTS_TO_BE_MADE IS '1003-II-DecribeImprovementsToBeMade';
COMMENT ON COLUMN UPApplication.LOAN_TITLE_HELD_NAME IS '1003-II-TitleHeldInName';
COMMENT ON COLUMN UPApplication.DOWNPAYMENT_EXPLANATION IS '1003-II-SourceOfDownpayment';
COMMENT ON COLUMN UPApplication.LOAN_LEASE_EXPIRY_DATE IS '1003-II-EstateWillBeHeldInFeeSimpleLeasehold(ShowExpireDate)';
CREATE INDEX PROP_INDEX1 ON UPApplication
(
       APPLICATION_STAGE_DOMAIN       ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX PROP_INDEX6 ON UPApplication
(
       PROPERTY_ADDRESS_ID            ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX PROP_INDEX8 ON UPApplication
(
       SELLER_ADDRESS_ID              ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX PROP_INDEX10 ON UPApplication
(
       APPLICATION_STAGE_EMPLOYEEID   ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX PROP_INDEX13 ON UPApplication
(
       USERID                         ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX PROP_INDEX14 ON UPApplication
(
       SUBMIT_DATETIME                ASC
)
       TABLESPACE MU_BIGIND
;


CREATE TABLE WAMU_APPLICATION_DATA (
       APPLICATIONID        NUMBER(27) NOT NULL,
       APPLICATION_STAGE_DOMAIN VARCHAR2(40) NULL
                                   CONSTRAINT STRING_UCASE37809
                                          CHECK (APPLICATION_STAGE_DOMAIN = Upper(APPLICATION_STAGE_DOMAIN)),
       PRIMARY_CONTACT_ROLE_DOMAIN VARCHAR2(40) DEFAULT 'LC3' NULL
                                   CONSTRAINT STRING_UCASE37810
                                          CHECK (PRIMARY_CONTACT_ROLE_DOMAIN = Upper(PRIMARY_CONTACT_ROLE_DOMAIN)),
       LOAN_AMORT_MONTHS_DOMAIN VARCHAR2(40) NULL
                                   CONSTRAINT STRING_UCASE37811
                                          CHECK (LOAN_AMORT_MONTHS_DOMAIN = Upper(LOAN_AMORT_MONTHS_DOMAIN)),
       APPLICATION_STAGE_EMPLOYEEID NUMBER(27) NULL,
       LOAN_TYPE_DOMAIN     VARCHAR2(200) NULL
                                   CONSTRAINT STRING_UCASE37812
                                          CHECK (LOAN_TYPE_DOMAIN = Upper(LOAN_TYPE_DOMAIN)),
       MODIFY_DATETIME      DATE DEFAULT SYSDATE NOT NULL,
       MODIFY_USER          VARCHAR2(30) DEFAULT USER NULL
                                   CONSTRAINT STRING_IS_UCASE2787
                                          CHECK (Upper(MODIFY_USER) = MODIFY_USER),
       LOAN_NEGA_AMORT_DOMAIN VARCHAR2(40) NULL
                                   CONSTRAINT STRING_UCASE37813
                                          CHECK (LOAN_NEGA_AMORT_DOMAIN = Upper(LOAN_NEGA_AMORT_DOMAIN)),
       LOAN_PAYMENT_CAP_DOMAIN VARCHAR2(40) NULL
                                   CONSTRAINT STRING_UCASE37814
                                          CHECK (LOAN_PAYMENT_CAP_DOMAIN = Upper(LOAN_PAYMENT_CAP_DOMAIN)),
       REQUESTED_AMOUNT     NUMBER(12,2) NULL,
       LOAN_PREPAY_PENALTY_DOMAIN VARCHAR2(40) NULL
                                   CONSTRAINT STRING_UCASE37815
                                          CHECK (LOAN_PREPAY_PENALTY_DOMAIN = Upper(LOAN_PREPAY_PENALTY_DOMAIN)),
       CREATEDATE           DATE DEFAULT SYSDATE NOT NULL,
       PREFER_CONTACT_METHOD VARCHAR2(2) DEFAULT 'E1' NOT NULL
                                   CONSTRAINT MINIMU_CONTACT_METHODS170
                                          CHECK (PREFER_CONTACT_METHOD IN 
                                                ('A' /* Address */
                                                ,'P' /* Home Phone */
                                                ,'W' /* Work Phone */
                                                ,'C' /* Cell Phone */
                                                ,'F' /* Fax */
                                                ,'WF' /* Work Fax */
                                                ,'PG' /* Pager */
                                                ,'E1' /* Primary Email */
                                                ,'E2' /* Other Email */)
                                                ),
       APP_SENT_CONTRACT    DATE NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6457
                                          CHECK (APP_SENT_CONTRACT = TRUNC(APP_SENT_CONTRACT)),
       APP_RECD_CONTRACT    DATE NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6458
                                          CHECK (APP_RECD_CONTRACT = TRUNC(APP_RECD_CONTRACT)),
       LOAN_1ST_PAYMENT_ADJUST_DOMAIN VARCHAR2(40) NULL
                                   CONSTRAINT STRING_UCASE37816
                                          CHECK (LOAN_1ST_PAYMENT_ADJUST_DOMAIN = Upper(LOAN_1ST_PAYMENT_ADJUST_DOMAIN)),
       LOAN_RATE            NUMBER(6,3) NULL,
       RATE_LOCK_REQUEST    DATE NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6459
                                          CHECK (RATE_LOCK_REQUEST = TRUNC(RATE_LOCK_REQUEST)),
       LOAN_NEXT_PAYMENT_ADJ_DOMAIN VARCHAR2(40) NULL
                                   CONSTRAINT STRING_UCASE37817
                                          CHECK (LOAN_NEXT_PAYMENT_ADJ_DOMAIN = Upper(LOAN_NEXT_PAYMENT_ADJ_DOMAIN)),
       LOAN_APR             NUMBER(6,3) NULL,
       LOAN_POINTS          NUMBER(4,3) NULL,
       RATE_LOCK_CONFIRM    DATE NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6460
                                          CHECK (RATE_LOCK_CONFIRM = TRUNC(RATE_LOCK_CONFIRM)),
       RATE_LOCK_EXPIRE     DATE NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6461
                                          CHECK (RATE_LOCK_EXPIRE = TRUNC(RATE_LOCK_EXPIRE)),
       DISC_PACK_SENT       DATE NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6462
                                          CHECK (DISC_PACK_SENT = TRUNC(DISC_PACK_SENT)),
       LOAN_NEXT_PAYMENT_ADJUST NUMBER(3) NULL
                                   CONSTRAINT GTR_EQ_08830
                                          CHECK (LOAN_NEXT_PAYMENT_ADJUST >= 0),
       DISC_PACK_SIGNED     DATE NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6463
                                          CHECK (DISC_PACK_SIGNED = TRUNC(DISC_PACK_SIGNED)),
       DISC_PACK_RECD       DATE NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6464
                                          CHECK (DISC_PACK_RECD = TRUNC(DISC_PACK_RECD)),
       LOAN_PERIODIC_RATE_CAP NUMBER(6,3) NULL,
       LOAN_LIFE_CAP        NUMBER(6,3) NULL,
       LOAN_MTH_PAYMENT     NUMBER(12,2) NULL,
       LOAN_MTH_INSURANCE   NUMBER(12,2) NULL,
       UND_LOAN_SENT_UNDERWRITING DATE NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6465
                                          CHECK (UND_LOAN_SENT_UNDERWRITING = TRUNC(UND_LOAN_SENT_UNDERWRITING)),
       UND_CUSTOMER_MESSAGE_STRING VARCHAR2(80) NULL,
       UND_COMMITMENT_LETTER_SENT DATE NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6466
                                          CHECK (UND_COMMITMENT_LETTER_SENT = TRUNC(UND_COMMITMENT_LETTER_SENT)),
       LDR_CREDIT_RPT_RECD  DATE NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6467
                                          CHECK (LDR_CREDIT_RPT_RECD = TRUNC(LDR_CREDIT_RPT_RECD)),
       LDR_TITLE_CO         VARCHAR2(80) NULL,
       LDR_TITLE_RPT_ORDERED DATE NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6468
                                          CHECK (LDR_TITLE_RPT_ORDERED = TRUNC(LDR_TITLE_RPT_ORDERED)),
       LDR_TITLE_RPT_RECD   DATE NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6469
                                          CHECK (LDR_TITLE_RPT_RECD = TRUNC(LDR_TITLE_RPT_RECD)),
       LDR_APPRAISE_ORDERED DATE NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6470
                                          CHECK (LDR_APPRAISE_ORDERED = TRUNC(LDR_APPRAISE_ORDERED)),
       LDR_APPRAISE_EST_COST NUMBER(12,2) NULL,
       LDR_APPRAISE_RECD    DATE NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6471
                                          CHECK (LDR_APPRAISE_RECD = TRUNC(LDR_APPRAISE_RECD)),
       LDR_APPRAISE_VALUE   NUMBER(12,2) NULL,
       LDR_ESCROW_NAME      VARCHAR2(80) NULL,
       LDR_ESCROW_ORDERED   DATE NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6472
                                          CHECK (LDR_ESCROW_ORDERED = TRUNC(LDR_ESCROW_ORDERED)),
       LDR_ESCROW_RECD      DATE NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6473
                                          CHECK (LDR_ESCROW_RECD = TRUNC(LDR_ESCROW_RECD)),
       COND_DOCS_SENT       DATE NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6474
                                          CHECK (COND_DOCS_SENT = TRUNC(COND_DOCS_SENT)),
       COND_DOCS_RECD_INITIAL DATE NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6475
                                          CHECK (COND_DOCS_RECD_INITIAL = TRUNC(COND_DOCS_RECD_INITIAL)),
       COND_DOCS_RECD_FINAL DATE NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6476
                                          CHECK (COND_DOCS_RECD_FINAL = TRUNC(COND_DOCS_RECD_FINAL)),
       CLOSE_EST_COSTS      NUMBER(12,2) NULL,
       CLOSE_EST_DATE       DATE NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6477
                                          CHECK (CLOSE_EST_DATE = TRUNC(CLOSE_EST_DATE)),
       CLOSE_DOCS_ORDERED   DATE NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6478
                                          CHECK (CLOSE_DOCS_ORDERED = TRUNC(CLOSE_DOCS_ORDERED)),
       CLOSE_DOCS_SENT      DATE NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6479
                                          CHECK (CLOSE_DOCS_SENT = TRUNC(CLOSE_DOCS_SENT)),
       CLOSE_FINAL_STATUS   VARCHAR2(80) NULL,
       CLOSE_DATE           DATE NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6480
                                          CHECK (CLOSE_DATE = TRUNC(CLOSE_DATE)),
       APPLICATION_STAGE_DATETIME DATE DEFAULT SYSDATE NOT NULL,
       CONSTRAINT WADT_INDEX0 
              PRIMARY KEY (APPLICATIONID)
       USING INDEX
              TABLESPACE MU_MINIMUIND, 
       CONSTRAINT R_195
              FOREIGN KEY (PRIMARY_CONTACT_ROLE_DOMAIN)
                             REFERENCES WAMURoleDomain, 
       CONSTRAINT R_193
              FOREIGN KEY (LOAN_NEXT_PAYMENT_ADJ_DOMAIN)
                             REFERENCES NextpaymentAdjustDomain, 
       CONSTRAINT R_192
              FOREIGN KEY (LOAN_1ST_PAYMENT_ADJUST_DOMAIN)
                             REFERENCES FirstPaymentAdjustDomain, 
       CONSTRAINT R_178
              FOREIGN KEY (LOAN_AMORT_MONTHS_DOMAIN)
                             REFERENCES AmortizationTermDomain, 
       CONSTRAINT R_175
              FOREIGN KEY (LOAN_TYPE_DOMAIN)
                             REFERENCES LoanProductDomain, 
       CONSTRAINT R_174
              FOREIGN KEY (LOAN_NEGA_AMORT_DOMAIN)
                             REFERENCES NegativeAmortDomain, 
       CONSTRAINT R_173
              FOREIGN KEY (LOAN_PAYMENT_CAP_DOMAIN)
                             REFERENCES PaymentCapDomain, 
       CONSTRAINT R_172
              FOREIGN KEY (LOAN_PREPAY_PENALTY_DOMAIN)
                             REFERENCES PrepayPenaltyDomain, 
       CONSTRAINT R_167
              FOREIGN KEY (APPLICATION_STAGE_DOMAIN)
                             REFERENCES ApplicationStageDomain, 
       CONSTRAINT R_162
              FOREIGN KEY (APPLICATIONID)
                             REFERENCES UPApplication
                             ON DELETE CASCADE
)
       PCTFREE 50
       TABLESPACE MU_MINIMUTAB
;

COMMENT ON COLUMN WAMU_APPLICATION_DATA.APPLICATIONID IS 'Internal';
COMMENT ON COLUMN WAMU_APPLICATION_DATA.PRIMARY_CONTACT_ROLE_DOMAIN IS '%AttDef';
COMMENT ON COLUMN WAMU_APPLICATION_DATA.LOAN_AMORT_MONTHS_DOMAIN IS '%AttDef';
COMMENT ON COLUMN WAMU_APPLICATION_DATA.LOAN_TYPE_DOMAIN IS '%AttDef';
COMMENT ON COLUMN WAMU_APPLICATION_DATA.LOAN_NEGA_AMORT_DOMAIN IS '%AttDef';
COMMENT ON COLUMN WAMU_APPLICATION_DATA.LOAN_PAYMENT_CAP_DOMAIN IS '%AttDef';
COMMENT ON COLUMN WAMU_APPLICATION_DATA.LOAN_PREPAY_PENALTY_DOMAIN IS '%AttDef';
COMMENT ON COLUMN WAMU_APPLICATION_DATA.APPLICATION_STAGE_EMPLOYEEID IS '%AttDef';
COMMENT ON COLUMN WAMU_APPLICATION_DATA.CREATEDATE IS 'Record creation timestamp.';
COMMENT ON COLUMN WAMU_APPLICATION_DATA.REQUESTED_AMOUNT IS '%AttDef';
COMMENT ON COLUMN WAMU_APPLICATION_DATA.LOAN_1ST_PAYMENT_ADJUST_DOMAIN IS '%AttDef';
COMMENT ON COLUMN WAMU_APPLICATION_DATA.LOAN_NEXT_PAYMENT_ADJ_DOMAIN IS '%AttDef';
CREATE INDEX WADT_INDEX2 ON WAMU_APPLICATION_DATA
(
       APPLICATION_STAGE_DATETIME     ASC
)
       TABLESPACE MU_MINIMUIND
;

CREATE INDEX WADT_INDEX3 ON WAMU_APPLICATION_DATA
(
       CREATEDATE                     ASC
)
       TABLESPACE MU_MINIMUIND
;


CREATE TABLE WAMU_APP_CLOSING_CREDIT (
       Closing_Credit_Name  VARCHAR2(80) NOT NULL,
       ClosingCreditAmount  NUMBER(12,2) DEFAULT 0 NOT NULL,
       APPLICATIONID        NUMBER(27) NOT NULL,
       CONSTRAINT CCRD_INDEX0 
              PRIMARY KEY (APPLICATIONID, Closing_Credit_Name)
       USING INDEX
              TABLESPACE MU_BIGIND, 
       CONSTRAINT R_163
              FOREIGN KEY (APPLICATIONID)
                             REFERENCES WAMU_APPLICATION_DATA
)
       TABLESPACE MU_MINIMUTAB
;

COMMENT ON TABLE WAMU_APP_CLOSING_CREDIT IS 'Contains an arbitrary list of name/value pairs provided by the mortgage engine. Each name must a member of the Closing Credit Domain. See hb-wl-xx-xx.closingcosts';
COMMENT ON COLUMN WAMU_APP_CLOSING_CREDIT.APPLICATIONID IS '%AttDef';
COMMENT ON COLUMN WAMU_APP_CLOSING_CREDIT.ClosingCreditAmount IS 'hb-wl-xx-xx.closingcosts 19-30,re-ap-xx-xx.a170,hb-ap-xx-xx.a170';

CREATE TABLE WAMU_EMPLOYEE_EVENT (
       EMPLOYEEID           NUMBER(27) NOT NULL,
       LOGIN_GENERIC_SEQ    NUMBER(27) NOT NULL,
       CREATE_USER          VARCHAR2(30) DEFAULT USER NOT NULL
                                   CONSTRAINT STRING_IS_UCASE2788
                                          CHECK (Upper(CREATE_USER) = CREATE_USER),
       EVENT_DESCRIPTION    VARCHAR2(40) NOT NULL,
       CREATE_DATETIME      DATE DEFAULT SYSDATE NOT NULL,
       EVENT_MESSAGE        VARCHAR2(200) NULL,
       SUCCEED_YN           VARCHAR2(1) NOT NULL
                                   CONSTRAINT IS_Y_OR_N7401
                                          CHECK (SUCCEED_YN IN ('Y','N')),
       CONSTRAINT WAEE_INDEX0 
              PRIMARY KEY (EMPLOYEEID, LOGIN_GENERIC_SEQ)
       USING INDEX
              TABLESPACE MU_MINIMUIND, 
       CONSTRAINT R_159
              FOREIGN KEY (EMPLOYEEID)
                             REFERENCES WAMU_EMPLOYEE
                             ON DELETE CASCADE
)
       TABLESPACE MU_MINIMUTAB
;

CREATE INDEX WAEE_INDEX1 ON WAMU_EMPLOYEE_EVENT
(
       EMPLOYEEID                     ASC
)
       TABLESPACE MU_MINIMUIND
;


CREATE TABLE WAMU_LOAN_COMMENTS (
       APPLICATIONID        NUMBER(27) NOT NULL,
       CREATE_DATETIME      DATE DEFAULT SYSDATE NOT NULL,
       COMMENT_GENERIC_SEQ  NUMBER(27) NOT NULL,
       EMPLOYEEID           NUMBER(27) NOT NULL,
       CREATE_USER          VARCHAR2(30) DEFAULT USER NOT NULL
                                   CONSTRAINT STRING_IS_UCASE2789
                                          CHECK (Upper(CREATE_USER) = CREATE_USER),
       LOAN_COMMENT         VARCHAR2(4000) NULL,
       CONSTRAINT WANT_INDEX0 
              PRIMARY KEY (APPLICATIONID, COMMENT_GENERIC_SEQ)
       USING INDEX
              TABLESPACE MU_BIGIND, 
       CONSTRAINT R_168
              FOREIGN KEY (EMPLOYEEID)
                             REFERENCES WAMU_EMPLOYEE, 
       CONSTRAINT R_158
              FOREIGN KEY (APPLICATIONID)
                             REFERENCES UPApplication
                             ON DELETE CASCADE
)
       TABLESPACE MU_BIGTAB
;

COMMENT ON COLUMN WAMU_LOAN_COMMENTS.APPLICATIONID IS 'Internal';
CREATE INDEX WANT_INDEX1 ON WAMU_LOAN_COMMENTS
(
       APPLICATIONID                  ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX WANT_INDEX2 ON WAMU_LOAN_COMMENTS
(
       EMPLOYEEID                     ASC
)
       TABLESPACE MU_BIGIND
;


CREATE TABLE WAMU_STATUS_HISTORY (
       ASTG_NAME            VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37818
                                          CHECK (ASTG_NAME = Upper(ASTG_NAME)),
       APPLICATIONID        NUMBER(27) NOT NULL,
       STATUS_DATETIME      DATE NOT NULL,
       STATUS_GENERIC_SEQ   NUMBER(27) NOT NULL,
       CREATE_USER          VARCHAR2(30) DEFAULT USER NULL
                                   CONSTRAINT STRING_IS_UCASE2790
                                          CHECK (Upper(CREATE_USER) = CREATE_USER),
       WAMU_EMPLOYEEID      NUMBER(27) NULL,
       CREATE_DATETIME      DATE DEFAULT SYSDATE NULL,
       CONSTRAINT WASH_INDEX0 
              PRIMARY KEY (ASTG_NAME, APPLICATIONID, 
              STATUS_GENERIC_SEQ)
       USING INDEX
              TABLESPACE MU_MINIMUIND, 
       CONSTRAINT R_164
              FOREIGN KEY (APPLICATIONID)
                             REFERENCES WAMU_APPLICATION_DATA
                             ON DELETE CASCADE, 
       CONSTRAINT R_160
              FOREIGN KEY (WAMU_EMPLOYEEID)
                             REFERENCES WAMU_EMPLOYEE, 
       CONSTRAINT R_156
              FOREIGN KEY (ASTG_NAME)
                             REFERENCES ApplicationStageDomain
)
       TABLESPACE MU_MINIMUTAB
;

COMMENT ON COLUMN WAMU_STATUS_HISTORY.APPLICATIONID IS 'Internal';
CREATE INDEX WASH_INDEX1 ON WAMU_STATUS_HISTORY
(
       ASTG_NAME                      ASC
)
       TABLESPACE MU_MINIMUIND
;

CREATE INDEX WASH_INDEX2 ON WAMU_STATUS_HISTORY
(
       WAMU_EMPLOYEEID                ASC
)
       TABLESPACE MU_MINIMUIND
;

CREATE INDEX WASH_INDEX3 ON WAMU_STATUS_HISTORY
(
       APPLICATIONID                  ASC
)
       TABLESPACE MU_MINIMUIND
;


CREATE TABLE WAMU_EMPLOYEE_ROLE (
       WAMU_ROLE_DOMAIN     VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37819
                                          CHECK (WAMU_ROLE_DOMAIN = Upper(WAMU_ROLE_DOMAIN)),
       EMPLOYEEID           NUMBER(27) NOT NULL,
       CREATE_USER          VARCHAR2(30) DEFAULT USER NOT NULL
                                   CONSTRAINT STRING_IS_UCASE2791
                                          CHECK (Upper(CREATE_USER) = CREATE_USER),
       DOES_ROLE_YN         VARCHAR2(1) DEFAULT 'Y' NOT NULL
                                   CONSTRAINT IS_Y_OR_N7402
                                          CHECK (DOES_ROLE_YN IN ('Y','N')),
       CREATE_DATETIME      DATE DEFAULT SYSDATE NOT NULL,
       CONSTRAINT WAER_INDEX0 
              PRIMARY KEY (WAMU_ROLE_DOMAIN, EMPLOYEEID)
       USING INDEX
              TABLESPACE MU_MINIMUIND, 
       CONSTRAINT R_152
              FOREIGN KEY (WAMU_ROLE_DOMAIN)
                             REFERENCES WAMURoleDomain, 
       CONSTRAINT R_150
              FOREIGN KEY (EMPLOYEEID)
                             REFERENCES WAMU_EMPLOYEE
                             ON DELETE CASCADE
)
       TABLESPACE MU_MINIMUTAB
       CACHE 
;

COMMENT ON COLUMN WAMU_EMPLOYEE_ROLE.WAMU_ROLE_DOMAIN IS '%AttDef';
CREATE INDEX WAER_INDEX1 ON WAMU_EMPLOYEE_ROLE
(
       EMPLOYEEID                     ASC
)
       TABLESPACE MU_MINIMUIND
;


CREATE TABLE WAMU_LOAN_ASSIGNMENT (
       EMPLOYEEID           NUMBER(27) NOT NULL,
       APPLICATIONID        NUMBER(27) NOT NULL,
       WAMU_ROLE_DOMAIN     VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37820
                                          CHECK (WAMU_ROLE_DOMAIN = Upper(WAMU_ROLE_DOMAIN)),
       CREATE_USER          VARCHAR2(30) DEFAULT USER NOT NULL
                                   CONSTRAINT STRING_IS_UCASE2792
                                          CHECK (Upper(CREATE_USER) = CREATE_USER),
       CREATE_DATETIME      DATE DEFAULT SYSDATE NULL,
       CONSTRAINT WALA_INDEX0 
              PRIMARY KEY (APPLICATIONID, WAMU_ROLE_DOMAIN, 
              EMPLOYEEID)
       USING INDEX
              TABLESPACE MU_MINIMUIND, 
       CONSTRAINT R_165
              FOREIGN KEY (APPLICATIONID)
                             REFERENCES WAMU_APPLICATION_DATA
                             ON DELETE CASCADE, 
       CONSTRAINT R_154
              FOREIGN KEY (WAMU_ROLE_DOMAIN, EMPLOYEEID)
                             REFERENCES WAMU_EMPLOYEE_ROLE
                             ON DELETE CASCADE
)
       TABLESPACE MU_MINIMUTAB
;

COMMENT ON COLUMN WAMU_LOAN_ASSIGNMENT.APPLICATIONID IS 'Internal';
COMMENT ON COLUMN WAMU_LOAN_ASSIGNMENT.WAMU_ROLE_DOMAIN IS '%AttDef';
CREATE INDEX WALA_INDEX1 ON WAMU_LOAN_ASSIGNMENT
(
       WAMU_ROLE_DOMAIN               ASC,
       EMPLOYEEID                     ASC
)
       TABLESPACE MU_MINIMUIND
;

CREATE INDEX WALA_INDEX2 ON WAMU_LOAN_ASSIGNMENT
(
       APPLICATIONID                  ASC
)
       TABLESPACE MU_MINIMUIND
;

CREATE INDEX WALA_INDEX4 ON WAMU_LOAN_ASSIGNMENT
(
       EMPLOYEEID                     ASC
)
       TABLESPACE MU_BIGIND
;


CREATE TABLE HG_CONTROL (
       HG_PK                VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_HG168
                                          CHECK (HG_PK = 'HG'),
       ARCHIVE_PURGE_DATETIME DATE NOT NULL,
       CURRENT_PURGE_DATETIME DATE NOT NULL,
       ARCHIVE_DELETE_LIMIT NUMBER(3) DEFAULT 30 NOT NULL
                                   CONSTRAINT GTR_EQ_08831
                                          CHECK (ARCHIVE_DELETE_LIMIT >= 0),
       CURRENT_PURGE_LIMIT  NUMBER(3) DEFAULT 30 NOT NULL
                                   CONSTRAINT GTR_EQ_08832
                                          CHECK (CURRENT_PURGE_LIMIT >= 0),
       CONSTRAINT HGCO_INDEX0 
              PRIMARY KEY (HG_PK)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE SU_CUSTOMER_WK (
       ZIP5                 VARCHAR2(5) NOT NULL
                                   CONSTRAINT STRING_5_DIGITS409
                                          CHECK (rpad(translate(ZIP5,'01234567890','1111111111'),10,'1') = '1111111111'),
       SUMMARY_WEEK         DATE NOT NULL
                                   CONSTRAINT DAY_IS_SUN_MIDNIGHT243
                                          CHECK (SUMMARY_WEEK = TRUNC(SUMMARY_WEEK)
                                                AND 
                                                To_Char(SUMMARY_WEEK,'DY') = 'SUN'),
       LOAN_TYPE            VARCHAR2(40) NOT NULL
                                   CONSTRAINT LOAN_TYPE_VALUES241
                                          CHECK (LOAN_TYPE IN ('REFI','FIRST','REPEAT')),
       EDUCATION            VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37821
                                          CHECK (EDUCATION = Upper(EDUCATION)),
       GENDER               VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37822
                                          CHECK (GENDER = Upper(GENDER)),
       AGE_BRACKET          NUMBER(3) NOT NULL
                                   CONSTRAINT GTR_EQ_08833
                                          CHECK (AGE_BRACKET >= 0),
       HOUSEHOLD_SIZE       NUMBER(3) NOT NULL
                                   CONSTRAINT GTR_EQ_08834
                                          CHECK (HOUSEHOLD_SIZE >= 0),
       LOAN_BRACKET         NUMBER(12,2) NOT NULL,
       CUSTOMER_TYPE        VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37823
                                          CHECK (CUSTOMER_TYPE = Upper(CUSTOMER_TYPE)),
       SUMMARY_MONTH        DATE NOT NULL
                                   CONSTRAINT DAY_IS_FST_MNTH245
                                          CHECK (SUMMARY_MONTH = TRUNC(SUMMARY_MONTH)
                                                AND 
                                                To_Char(SUMMARY_MONTH,'DD') = '01'),
       HOW_MANY             NUMBER NULL
                                   CONSTRAINT GTR_EQ_08835
                                          CHECK (HOW_MANY >= 0),
       CONSTRAINT SUCW_INDEX0 
              PRIMARY KEY (ZIP5, SUMMARY_WEEK, LOAN_TYPE, EDUCATION, 
              GENDER, AGE_BRACKET, HOUSEHOLD_SIZE, LOAN_BRACKET, 
              CUSTOMER_TYPE)
       USING INDEX
              TABLESPACE MU_SUMMARYIND
)
       TABLESPACE MU_SUMMARYTAB
;


CREATE TABLE UPNoteBookShare (
       ShareeUserID         NUMBER(27) NOT NULL,
       SHAREREMAIL          VARCHAR2(80) NOT NULL,
       CONSTRAINT NBSH_INDEX0 
              PRIMARY KEY (ShareeUserID, SHAREREMAIL)
       USING INDEX
              TABLESPACE MU_BIGIND, 
       CONSTRAINT R_120
              FOREIGN KEY (ShareeUserID)
                             REFERENCES UP_USER
                             ON DELETE CASCADE
)
       TABLESPACE MU_BIGTAB
;

CREATE INDEX NBSH_INDEX1 ON UPNoteBookShare
(
       ShareeUserID                   ASC
)
       TABLESPACE MU_BIGIND
;


CREATE TABLE HgGlossary (
       TermName             VARCHAR2(80) NOT NULL,
       TermDescription      VARCHAR2(4000) NOT NULL,
       TermCategory         VARCHAR2(40) DEFAULT 'GENERIC' NOT NULL
                                   CONSTRAINT STRING_NOSPACE1009
                                          CHECK (TermCategory = Replace(TermCategory, ' ','')),
       TermSortSequence     NUMBER DEFAULT 0 NULL,
       TermUrl              VARCHAR2(2048) NULL,
       CONSTRAINT GLOS_INDEX0 
              PRIMARY KEY (TermName, TermCategory)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

/**
This index won't work in Oracle Versions 
prior to 8i. Not having this index is not
the end of the world.
**/

CREATE INDEX GLOS_INDEX1 ON HGGlossary
(UPPER(termname)
,UPPER(termCategory))
TABLESPACE MU_BIGIND
;


CREATE TABLE NotebookTypeDomain (
       NBTY_NAME            VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37824
                                          CHECK (NBTY_NAME = Upper(NBTY_NAME)),
       OtherName            VARCHAR2(80) NOT NULL,
       Description          VARCHAR2(30) NOT NULL,
       LongDescription      VARCHAR2(200) NULL,
       SORTORDER            NUMBER(27) NULL,
       CONSTRAINT NBTY_INDEX0 
              PRIMARY KEY (NBTY_NAME)
       USING INDEX
              TABLESPACE MU_BIGIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;


CREATE TABLE NotebookItem (
       NotebookItemID       NUMBER(27) NOT NULL,
       NotebookTypeName     VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37825
                                          CHECK (NotebookTypeName = Upper(NotebookTypeName)),
       UserID               NUMBER(27) NOT NULL,
       Description          VARCHAR2(200) NULL,
       Subtype              VARCHAR2(80) NULL,
       StoreDate            DATE NOT NULL,
       NoteBookObject       LONG NULL,
       CONSTRAINT NBIT_INDEX0 
              PRIMARY KEY (NotebookItemID)
       USING INDEX
              TABLESPACE MU_BIGIND, 
       CONSTRAINT R_102
              FOREIGN KEY (NotebookTypeName)
                             REFERENCES NotebookTypeDomain, 
       CONSTRAINT R_101
              FOREIGN KEY (UserID)
                             REFERENCES UP_USER
                             ON DELETE CASCADE
)
       PCTFREE 70
       PCTUSED 1
       TABLESPACE MU_BLOBSPACE
;

CREATE INDEX NBIT_INDEX1 ON NotebookItem
(
       UserID                         ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX NBIT_INDEX2 ON NotebookItem
(
       NotebookTypeName               ASC
)
       TABLESPACE MU_BIGIND
;


CREATE TABLE OwnershipRightsDomain (
       OtherName            VARCHAR2(80) NOT NULL,
       OWRT_NAME            VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37826
                                          CHECK (OWRT_NAME = Upper(OWRT_NAME)),
       Description          VARCHAR2(30) NOT NULL,
       LongDescription      VARCHAR2(200) NULL,
       SORTORDER            NUMBER(27) NULL,
       CONSTRAINT OWRT_INDEX0 
              PRIMARY KEY (OWRT_NAME)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

CREATE INDEX OWRT_INDEX1 ON OwnershipRightsDomain
(
       OtherName                      ASC
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE EducationLevelDomain (
       OtherName            VARCHAR2(80) NOT NULL,
       EDTY_NAME            VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37827
                                          CHECK (EDTY_NAME = Upper(EDTY_NAME)),
       Description          VARCHAR2(30) NOT NULL,
       LongDescription      VARCHAR2(200) NULL,
       SORTORDER            NUMBER(27) NULL,
       CONSTRAINT GNDR_INDEX0 
              PRIMARY KEY (EDTY_NAME)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

CREATE INDEX GNDR_INDEX1 ON EducationLevelDomain
(
       OtherName                      ASC
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE MaritalStatusDomain (
       OtherName            VARCHAR2(80) NOT NULL,
       MARS_NAME            VARCHAR2(80) NOT NULL
                                   CONSTRAINT STRING_UCASE37828
                                          CHECK (MARS_NAME = Upper(MARS_NAME)),
       Description          VARCHAR2(30) NOT NULL,
       LongDescription      VARCHAR2(200) NULL,
       SORTORDER            NUMBER(27) NULL,
       CONSTRAINT MARS_INDEX0 
              PRIMARY KEY (MARS_NAME)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

CREATE INDEX MARS_INDEX1 ON MaritalStatusDomain
(
       OtherName                      ASC
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE BorrowerTypeDomain (
       OtherName            VARCHAR2(80) NOT NULL,
       BRTY_NAME            VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37829
                                          CHECK (BRTY_NAME = Upper(BRTY_NAME)),
       Description          VARCHAR2(30) NOT NULL,
       LongDescription      VARCHAR2(200) NULL,
       SORTORDER            NUMBER(27) NULL,
       CONSTRAINT BRTY_INDEX0 
              PRIMARY KEY (BRTY_NAME)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

CREATE INDEX BRTY_INDEX1 ON BorrowerTypeDomain
(
       OtherName                      ASC
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE UPBorrower (
       BORROWERID           NUMBER(27) NOT NULL,
       APPLICATIONID        NUMBER(27) NOT NULL,
       SSN                  VARCHAR2(9) NULL,
       FIRST_NAME           VARCHAR2(80) NOT NULL
                                   CONSTRAINT STRING_UCASE37830
                                          CHECK (FIRST_NAME = Upper(FIRST_NAME)),
       LAST_NAME            VARCHAR2(80) NOT NULL
                                   CONSTRAINT STRING_UCASE37831
                                          CHECK (LAST_NAME = Upper(LAST_NAME)),
       MIDDLE_NAME          VARCHAR2(80) NULL
                                   CONSTRAINT STRING_UCASE37832
                                          CHECK (MIDDLE_NAME = Upper(MIDDLE_NAME)),
       SUFFIX               VARCHAR2(80) NULL
                                   CONSTRAINT STRING_UCASE37833
                                          CHECK (SUFFIX = Upper(SUFFIX)),
       HOME_PHONE           VARCHAR2(20) NOT NULL,
       DEPENDENTS           NUMBER(3) DEFAULT 0 NULL
                                   CONSTRAINT GTR_EQ_08836
                                          CHECK (DEPENDENTS >= 0),
       BIRTHDATE            DATE NOT NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6481
                                          CHECK (BIRTHDATE = TRUNC(BIRTHDATE)),
       LOAN_FIRST_TIME_BUYER_YN VARCHAR2(1) DEFAULT 'N' NOT NULL
                                   CONSTRAINT IS_Y_OR_N7403
                                          CHECK (LOAN_FIRST_TIME_BUYER_YN IN ('Y','N')),
       WORK_PHONE           VARCHAR2(20) NULL,
       BORROWER_TYPE_DOMAIN VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37834
                                          CHECK (BORROWER_TYPE_DOMAIN = Upper(BORROWER_TYPE_DOMAIN)),
       WORK_PHONE_EXTENSION VARCHAR2(5) NULL,
       CELL_PHONE           VARCHAR2(20) NULL,
       MARITAL_STATUS_DOMAIN VARCHAR2(80) NOT NULL
                                   CONSTRAINT STRING_UCASE37835
                                          CHECK (MARITAL_STATUS_DOMAIN = Upper(MARITAL_STATUS_DOMAIN)),
       PAGER                VARCHAR2(20) NULL,
       PAGER_EXTENSION      VARCHAR2(5) NULL,
       EDUCATION_LEVEL_DOMAIN VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37836
                                          CHECK (EDUCATION_LEVEL_DOMAIN = Upper(EDUCATION_LEVEL_DOMAIN)),
       HOME_FAX             VARCHAR2(20) NULL,
       WORK_FAX             VARCHAR2(20) NULL,
       PRIMARY_EMAIL_ADDRESS VARCHAR2(80) NULL,
       MTH_ALIMONY          NUMBER(12,2) NULL,
       SECONDARY_EMAIL_ADDRESS VARCHAR2(80) NULL,
       MTH_DIVIDEND         NUMBER(12,2) NULL,
       MTH_SOCSECURITY      NUMBER(12,2) NULL,
       MTH_PENSION          NUMBER(12,2) NULL,
       MTH_RETIRE_INCOME    NUMBER(12,2) NULL,
       DEPENDENTS_AGES_STRING VARCHAR2(200) NULL,
       MTH_OTHER_INCOME_DESC VARCHAR2(200) NULL,
       MTH_OTHER_INCOME_AMOUNT NUMBER(12,2) NULL,
       CNTCT_ADDRESS_YN     VARCHAR2(1) DEFAULT 'N' NOT NULL
                                   CONSTRAINT IS_Y_OR_N7404
                                          CHECK (CNTCT_ADDRESS_YN IN ('Y','N')),
       CNTCT_HOMEPHONE_YN   VARCHAR2(1) DEFAULT 'N' NOT NULL
                                   CONSTRAINT IS_Y_OR_N7405
                                          CHECK (CNTCT_HOMEPHONE_YN IN ('Y','N')),
       CNTCT_WORKPHONE_YN   VARCHAR2(1) DEFAULT 'N' NOT NULL
                                   CONSTRAINT IS_Y_OR_N7406
                                          CHECK (CNTCT_WORKPHONE_YN IN ('Y','N')),
       CNTCT_CELLPHONE_YN   VARCHAR2(1) DEFAULT 'N' NOT NULL
                                   CONSTRAINT IS_Y_OR_N7407
                                          CHECK (CNTCT_CELLPHONE_YN IN ('Y','N')),
       CNTCT_FAX_YN         VARCHAR2(1) DEFAULT 'N' NOT NULL
                                   CONSTRAINT IS_Y_OR_N7408
                                          CHECK (CNTCT_FAX_YN IN ('Y','N')),
       CNTCT_WORKFAX_YN     VARCHAR2(1) DEFAULT 'N' NOT NULL
                                   CONSTRAINT IS_Y_OR_N7409
                                          CHECK (CNTCT_WORKFAX_YN IN ('Y','N')),
       CNTCT_PAGER_YN       VARCHAR2(1) DEFAULT 'N' NOT NULL
                                   CONSTRAINT IS_Y_OR_N7410
                                          CHECK (CNTCT_PAGER_YN IN ('Y','N')),
       CNTCT_PRIMARY_EMAIL_YN VARCHAR2(1) DEFAULT 'N' NOT NULL
                                   CONSTRAINT IS_Y_OR_N7411
                                          CHECK (CNTCT_PRIMARY_EMAIL_YN IN ('Y','N')),
       CNTCT_SECONDARY_EMAIL_YN VARCHAR2(1) DEFAULT 'N' NOT NULL
                                   CONSTRAINT IS_Y_OR_N7412
                                          CHECK (CNTCT_SECONDARY_EMAIL_YN IN ('Y','N')),
       CONSTRAINT APSR_INDEX0 
              PRIMARY KEY (BORROWERID, APPLICATIONID)
       USING INDEX
              TABLESPACE MU_BIGIND, 
       CONSTRAINT R_127
              FOREIGN KEY (APPLICATIONID)
                             REFERENCES UPApplication
                             ON DELETE CASCADE, 
       CONSTRAINT R_58
              FOREIGN KEY (EDUCATION_LEVEL_DOMAIN)
                             REFERENCES EducationLevelDomain, 
       CONSTRAINT R_57
              FOREIGN KEY (MARITAL_STATUS_DOMAIN)
                             REFERENCES MaritalStatusDomain, 
       CONSTRAINT R_47
              FOREIGN KEY (BORROWER_TYPE_DOMAIN)
                             REFERENCES BorrowerTypeDomain
)
       TABLESPACE MU_BIGTAB
;

COMMENT ON COLUMN UPBorrower.BORROWERID IS 'Internal ID';
COMMENT ON COLUMN UPBorrower.APPLICATIONID IS 'Internal ID';
COMMENT ON COLUMN UPBorrower.FIRST_NAME IS 're-ap-xx-xx.a020,hb-ap-xx-xx.a020,1003-III-Name';
COMMENT ON COLUMN UPBorrower.MIDDLE_NAME IS 're-ap-xx-xx.a020,hb-ap-xx-xx.a020,1003-III-Name';
COMMENT ON COLUMN UPBorrower.LAST_NAME IS 're-ap-xx-xx.a020,hb-ap-xx-xx.a020,1003-III-Name';
COMMENT ON COLUMN UPBorrower.SUFFIX IS 're-ap-xx-xx.a020,hb-ap-xx-xx.a020,1003-III-Name';
COMMENT ON COLUMN UPBorrower.SSN IS 're-ap-xx-xx.a020,hb-ap-xx-xx.a020,1003-III-SSN';
COMMENT ON COLUMN UPBorrower.BIRTHDATE IS 're-ap-xx-xx.a020,hb-ap-xx-xx.a020,1003-III-Birthdate';
COMMENT ON COLUMN UPBorrower.MARITAL_STATUS_DOMAIN IS 're-ap-xx-xx.a020,hb-ap-xx-xx.a020,1003-III-MarriedUnmarriedSeperated';
COMMENT ON COLUMN UPBorrower.DEPENDENTS IS 'Count of dependents. re-ap-xx-xx.a020,hb-ap-xx-xx.a020,1003-III-Dependents';
COMMENT ON COLUMN UPBorrower.EDUCATION_LEVEL_DOMAIN IS 'Educatin level of borrower. re-ap-xx-xx.a020,hb-ap-xx-xx.a020,1003-III-YrsSchool';
COMMENT ON COLUMN UPBorrower.LOAN_FIRST_TIME_BUYER_YN IS 'hb-ap-xx-xx.a020';
COMMENT ON COLUMN UPBorrower.HOME_PHONE IS 're-ap-xx-xx.a020,hb-ap-xx-xx.a020';
COMMENT ON COLUMN UPBorrower.WORK_PHONE IS 're-ap-xx-xx.a020,hb-ap-xx-xx.a020';
COMMENT ON COLUMN UPBorrower.WORK_PHONE_EXTENSION IS 're-ap-xx-xx.a020,hb-ap-xx-xx.a020';
COMMENT ON COLUMN UPBorrower.CELL_PHONE IS 're-ap-xx-xx.a020,hb-ap-xx-xx.a020';
COMMENT ON COLUMN UPBorrower.PAGER IS 're-ap-xx-xx.a020,hb-ap-xx-xx.a020';
COMMENT ON COLUMN UPBorrower.PAGER_EXTENSION IS 're-ap-xx-xx.a020,hb-ap-xx-xx.a020';
COMMENT ON COLUMN UPBorrower.HOME_FAX IS 're-ap-xx-xx.a020,hb-ap-xx-xx.a020';
COMMENT ON COLUMN UPBorrower.WORK_FAX IS 're-ap-xx-xx.a020,hb-ap-xx-xx.a020';
COMMENT ON COLUMN UPBorrower.PRIMARY_EMAIL_ADDRESS IS 're-ap-xx-xx.a020,hb-ap-xx-xx.a020';
COMMENT ON COLUMN UPBorrower.SECONDARY_EMAIL_ADDRESS IS 're-ap-xx-xx.a020,hb-ap-xx-xx.a020';
COMMENT ON COLUMN UPBorrower.BORROWER_TYPE_DOMAIN IS 'applicant indicator (borrow/co-borrower)';
COMMENT ON COLUMN UPBorrower.MTH_ALIMONY IS 'Monthly Alimony. re-ap-xx-xx.a110,hb-ap-xx-xx.a110';
COMMENT ON COLUMN UPBorrower.MTH_DIVIDEND IS 'Monthly Dividend Income. re-ap-xx-xx.a110,hb-ap-xx-xx.a110,1003-V-Dividends';
COMMENT ON COLUMN UPBorrower.MTH_SOCSECURITY IS 'Monthly Social Security Income. re-ap-xx-xx.a110,hb-ap-xx-xx.a110,1003-V-Other';
COMMENT ON COLUMN UPBorrower.MTH_PENSION IS 'Monthly Pension income. re-ap-xx-xx.a110,hb-ap-xx-xx.a110,,1003-V-Other';
COMMENT ON COLUMN UPBorrower.MTH_RETIRE_INCOME IS 'Monthly Retirement Income. re-ap-xx-xx.a110,hb-ap-xx-xx.a110,1003-V-Other';
COMMENT ON COLUMN UPBorrower.MTH_OTHER_INCOME_DESC IS 'Monthly Other income Description. re-ap-xx-xx.a110,hb-ap-xx-xx.a110,1003-V-Other';
COMMENT ON COLUMN UPBorrower.MTH_OTHER_INCOME_AMOUNT IS 'Monthly Other Income Amount.  re-ap-xx-xx.a110,hb-ap-xx-xx.a110,1003-V-Other';
COMMENT ON COLUMN UPBorrower.DEPENDENTS_AGES_STRING IS 'String listing ages of of dependents. On 1003 form only. 1003-III-DependentsAges';
CREATE INDEX APSR_INDEX1 ON UPBorrower
(
       APPLICATIONID                  ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX APSR_INDEX3 ON UPBorrower
(
       BORROWER_TYPE_DOMAIN           ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX APSR_INDEX5 ON UPBorrower
(
       MARITAL_STATUS_DOMAIN          ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX APSR_INDEX2 ON UPBorrower
(
       EDUCATION_LEVEL_DOMAIN         ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX APSR_INDEX4 ON UPBorrower
(
       PRIMARY_EMAIL_ADDRESS          ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX APSR_INDEX6 ON UPBorrower
(
       SECONDARY_EMAIL_ADDRESS        ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX APSR_INDEX7 ON UPBorrower
(
       FIRST_NAME                     ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX APSR_INDEX8 ON UPBorrower
(
       LAST_NAME                      ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX APSR_INDEX9 ON UPBorrower
(
       SSN                            ASC
)
       TABLESPACE MU_BIGIND
;


CREATE TABLE UPResidence (
       APPLICATIONID        NUMBER(27) NOT NULL,
       RESIDENCEID          NUMBER(27) NOT NULL,
       BORROWERID           NUMBER(27) NOT NULL,
       ADDRESSID            NUMBER(27) NOT NULL,
       OWNERSHIP_RIGHTS_DOMAIN VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37837
                                          CHECK (OWNERSHIP_RIGHTS_DOMAIN = Upper(OWNERSHIP_RIGHTS_DOMAIN)),
       START_DATE           DATE NOT NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6482
                                          CHECK (START_DATE = TRUNC(START_DATE)),
       END_DATE             DATE NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6483
                                          CHECK (END_DATE = TRUNC(END_DATE)),
       RENT_MTH_AMOUNT      NUMBER(12,2) NULL,
       RENT_LANDLORD_FIRST_NAME VARCHAR2(80) NULL,
       RENT_LANDLORD_LAST_NAME VARCHAR2(80) NULL,
       RENT_LANDLORD_PHONE_NUMBER VARCHAR2(20) NULL,
       OWN_PROP_TYPE_DOMAIN VARCHAR2(40) NULL
                                   CONSTRAINT STRING_UCASE37838
                                          CHECK (OWN_PROP_TYPE_DOMAIN = Upper(OWN_PROP_TYPE_DOMAIN)),
       OWN_PRESENT_MKT_VALUE NUMBER(12,2) NULL,
       OWN_MTH_MORTGAGE_COST NUMBER(12,2) NULL,
       OWN_MTH_PROP_TAX     NUMBER(12,2) NULL,
       OWN_MTH_HAZARD_INSURE NUMBER(12,2) NULL,
       OWN_MORTGAGE_CO      VARCHAR2(80) NULL,
       OWN_MORTGAGE_NUMBER  VARCHAR2(20) NULL,
       OWN_MORTGAGE_BALANCE NUMBER(12,2) NULL,
       OWN_MTH_OTHER_EXPENSE NUMBER(12,2) NULL,
       OWN_MTH_RENTAL_INCOME NUMBER(12,2) NULL,
       CONSTRAINT RESD_INDEX0 
              PRIMARY KEY (APPLICATIONID, BORROWERID, RESIDENCEID)
       USING INDEX
              TABLESPACE MU_BIGIND, 
       CONSTRAINT R_138
              FOREIGN KEY (OWN_PROP_TYPE_DOMAIN)
                             REFERENCES TypeOfPropertyDomain, 
       CONSTRAINT R_137
              FOREIGN KEY (ADDRESSID)
                             REFERENCES UPAddress, 
       CONSTRAINT R_66
              FOREIGN KEY (OWNERSHIP_RIGHTS_DOMAIN)
                             REFERENCES OwnershipRightsDomain, 
       CONSTRAINT R_27
              FOREIGN KEY (BORROWERID, APPLICATIONID)
                             REFERENCES UPBorrower
                             ON DELETE CASCADE
)
       TABLESPACE MU_BIGTAB
;

COMMENT ON COLUMN UPResidence.APPLICATIONID IS 'Internal ID';
COMMENT ON COLUMN UPResidence.BORROWERID IS 'Internal ID';
COMMENT ON COLUMN UPResidence.RESIDENCEID IS 'Internal ID';
COMMENT ON COLUMN UPResidence.ADDRESSID IS 're-ap-xx-xx.a055,re-ap-xx-xx.a055a,hb-ap-xx-xx.a055,hb-ap-xx-xx.a055a,1003-III-PresentAddress, 1003-III-FormerAddress
Not part of PK as could move back to previous address.';
COMMENT ON COLUMN UPResidence.START_DATE IS 're-ap-xx-xx.a055,re-ap-xx-xx.a055a,hb-ap-xx-xx.a055,hb-ap-xx-xx.a055,1003-III-PresentAddress, 1003-III-FormerAddress';
COMMENT ON COLUMN UPResidence.END_DATE IS 're-ap-xx-xx.a055,re-ap-xx-xx.a055a,hb-ap-xx-xx.a055,hb-ap-xx-xx.a055,1003-III-PresentAddress, 1003-III-FormerAddress';
COMMENT ON COLUMN UPResidence.OWNERSHIP_RIGHTS_DOMAIN IS 're-ap-xx-xx.a055
,re-ap-xx-xx.a055a (has value of UNKNOWN),
hb-ap-xx-xx.a055,hb-ap-xx-xx.a055a (has value of UNKNOWN),1003-III-PresentAddress, 1003-III-FormerAddress';
COMMENT ON COLUMN UPResidence.RENT_MTH_AMOUNT IS 're-ap-xx-xx.a060,hb-ap-xx-xx.a060,1003-V-Rent';
COMMENT ON COLUMN UPResidence.RENT_LANDLORD_FIRST_NAME IS 're-ap-xx-xx.a060,hb-ap-xx-xx.a060';
COMMENT ON COLUMN UPResidence.RENT_LANDLORD_LAST_NAME IS 're-ap-xx-xx.a060,hb-ap-xx-xx.a060';
COMMENT ON COLUMN UPResidence.RENT_LANDLORD_PHONE_NUMBER IS 're-ap-xx-xx.a060,hb-ap-xx-xx.a060';
COMMENT ON COLUMN UPResidence.OWN_PROP_TYPE_DOMAIN IS 're-ap-xx-xx.a070,hb-ap-xx-xx.a070';
COMMENT ON COLUMN UPResidence.OWN_PRESENT_MKT_VALUE IS 're-ap-xx-xx.a070,hb-ap-xx-xx.a070';
COMMENT ON COLUMN UPResidence.OWN_MTH_MORTGAGE_COST IS 're-ap-xx-xx.a070,hb-ap-xx-xx.a070,1003-V-FirstMortgage';
COMMENT ON COLUMN UPResidence.OWN_MTH_PROP_TAX IS 're-ap-xx-xx.a070,hb-ap-xx-xx.a070,1003-V-PropTax';
COMMENT ON COLUMN UPResidence.OWN_MTH_HAZARD_INSURE IS 're-ap-xx-xx.a070,hb-ap-xx-xx.a070,1003-V-Hazard,1003-V-MortgageInsure';
COMMENT ON COLUMN UPResidence.OWN_MORTGAGE_CO IS 're-ap-xx-xx.a070,hb-ap-xx-xx.a070';
COMMENT ON COLUMN UPResidence.OWN_MORTGAGE_NUMBER IS 're-ap-xx-xx.a070,hb-ap-xx-xx.a070';
COMMENT ON COLUMN UPResidence.OWN_MORTGAGE_BALANCE IS 're-ap-xx-xx.a070,hb-ap-xx-xx.a070';
COMMENT ON COLUMN UPResidence.OWN_MTH_OTHER_EXPENSE IS 're-ap-xx-xx.a070,hb-ap-xx-xx.a070,1003-V-Other';
CREATE INDEX RESD_INDEX1 ON UPResidence
(
       ADDRESSID                      ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX RESD_INDEX4 ON UPResidence
(
       OWN_PROP_TYPE_DOMAIN           ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX RESD_INDEX2 ON UPResidence
(
       BORROWERID                     ASC,
       APPLICATIONID                  ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX RESD_INDEX3 ON UPResidence
(
       OWNERSHIP_RIGHTS_DOMAIN        ASC
)
       TABLESPACE MU_BIGIND
;

ALTER TABLE UPResidence
ADD CONSTRAINT UPResidence_RGE
CHECK (START_DATE <= END_DATE);




CREATE TABLE UPEmployment (
       APPLICATIONID        NUMBER(27) NOT NULL,
       EMPLOYMENTID         NUMBER(27) NOT NULL,
       BORROWERID           NUMBER(27) NOT NULL,
       EMPLOYER_NAME        VARCHAR2(80) NOT NULL,
       START_DATE           DATE NOT NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6484
                                          CHECK (START_DATE = TRUNC(START_DATE)),
       JOB_TITLE            VARCHAR2(80) NOT NULL,
       EMPLOYER_PHONE_EXT   VARCHAR2(9) NULL,
       END_DATE             DATE NULL
                                   CONSTRAINT DAY_IS_NOT_TIME6485
                                          CHECK (END_DATE = TRUNC(END_DATE)),
       ADDRESSID            NUMBER(27) NOT NULL,
       EMPLOYER_PHONE       VARCHAR2(20) NOT NULL,
       MTH_GROSS_SALARY     NUMBER(12,2) NOT NULL,
       YEARS_IN_PROFESSION  NUMBER(3) DEFAULT 0 NOT NULL
                                   CONSTRAINT GTR_EQ_08837
                                          CHECK (YEARS_IN_PROFESSION >= 0),
       MTH_GROSS_OVERTIME   NUMBER(12,2) NULL,
       MTH_GROSS_BONUSES    NUMBER(12,2) NULL,
       MTH_COMMISSIONS      NUMBER(12,2) NULL,
       SELF_EMPLOY_YN       VARCHAR2(1) DEFAULT 'N' NOT NULL
                                   CONSTRAINT IS_Y_OR_N7413
                                          CHECK (SELF_EMPLOY_YN IN ('Y','N')),
       CONSTRAINT EMPL_INDEX0 
              PRIMARY KEY (APPLICATIONID, BORROWERID, EMPLOYMENTID)
       USING INDEX
              TABLESPACE MU_BIGIND, 
       CONSTRAINT R_140
              FOREIGN KEY (ADDRESSID)
                             REFERENCES UPAddress, 
       CONSTRAINT R_25
              FOREIGN KEY (BORROWERID, APPLICATIONID)
                             REFERENCES UPBorrower
                             ON DELETE CASCADE
)
       TABLESPACE MU_BIGTAB
;

COMMENT ON COLUMN UPEmployment.APPLICATIONID IS 'Internal ID';
COMMENT ON COLUMN UPEmployment.BORROWERID IS 'Internal ID';
COMMENT ON COLUMN UPEmployment.EMPLOYMENTID IS 'Internal ID';
COMMENT ON COLUMN UPEmployment.EMPLOYER_NAME IS 're-ap-xx-xx.a090a,hb-ap-xx-xx.a090a,1003-IV-Name';
COMMENT ON COLUMN UPEmployment.EMPLOYER_PHONE IS 're-ap-xx-xx.a090a,hb-ap-xx-xx.a090a,1003-IV-BusinessPhone';
COMMENT ON COLUMN UPEmployment.EMPLOYER_PHONE_EXT IS 're-ap-xx-xx.a090a,hb-ap-xx-xx.a090a,1003-IV-BusinessPhone';
COMMENT ON COLUMN UPEmployment.ADDRESSID IS 'Internal ID of matching address record. re-ap-xx-xx.a090a,hb-ap-xx-xx.a090a,1003-IV-Address';
COMMENT ON COLUMN UPEmployment.JOB_TITLE IS 're-ap-xx-xx.a090a,hb-ap-xx-xx.a090a,1003-IV-JobTitle';
COMMENT ON COLUMN UPEmployment.START_DATE IS 'Date (accurate to midnight) re-ap-xx-xx.a090a,hb-ap-xx-xx.a090a,1003-IV-YearsOnThisJob';
COMMENT ON COLUMN UPEmployment.END_DATE IS 're-ap-xx-xx.a090a,hb-ap-xx-xx.a090a,1003-IV-YearsOnThisJob. NULL means current.';
COMMENT ON COLUMN UPEmployment.YEARS_IN_PROFESSION IS 're-ap-xx-xx.a090a,hb-ap-xx-xx.a090a,1003-IV-YearsInThisProfession';
COMMENT ON COLUMN UPEmployment.MTH_GROSS_SALARY IS 're-ap-xx-xx.a090a,hb-ap-xx-xx.a090a,1003-V-Base';
COMMENT ON COLUMN UPEmployment.MTH_GROSS_OVERTIME IS 're-ap-xx-xx.a090a,hb-ap-xx-xx.a090a,1003-V-Overtime';
COMMENT ON COLUMN UPEmployment.MTH_GROSS_BONUSES IS 're-ap-xx-xx.a090a,hb-ap-xx-xx.a090a,1003-V-Bonus';
COMMENT ON COLUMN UPEmployment.MTH_COMMISSIONS IS 're-ap-xx-xx.a090a,hb-ap-xx-xx.a090a,1003-V-Commissions';
COMMENT ON COLUMN UPEmployment.SELF_EMPLOY_YN IS 're-ap-xx-xx.a090a,hb-ap-xx-xx.a090a,1003-IV-SelfEmployed';
CREATE INDEX EMPL_INDEX1 ON UPEmployment
(
       ADDRESSID                      ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX EMPL_INDEX2 ON UPEmployment
(
       BORROWERID                     ASC,
       APPLICATIONID                  ASC
)
       TABLESPACE MU_BIGIND
;

ALTER TABLE UPEmployment
ADD CONSTRAINT UPEmployment_RGE
CHECK (START_DATE <= END_DATE);




CREATE TABLE AssetType (
       OtherName            VARCHAR2(80) NOT NULL,
       AssetTypeName        VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37839
                                          CHECK (AssetTypeName = Upper(AssetTypeName)),
       Description          VARCHAR2(30) NOT NULL,
       LongDescription      VARCHAR2(200) NULL,
       LiquidYOrN           VARCHAR2(1) DEFAULT 'N' NOT NULL
                                   CONSTRAINT IS_Y_OR_N7414
                                          CHECK (LiquidYOrN IN ('Y','N')),
       SORTORDER            NUMBER(27) NULL,
       CONSTRAINT ASTY_INDEX0 
              PRIMARY KEY (AssetTypeName)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

CREATE INDEX ASTY_INDEX1 ON AssetType
(
       OtherName                      ASC
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE UPAsset (
       APPLICATIONID        NUMBER(27) NOT NULL,
       ASSETID              NUMBER(27) NOT NULL,
       BORROWERID           NUMBER(27) NOT NULL,
       INSTITUTION_NAME     VARCHAR2(80) NULL,
       ACCOUNT_NUMBER_OR_DESC VARCHAR2(20) NULL,
       PART_OF_DOWNPAYMENT_YN VARCHAR2(1) DEFAULT 'N' NOT NULL
                                   CONSTRAINT IS_Y_OR_N7415
                                          CHECK (PART_OF_DOWNPAYMENT_YN IN ('Y','N')),
       ASSET_TYPE           VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37840
                                          CHECK (ASSET_TYPE = Upper(ASSET_TYPE)),
       ASSET_VALUE          NUMBER(12,2) DEFAULT 0 NOT NULL,
       CONSTRAINT ASST_INDEX0 
              PRIMARY KEY (APPLICATIONID, BORROWERID, ASSETID)
       USING INDEX
              TABLESPACE MU_BIGIND, 
       CONSTRAINT R_55
              FOREIGN KEY (ASSET_TYPE)
                             REFERENCES AssetType, 
       CONSTRAINT R_32
              FOREIGN KEY (BORROWERID, APPLICATIONID)
                             REFERENCES UPBorrower
                             ON DELETE CASCADE
)
       TABLESPACE MU_BIGTAB
;

COMMENT ON COLUMN UPAsset.APPLICATIONID IS 'Internal ID';
COMMENT ON COLUMN UPAsset.BORROWERID IS 'Internal ID';
COMMENT ON COLUMN UPAsset.ASSETID IS 'Internal ID';
COMMENT ON COLUMN UPAsset.ASSET_TYPE IS 'Type of asset. list of possible types is in assetType. re-ap-xx-xx.a120a,re-ap-xx-xx.a130 (=''AUTO'') or ,re-ap-xx-xx.a130 (=''OTHER''),hb-ap-xx-xx.a120a,hb-ap-xx-xx.a130 (=''AUTO'') or ,hb-ap-xx-xx.a130 (=''OTHER''),1003-VI-CashDeposit(=''CASH''),1003-VI-CheckingAndSavings(IN(''CHECKING'',''SAVINGS''),1003-VI-StocksAndBonds(IN(''CHECKING'',''SAVINGS'')';
COMMENT ON COLUMN UPAsset.INSTITUTION_NAME IS 're-ap-xx-xx.a120a,re-ap-xx-xx.a130 (=''AUTO'') or ,re-ap-xx-xx.a130 (=''OTHER''),hb-ap-xx-xx.a120a,hb-ap-xx-xx.a130 (=''AUTO'') or ,hb-ap-xx-xx.a130 (=''OTHER''),1003-VI-CashDeposit(=''CASH''),1003-VI-CheckingAndSavings(IN(''CHECKING'',''SAVINGS''),1003-VI-StocksAndBonds(IN(''CHECKING'',''SAVINGS';
COMMENT ON COLUMN UPAsset.ACCOUNT_NUMBER_OR_DESC IS 're-ap-xx-xx.a120a,re-ap-xx-xx.a130 (=Year, Make, Model) or ,re-ap-xx-xx.a130 (Other Asset Description),hb-ap-xx-xx.a120a,hb-ap-xx-xx.a130 (=Year, Make, Model) or ,hb-ap-xx-xx.a130 (Other Asset Description),1003-VI-CashDeposit(=''CASH''),1003-VI-CheckingAndSavings(IN(''CHECKING'',''SAVINGS''),1003-VI-StocksAndBonds(IN(''CHECKING'',''SAVINGS';
COMMENT ON COLUMN UPAsset.ASSET_VALUE IS 're-ap-xx-xx.a120a,re-ap-xx-xx.a130,re-ap-xx-xx.a120a,re-ap-xx-xx.a130,hb-ap-xx-xx.a120a,hb-ap-xx-xx.a130,hb-ap-xx-xx.a120a,hb-ap-xx-xx.a130,1003-VI-CashDeposit(=''CASH''),1003-VI-CheckingAndSavings(IN(''CHECKING'',''SAVINGS''),1003-VI-StocksAndBonds(IN(''CHECKING'',''SAVINGS';
COMMENT ON COLUMN UPAsset.PART_OF_DOWNPAYMENT_YN IS 'Part of Downpayment Flag. hb-ap-xx-xx.a120a';
CREATE INDEX ASST_INDEX2 ON UPAsset
(
       BORROWERID                     ASC,
       APPLICATIONID                  ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX ASST_INDEX3 ON UPAsset
(
       ASSET_TYPE                     ASC
)
       TABLESPACE MU_BIGIND
;


CREATE TABLE DeclareConditionDomain (
       OtherName            VARCHAR2(80) NOT NULL,
       DCTY_NAME            VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37841
                                          CHECK (DCTY_NAME = Upper(DCTY_NAME)),
       Description          VARCHAR2(30) NOT NULL,
       LongDescription      VARCHAR2(200) NULL,
       SORTORDER            NUMBER(27) NULL,
       CONSTRAINT DCTY_INDEX0 
              PRIMARY KEY (DCTY_NAME)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

CREATE INDEX DCTY_INDEX1 ON DeclareConditionDomain
(
       OtherName                      ASC
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE UPDeclaration (
       APPLICATIONID        NUMBER(27) NOT NULL,
       BORROWERID           NUMBER(27) NOT NULL,
       DECLARATION_NAME_DOMAIN VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37842
                                          CHECK (DECLARATION_NAME_DOMAIN = Upper(DECLARATION_NAME_DOMAIN)),
       DECLARATION_YN       VARCHAR2(1) DEFAULT 'Y' NOT NULL
                                   CONSTRAINT IS_Y_OR_N7416
                                          CHECK (DECLARATION_YN IN ('Y','N')),
       CONSTRAINT DECL_INDEX0 
              PRIMARY KEY (APPLICATIONID, BORROWERID, 
              DECLARATION_NAME_DOMAIN)
       USING INDEX
              TABLESPACE MU_BIGIND, 
       CONSTRAINT R_143
              FOREIGN KEY (BORROWERID, APPLICATIONID)
                             REFERENCES UPBorrower
                             ON DELETE CASCADE, 
       CONSTRAINT R_85
              FOREIGN KEY (DECLARATION_NAME_DOMAIN)
                             REFERENCES DeclareConditionDomain
)
       TABLESPACE MU_BIGTAB
;

COMMENT ON TABLE UPDeclaration IS 'This is used to track a list of posative/negativre responses to the declaration questions. For a given applciation there will always be the same number of declarations as there are rows in the DeclareConditionDomain.';
COMMENT ON COLUMN UPDeclaration.APPLICATIONID IS 'Internal ID';
COMMENT ON COLUMN UPDeclaration.BORROWERID IS 'Internal ID';
COMMENT ON COLUMN UPDeclaration.DECLARATION_NAME_DOMAIN IS 'Name of declaration. The text descriptions of each declarations live in DeclareCondtionDomain.LongDescription. re-ap-xx-xx.a080,hb-ap-xx-xx.a080';
COMMENT ON COLUMN UPDeclaration.DECLARATION_YN IS 're-ap-xx-xx.a080,hb-ap-xx-xx.a080. Either Y or N. Note that not all ''good'' answers are ''Y''. A full set always exists for each borrower.';
CREATE INDEX DECL_INDEX1 ON UPDeclaration
(
       DECLARATION_NAME_DOMAIN        ASC
)
       TABLESPACE MU_BIGIND
;


CREATE TABLE LiabilityTypeDomain (
       LITY_Name            VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37843
                                          CHECK (LITY_Name = Upper(LITY_Name)),
       Description          VARCHAR2(30) NOT NULL,
       OtherName            VARCHAR2(80) NOT NULL,
       LongDescription      VARCHAR2(200) NULL,
       SORTORDER            NUMBER(27) NULL,
       CONSTRAINT LITY_INDEX0 
              PRIMARY KEY (LITY_Name)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

CREATE INDEX LITY_INDEX1 ON LiabilityTypeDomain
(
       OtherName                      ASC
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE UPBorrowerLiability (
       APPLICATIONID        NUMBER(27) NOT NULL,
       BORROWERID           NUMBER(27) NOT NULL,
       LIABILITYID          NUMBER(27) NOT NULL,
       LIABILITY_TYPE_DOMAIN VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37844
                                          CHECK (LIABILITY_TYPE_DOMAIN = Upper(LIABILITY_TYPE_DOMAIN)),
       CREDITOR_NAME        VARCHAR2(80) NOT NULL,
       RESIDENCEID          NUMBER(27) NULL,
       MTH_PAYMENT_AMOUNT   NUMBER(12,2) DEFAULT 0 NOT NULL,
       UNPAID_BALANCE       NUMBER(12,2) DEFAULT 0 NOT NULL,
       CONSTRAINT LIAB_INDEX0 
              PRIMARY KEY (APPLICATIONID, BORROWERID, LIABILITYID)
       USING INDEX
              TABLESPACE MU_BIGIND, 
       CONSTRAINT R_139
              FOREIGN KEY (APPLICATIONID, BORROWERID, RESIDENCEID)
                             REFERENCES UPResidence
                             ON DELETE CASCADE, 
       CONSTRAINT LTD_DUL
              FOREIGN KEY (LIABILITY_TYPE_DOMAIN)
                             REFERENCES LiabilityTypeDomain, 
       CONSTRAINT R_11
              FOREIGN KEY (BORROWERID, APPLICATIONID)
                             REFERENCES UPBorrower
                             ON DELETE CASCADE
)
       TABLESPACE MU_BIGTAB
;

COMMENT ON COLUMN UPBorrowerLiability.APPLICATIONID IS 'Internal ID';
COMMENT ON COLUMN UPBorrowerLiability.BORROWERID IS 'Internal ID';
COMMENT ON COLUMN UPBorrowerLiability.LIABILITYID IS 'Internal ID';
COMMENT ON COLUMN UPBorrowerLiability.LIABILITY_TYPE_DOMAIN IS 'Type of liability. MORTGAGEONRESIDENCE  implies residenceId    
LOANSECUREDONRESIDENCE refers to additional loans secured against property and implies residenceid has value. 
NONPROPERTYLOAN refers to all other liabilities.. re-ap-xx-xx.a070,re-ap-xx-xx.a135,hb-ap-xx-xx.a070a,hb-ap-xx-xx.a135,1003-VI-Liabilities';
COMMENT ON COLUMN UPBorrowerLiability.CREDITOR_NAME IS 're-ap-xx-xx.a070,re-ap-xx-xx.a135,hb-ap-xx-xx.a070a,hb-ap-xx-xx.a135,1003-VI-Liabilities';
COMMENT ON COLUMN UPBorrowerLiability.UNPAID_BALANCE IS 're-ap-xx-xx.a070,re-ap-xx-xx.a135,hb-ap-xx-xx.a070a,hb-ap-xx-xx.a135,1003-VI-Liabilities';
COMMENT ON COLUMN UPBorrowerLiability.MTH_PAYMENT_AMOUNT IS 'Monthly Payment Amount. re-ap-xx-xx.a070,re-ap-xx-xx.a135,hb-ap-xx-xx.a070a,hb-ap-xx-xx.a135,1003-V-OtherFinancing,1003-VI-Liabilities';
COMMENT ON COLUMN UPBorrowerLiability.RESIDENCEID IS 'Internal ID of resiedence if Liability is secured against a Residence. re-ap-xx-xx.a070,re-ap-xx-xx.a135 (ALWAYS NULL),hb-ap-xx-xx.a070a,hb-ap-xx-xx.a135 (ALWAYS NULL)';
CREATE INDEX LIAB_INDEX1 ON UPBorrowerLiability
(
       BORROWERID                     ASC,
       APPLICATIONID                  ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX LIAB_INDEX2 ON UPBorrowerLiability
(
       RESIDENCEID                    ASC,
       APPLICATIONID                  ASC,
       BORROWERID                     ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX LIAB_INDEX3 ON UPBorrowerLiability
(
       LIABILITY_TYPE_DOMAIN          ASC
)
       TABLESPACE MU_BIGIND
;


CREATE TABLE UPRealEstate (
       APPLICATIONID        NUMBER(27) NOT NULL,
       BORROWERID           NUMBER(27) NOT NULL,
       PRESENT_MKT_VALUE    NUMBER(12,2) NOT NULL,
       REALESTATEID         NUMBER(27) NOT NULL,
       AddressID            NUMBER(27) NULL,
       PROPERTY_OCCUPANCY_DOMAIN VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37845
                                          CHECK (PROPERTY_OCCUPANCY_DOMAIN = Upper(PROPERTY_OCCUPANCY_DOMAIN)),
       MTH_MORTGAGE_PAYMENTS NUMBER(12,2) NULL,
       MTH_TAXES_INSURANCE  NUMBER(12,2) NULL,
       MTH_GROSS_RENTAL_INCOME NUMBER(12,2) NULL,
       MTH_OTHER_EXPENSES   NUMBER(12,2) NULL,
       PROP_DISPOSITION_DOMAIN VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37846
                                          CHECK (PROP_DISPOSITION_DOMAIN = Upper(PROP_DISPOSITION_DOMAIN)),
       PROP_TYPE_DOMAIN     VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37847
                                          CHECK (PROP_TYPE_DOMAIN = Upper(PROP_TYPE_DOMAIN)),
       MORTGAGE_HOLDER      VARCHAR2(80) NULL,
       OUTSTANDING_BALANCE  NUMBER(12,2) NULL,
       CONSTRAINT REES_INDEX0 
              PRIMARY KEY (APPLICATIONID, BORROWERID, REALESTATEID)
       USING INDEX
              TABLESPACE MU_BIGIND, 
       CONSTRAINT R_147
              FOREIGN KEY (AddressID)
                             REFERENCES UPAddress, 
       CONSTRAINT R_146
              FOREIGN KEY (PROPERTY_OCCUPANCY_DOMAIN)
                             REFERENCES PropertyOccupancyDomain, 
       CONSTRAINT R_65
              FOREIGN KEY (PROP_TYPE_DOMAIN)
                             REFERENCES TypeOfPropertyDomain, 
       CONSTRAINT R_64
              FOREIGN KEY (PROP_DISPOSITION_DOMAIN)
                             REFERENCES PropertyUsageDomain, 
       CONSTRAINT R_33
              FOREIGN KEY (BORROWERID, APPLICATIONID)
                             REFERENCES UPBorrower
                             ON DELETE CASCADE
)
       TABLESPACE MU_BIGTAB
;

COMMENT ON COLUMN UPRealEstate.APPLICATIONID IS 'Internal ID';
COMMENT ON COLUMN UPRealEstate.BORROWERID IS 'Internal ID';
COMMENT ON COLUMN UPRealEstate.PROPERTY_OCCUPANCY_DOMAIN IS 'Occupancy Type.';
COMMENT ON COLUMN UPRealEstate.PROP_TYPE_DOMAIN IS 're-ap-xx-xx.a125a,hb-ap-xx-xx.a125a,1003-VI-Propertytype';
COMMENT ON COLUMN UPRealEstate.PRESENT_MKT_VALUE IS 're-ap-xx-xx.a125a,hb-ap-xx-xx.a125a,1003-VI-PresentMktValue';
COMMENT ON COLUMN UPRealEstate.MTH_MORTGAGE_PAYMENTS IS 're-ap-xx-xx.a125a,hb-ap-xx-xx.a125a,1003-V-Rental,1003-VI-MortgagePayments';
COMMENT ON COLUMN UPRealEstate.MTH_TAXES_INSURANCE IS 're-ap-xx-xx.a125a,hb-ap-xx-xx.a125a,1003-V-Rental,1003-VI-InsuranceTaxesMisc';
COMMENT ON COLUMN UPRealEstate.MTH_OTHER_EXPENSES IS 're-ap-xx-xx.a125a,hb-ap-xx-xx.a125a,1003-V-Rental';
COMMENT ON COLUMN UPRealEstate.MORTGAGE_HOLDER IS 're-ap-xx-xx.a125a,hb-ap-xx-xx.a125a';
COMMENT ON COLUMN UPRealEstate.PROP_DISPOSITION_DOMAIN IS 're-ap-xx-xx.a125a,hb-ap-xx-xx.a125a,1003-VI-PropertyAddress';
COMMENT ON COLUMN UPRealEstate.MTH_GROSS_RENTAL_INCOME IS 're-ap-xx-xx.a125a,hb-ap-xx-xx.a125a,1003-V-Rental,1003-V-Rental,1003-VI-GrossRentalIncome';
CREATE INDEX REES_INDEX6 ON UPRealEstate
(
       PROPERTY_OCCUPANCY_DOMAIN      ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX REES_INDEX1 ON UPRealEstate
(
       AddressID                      ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX REES_INDEX2 ON UPRealEstate
(
       BORROWERID                     ASC,
       APPLICATIONID                  ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX REES_INDEX3 ON UPRealEstate
(
       PROP_DISPOSITION_DOMAIN        ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX REES_INDEX4 ON UPRealEstate
(
       PROP_TYPE_DOMAIN               ASC
)
       TABLESPACE MU_BIGIND
;


CREATE TABLE META_DOMAIN (
       DOMAIN_NAME          VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_NOSPACE1010
                                          CHECK (DOMAIN_NAME = Replace(DOMAIN_NAME, ' ','')),
       DOMAIN_PK_KEY_COLUMN VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37848
                                          CHECK (DOMAIN_PK_KEY_COLUMN = Upper(DOMAIN_PK_KEY_COLUMN)),
       LONG_DESCRIPTION     VARCHAR2(200) NOT NULL,
       CONSTRAINT MEDM_INDEX0 
              PRIMARY KEY (DOMAIN_NAME)
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE HGPAGEKEYWORDS (
       PageKeywordID        NUMBER(27) NOT NULL,
       PageKeyword          VARCHAR2(40) NOT NULL
                                   CONSTRAINT STRING_UCASE37849
                                          CHECK (PageKeyword = Upper(PageKeyword)),
       CONSTRAINT PGKW_INDEX0 
              PRIMARY KEY (PageKeywordID)
       USING INDEX
              TABLESPACE MU_TINYIND,
       CONSTRAINT PGKW_INDEX1
       UNIQUE (
              PageKeyword
       )
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;


CREATE TABLE HGSITEPAGES (
       SitePageID           NUMBER(27) NOT NULL,
       Site                 VARCHAR2(80) NOT NULL,
       PageName             VARCHAR2(200) NOT NULL,
       PageTitle            VARCHAR2(180) NOT NULL,
       Importance           NUMBER(2) DEFAULT 1 NOT NULL
                                   CONSTRAINT NUMBER_BETWEEN_0_AND_10533
                                          CHECK (Importance BETWEEN 0 AND 10),
       SEARCHABLE_YN        VARCHAR2(1) DEFAULT 'N' NOT NULL
                                   CONSTRAINT IS_Y_OR_N7417
                                          CHECK (SEARCHABLE_YN IN ('Y','N')),
       CONSTRAINT STPG_INDEX0 
              PRIMARY KEY (SitePageID)
       USING INDEX
              TABLESPACE MU_TINYIND,
       CONSTRAINT STPG_INDEX1
       UNIQUE (
              Site,
              PageName
       )
       USING INDEX
              TABLESPACE MU_TINYIND
)
       TABLESPACE MU_TINYTAB
       CACHE 
;


CREATE TABLE HGPAGEKEYWORDASSOCIATION (
       PageKeywordID        NUMBER(27) NOT NULL,
       SitePageID           NUMBER(27) NOT NULL,
       Importance           NUMBER(2) DEFAULT 1 NOT NULL
                                   CONSTRAINT NUMBER_BETWEEN_0_AND_10534
                                          CHECK (Importance BETWEEN 0 AND 10),
       CONSTRAINT PWAS_INDEX0 
              PRIMARY KEY (PageKeywordID, SitePageID)
       USING INDEX
              TABLESPACE MU_TINYIND, 
       CONSTRAINT R_105
              FOREIGN KEY (SitePageID)
                             REFERENCES HGSITEPAGES
                             ON DELETE CASCADE, 
       CONSTRAINT R_104
              FOREIGN KEY (PageKeywordID)
                             REFERENCES HGPAGEKEYWORDS
                             ON DELETE CASCADE
)
       TABLESPACE MU_TINYTAB
       CACHE 
;

CREATE INDEX PWAS_INDEX1 ON HGPAGEKEYWORDASSOCIATION
(
       PageKeywordID                  ASC
)
       TABLESPACE MU_TINYIND
;

CREATE INDEX PWAS_INDEX2 ON HGPAGEKEYWORDASSOCIATION
(
       SitePageID                     ASC
)
       TABLESPACE MU_TINYIND
;


CREATE TABLE UpMyProfileTable (
       UserID               NUMBER(27) NOT NULL,
       FirstName            VARCHAR2(80) NULL,
       LastName             VARCHAR2(80) NULL,
       HomePhone            VARCHAR2(10) NULL,
       CellPhone            VARCHAR2(10) NULL,
       Fax                  VARCHAR2(10) NULL,
       Pager                VARCHAR2(10) NULL,
       WorkPhoneExt         VARCHAR2(5) NULL,
       WorkFax              VARCHAR2(10) NULL,
       WorkPhone            VARCHAR2(10) NULL,
       PagerExt             VARCHAR2(5) NULL,
       StreetName           VARCHAR2(80) NULL,
       StreetName2          VARCHAR2(80) NULL,
       City                 VARCHAR2(30) NULL,
       State                VARCHAR2(20) NULL,
       ZipCode              VARCHAR2(10) NULL,
       Country              VARCHAR2(30) NULL,
       defaultaddressusageid NUMBER(27) NULL,
       BorrowerFirstName    VARCHAR2(80) NULL
                                   CONSTRAINT STRING_UCASE37850
                                          CHECK (BorrowerFirstName = Upper(BorrowerFirstName)),
       BorrowerLastName     VARCHAR2(80) NULL
                                   CONSTRAINT STRING_UCASE37851
                                          CHECK (BorrowerLastName = Upper(BorrowerLastName)),
       EMAIL                VARCHAR2(80) NULL,
       CONSTRAINT MPRO_INDEX0 
              PRIMARY KEY (UserID)
       USING INDEX
              INITRANS 2
              MAXTRANS 255
              TABLESPACE MU_BIGIND
              STORAGE ( 
                     INITIAL 4194304
                     NEXT 4194304
                     MINEXTENTS 1
                     MAXEXTENTS 505
                     BUFFER_POOL DEFAULT
              ) 
              LOGGING, 
       CONSTRAINT R_107
              FOREIGN KEY (UserID)
                             REFERENCES UP_USER
                             ON DELETE CASCADE
)
       TABLESPACE MU_BIGTAB
;

CREATE INDEX MPRO_INDEX1 ON UpMyProfileTable
(
       FirstName                      ASC
)
       TABLESPACE MU_BIGIND
;

CREATE INDEX MPRO_INDEX2 ON UpMyProfileTable
(
       LastName                       ASC
)
       TABLESPACE MU_BIGIND
;


CREATE TABLE UPApplicationBlob (
       UserID               NUMBER(27) NOT NULL,
       ApplicationBlob      LONG RAW NULL,
       Loan_ID              NUMBER(27) NOT NULL,
       ApplicationStatus    NUMBER DEFAULT 0 NOT NULL,
       ApplicationTimestamp DATE DEFAULT SYSDATE NOT NULL,
       CONSTRAINT ABLB_INDEX0 
              PRIMARY KEY (Loan_ID, UserID)
       USING INDEX
              TABLESPACE MU_BLOBSPACE, 
       CONSTRAINT R_121
              FOREIGN KEY (UserID)
                             REFERENCES UP_USER
                             ON DELETE CASCADE
)
       PCTFREE 70
       PCTUSED 1
       TABLESPACE MU_BLOBSPACE
;


CREATE TABLE UPPropertyLoan (
       APPLICATIONID        NUMBER(27) NOT NULL,
       PROPERTYLOANID       NUMBER(27) NOT NULL,
       CREDITOR_NAME        VARCHAR2(80) NOT NULL,
       MTH_PAYMENT_AMOUNT   NUMBER(12,2) DEFAULT 0 NOT NULL,
       UNPAID_BALANCE       NUMBER(12,2) DEFAULT 0 NOT NULL,
       CONSTRAINT LOAN_INDEX0 
              PRIMARY KEY (PROPERTYLOANID, APPLICATIONID)
       USING INDEX
              TABLESPACE MU_BIGIND, 
       CONSTRAINT R_145
              FOREIGN KEY (APPLICATIONID)
                             REFERENCES UPApplication
                             ON DELETE CASCADE
)
       TABLESPACE MU_BIGTAB
;

COMMENT ON COLUMN UPPropertyLoan.PROPERTYLOANID IS 'Internal ID';
COMMENT ON COLUMN UPPropertyLoan.APPLICATIONID IS 'Internal ID';
COMMENT ON COLUMN UPPropertyLoan.UNPAID_BALANCE IS 'Unpaid balance of an existing loan secured on a property that is being refiananced.  re-ap-xx-xx.a045a,1003-II-AmountExistingLiens';
COMMENT ON COLUMN UPPropertyLoan.MTH_PAYMENT_AMOUNT IS 're-ap-xx-xx.a045a';
COMMENT ON COLUMN UPPropertyLoan.CREDITOR_NAME IS 'Monthly Payment. re-ap-xx-xx.a045a';
CREATE INDEX LOAN_INDEX1 ON UPPropertyLoan
(
       APPLICATIONID                  ASC
)
       TABLESPACE MU_BIGIND
;


CREATE TABLE HGWEBNEWS (
       ITEM_IDENTIFIER      VARCHAR2(80) NOT NULL,
       ITEM_TITLE           VARCHAR2(200) NOT NULL,
       ITEM_SUBTITLE        VARCHAR2(200) NULL,
       ITEM_CREATE_DATETIME DATE DEFAULT SYSDATE NOT NULL,
       ITEM_EXPIRE_DATETIME DATE NULL,
       ITEM_BYLINE          VARCHAR2(80) NULL,
       ITEM_STATUS          VARCHAR2(40) DEFAULT 'NEW' NOT NULL
                                   CONSTRAINT IS_NEW_DECLINED_APPROVED93
                                          CHECK (ITEM_STATUS IN ('NEW','DECLINED','APPROVED')),
       ITEM_SOURCE          VARCHAR2(40) DEFAULT 'INMAN' NOT NULL
                                   CONSTRAINT STRING_UCASE37852
                                          CHECK (ITEM_SOURCE = Upper(ITEM_SOURCE)),
       ITEM_TOPIC           VARCHAR2(40) NULL
                                   CONSTRAINT STRING_UCASE37853
                                          CHECK (ITEM_TOPIC = Upper(ITEM_TOPIC)),
       ITEM_CATEGORY        VARCHAR2(200) DEFAULT 'NEWS' NULL,
       ITEM_COPYRIGHT_OWNER VARCHAR2(80) NULL,
       ITEM_TEXTBLOCK       LONG NULL,
       ITEM_PUBLISH_DATETIME DATE NULL,
       CONSTRAINT NEWS_INDEX0 
              PRIMARY KEY (ITEM_IDENTIFIER, ITEM_SOURCE)
       USING INDEX
              TABLESPACE MU_BIGIND
)
       TABLESPACE MU_BIGTAB
;

/**
This index won't work in Oracle Versions 
prior to 8i. Not having this index is not
the end of the world.
**/

CREATE INDEX GLOS_INDEX1 ON HGGlossary
(UPPER(termname)
,UPPER(termCategory))
TABLESPACE MU_BIGIND
;




/****
Change default ane temporary tablespaces for users...
****/

ALTER USER OGNC        DEFAULT TABLESPACE MU_BIGTAB   TEMPORARY TABLESPACE TEMP;

alter table upresidence drop constraint  UPResidence_RGE;

alter table upapplication drop constraint r_179;
alter table upapplication drop constraint r_181;
alter table upapplication drop constraint r_190;
alter table upapplication drop constraint r_191;


exit

spool off

