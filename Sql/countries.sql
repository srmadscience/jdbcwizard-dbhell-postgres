CREATE TABLE countries 
    ( country_id      CHAR(2) 
      CONSTRAINT  country_id_nn NOT NULL 
    , country_name    VARCHAR2(40) 
    , currency_name   VARCHAR2(25) 
    , currency_symbol VARCHAR2(3) 
    , region          VARCHAR2(15) 
    ,  CONSTRAINT     country_c_id_pk 
                     PRIMARY KEY (country_id) 
    ) 
    ORGANIZATION INDEX 
    INCLUDING   country_name 
    PCTTHRESHOLD 2 
    STORAGE 
     ( INITIAL  4K 
      NEXT  2K 
      PCTINCREASE 0 
      MINEXTENTS 1 
      MAXEXTENTS 1 ) 
   OVERFLOW 
    STORAGE 
      ( INITIAL  4K 
        NEXT  2K 
        PCTINCREASE 0 
        MINEXTENTS 1 
        MAXEXTENTS 1 ); 

insert into countries (country_id, country_name)
values
('EI','IRELAND');


