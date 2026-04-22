CREATE TYPE "DIVIDEND_DETAIL_OBJECT" AS OBJECT ( 
  "HV_DAY" NUMBER(8, 0),
  "EX_DAY" NUMBER(8, 0),
  "PAY_DAY" NUMBER(8, 0),
  "AMOUNT" FLOAT(64) );
.
/

CREATE TYPE "DIVIDEND_DETAIL_COLLECTION" AS 
   TABLE OF "DIVIDEND_DETAIL_OBJECT";
.
/

CREATE OR REPLACE PROCEDURE "SP_UPDATE_INSERT_DIVIDEND_LIST" 
 (  in_div_id                IN int,
    in_div_version           IN int,
    in_div_udl_id            IN int,
    in_div_list              IN dividend_detail_collection,
    in_check_version         IN int,
    version_success         OUT int,
    new_version             OUT int,
    new_div_id              OUT int )

IS
--
BEGIN
--
NULL;
--
END;
.

/


