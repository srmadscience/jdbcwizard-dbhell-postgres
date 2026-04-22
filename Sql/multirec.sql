
create or replace package multirec as
--
TYPE account_address_t IS RECORD (
    public_id      number,
    address_type   VARCHAR2(20), --address_types.type%TYPE,
    firstname      VARCHAR2(40), --customers.firstname%TYPE,
    surname        VARCHAR2(40), --customers.surname%TYPE,
    job_desc       VARCHAR2(40), --customers.job_desc%TYPE DEFAULT NULL,
    company_name   VARCHAR2(300), --customers.company_name%TYPE DEFAULT NULL,
    phone          VARCHAR2(20), --customers.phone%TYPE DEFAULT NULL,
    office_phone   VARCHAR2(20), --customers.office_phone%TYPE DEFAULT NULL,
    cell_phone     VARCHAR2(20), --customers.cell_phone%TYPE DEFAULT NULL,
    fax            VARCHAR2(20), --customers.fax%TYPE DEFAULT NULL,
    gender         VARCHAR2(1), --customers.gender%TYPE DEFAULT NULL, -- M or F
    co             VARCHAR2(34), -- customers.co%TYPE DEFAULT NULL,
    att            VARCHAR2(90), --customers.att%TYPE DEFAULT NULL,
    street_name    VARCHAR2(40), --div_locations.street_name%TYPE,
    house_no       VARCHAR2(40), --div_locations.house_no%TYPE,
    floor          VARCHAR2(4), --div_locations.floor%TYPE DEFAULT NULL,
    sidedoor       VARCHAR2(4), --div_locations.sidedoor%TYPE DEFAULT NULL,
    main_door      VARCHAR2(4), --div_locations.main_door%TYPE DEFAULT NULL,
    postbox        NUMBER(8), --div_locations.postbox%TYPE DEFAULT NULL,
    zip            VARCHAR2(8), --div_locations.zip%TYPE,
    city           VARCHAR2(20), --div_locations.city%TYPE,
    area           VARCHAR2(20), --div_locations.area%TYPE DEFAULT NULL,
    country#fk     VARCHAR2(2), --div_locations.country#fk%TYPE DEFAULT 'DK', -- from the gks_owner.gk_land table
    house_name     VARCHAR2(15) --div_locations.house_name%TYPE DEFAULT NULL
  );
--
  TYPE sales_order_t IS RECORD (
    id                    number,
    postal_address        account_address_t DEFAULT NULL,
    def_install_address   account_address_t DEFAULT NULL
  );
--
  FUNCTION initSalesOrderType /* (p_id                   IN  number,
                               p_postal_address       IN  account_address_t DEFAULT NULL,
                               p_def_install_address  IN  account_address_t DEFAULT NULL
                             ) */ RETURN sales_order_t;

--
end;
.
/

show errors

create or replace package body multirec as
--
  FUNCTION initSalesOrderType /* (  p_id                   IN  number, */
                                /* p_postal_address       IN  account_address_t DEFAULT NULL, */
                                /* p_def_install_address  IN  account_address_t DEFAULT NULL */
                             /*)*/ RETURN sales_order_t IS
--
    foo sales_order_t;
--
  BEGIN
--
    --foo.postal_address := p_postal_address;
    --foo.def_install_address := p_def_install_address;
--
    RETURN foo;
-- 
  END;
--
END;
.
/

show errors


