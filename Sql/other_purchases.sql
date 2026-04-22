drop table other_purchases;

create table other_purchases
(CHANNEL                                            VARCHAR2(8)
,WORLDPAY_ID                                        NUMBER
,CLIENT_SESSION                                     VARCHAR2(100)
,CLIENT_IP                                          VARCHAR2(100)
,HIT_DATETIME                                       DATE
,CUSTOMER_COMPANY                                   VARCHAR2(100)
,CC_CUST_EMAIL                                      VARCHAR2(256)
,CUSTOMER_URL                                       VARCHAR2(1024)
,B_NAME                                             VARCHAR2(121)
,B_ADDRESS                                          VARCHAR2(323)
,B_ZIP                                              VARCHAR2(100)
,B_COUNTRY                                          VARCHAR2(100)
,S_NAME                                             VARCHAR2(121)
,S_ADDRESS                                          VARCHAR2(323)
,S_ZIP                                              VARCHAR2(100)
,S_COUNTRY                                          VARCHAR2(100)
,SHIP_METHOD                                        VARCHAR2(100)
,COUPON_TYPE                                        VARCHAR2(80)
,SHIP_PRODUCT_COST                                  NUMBER
,SHIP_VAT                                           NUMBER
,SHIP_SHIPCOST                                      NUMBER
,CURRENCY                                           VARCHAR2(100)
,QUANTITY                                           NUMBER
,SKU                                                NUMBER
,po_number                                          varchar2(30))
tablespace osoft;

insert into other_purchases
(CHANNEL                   
,WORLDPAY_ID                                        
,CLIENT_SESSION                                     
,CLIENT_IP                                          
,HIT_DATETIME                                       
,CUSTOMER_COMPANY                                   
,CC_CUST_EMAIL                                      
,CUSTOMER_URL                                       
,B_NAME                                             
,B_ADDRESS                                          
,B_ZIP                                              
,B_COUNTRY                                          
,S_NAME                                             
,S_ADDRESS                                          
,S_ZIP                                              
,S_COUNTRY                                          
,SHIP_METHOD                                        
,COUPON_TYPE                                        
,SHIP_PRODUCT_COST                                  
,SHIP_VAT                                           
,SHIP_SHIPCOST                                      
,CURRENCY                                           
,QUANTITY                                           
,SKU                                                
,po_number)
values
('PO'
,null
,null
,null
,to_date('07-Jul-2004 10:24:00','DD-MON-YYYY HH24:MI:SS')
,'France Telecom'
,'fouad.ibnmajdoubhassani@francetelecom.com'
,null
,'France Telecom'
, 'UC Ile de France, 16 Bd du Mont d''est - BP 14, NOISY LE GRAND Cedex'                                  
, '93161'                               
,'France'
,'Fouad IBN MAJDOUB HASSANI'
,'38-40, rue du General Leclerc, Issy les Moulineaux Cedex 9'
,'92794'
,'France'
,'7 day Airmail'
,'KAR120C'
,299.39 - 62.87
,62.87
,299.39
,'USD'
,1
,19851
,'42807222');

insert into other_purchases
(CHANNEL
,WORLDPAY_ID
,CLIENT_SESSION
,CLIENT_IP
,HIT_DATETIME
,CUSTOMER_COMPANY
,CC_CUST_EMAIL
,CUSTOMER_URL
,B_NAME
,B_ADDRESS
,B_ZIP
,B_COUNTRY
,S_NAME
,S_ADDRESS
,S_ZIP
,S_COUNTRY
,SHIP_METHOD
,COUPON_TYPE
,SHIP_PRODUCT_COST
,SHIP_VAT
,SHIP_SHIPCOST
,CURRENCY
,QUANTITY
,SKU
,po_number)
values
('PO'
,null
,null
,null
,to_date('14-Oct-2004 14:56:00','DD-MON-YYYY HH24:MI:SS')
,'AON'
,'Gregory_W_Walczak@asg.aon.com'
,null
,'AON'
, 'Aon Center 200 East Randolph Street, 18th Floor Chicago, Illinois' 
, '60601'
,'United_States'
,'Gregory W Walczak'
, 'Aon Center 200 East Randolph Street, 18th Floor Chicago, Illinois' 
, '60601'
,'United_States'
,'7 day Airmail'
,'KAR120C'
,374.25
,0
,374.25
,'USD'
,1
,22469
,null);


insert into other_purchases
(CHANNEL
,WORLDPAY_ID
,CLIENT_SESSION
,CLIENT_IP
,HIT_DATETIME
,CUSTOMER_COMPANY
,CC_CUST_EMAIL
,CUSTOMER_URL
,B_NAME
,B_ADDRESS
,B_ZIP
,B_COUNTRY
,S_NAME
,S_ADDRESS
,S_ZIP
,S_COUNTRY
,SHIP_METHOD
,COUPON_TYPE
,SHIP_PRODUCT_COST
,SHIP_VAT
,SHIP_SHIPCOST
,CURRENCY
,QUANTITY
,SKU
,po_number)
values
('TRANSFER'
,null
,null
,null
,to_date('14-Jul-2005 12:15:00','DD-MON-YYYY HH24:MI:SS')
,'AUSELDA AED GROUP SPA'
,'a.sisani@auselda.it'
,'http://www.auselda.it/'
,'Auselda Aed Group'
, 'Via dell''Imbrecciato, 128 , 00149 ROMA, Italy'
, '00149'
,'Italy'
,'Dott. Andrea Sisani'
, 'Via dell''Imbrecciato, 128 , 00149 ROMA, Italy'
, '00149'
,'Italy'
,'7 day Airmail'
,null
,494.64
,103.87
,598.51
,'EUR'
,2
,40557
,null);


