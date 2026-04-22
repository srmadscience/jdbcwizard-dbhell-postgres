create or replace view sales_view_colon as
select CHANNEL||';'||
WORLDPAY_ID||';'||
CLIENT_SESSION||';'||
CLIENT_IP||';'||
HIT_DATETIME||';'||
CUSTOMER_COMPANY||';'||
CC_CUST_EMAIL||';'||
CUSTOMER_URL||';'||
B_NAME||';'||
B_ADDRESS||';'||
B_ZIP||';'||
B_COUNTRY||';'||
S_NAME||';'||
S_ADDRESS||';'||
S_ZIP||';'||
S_COUNTRY||';'||
SHIP_METHOD||';'||
COUPON_TYPE||';'||
SHIP_PRODUCT_COST||';'||
SHIP_VAT||';'||
SHIP_SHIPCOST||';'||
CURRENCY||';'||
QUANTITY||';'||
SKU||';'||
PO_NUMBER||';' a_row
,hit_datetime
from sales_view;

create or replace view sales_view_colon_xrate as
select CHANNEL||';'||
WORLDPAY_ID||';'||
CLIENT_SESSION||';'||
CLIENT_IP||';'||
HIT_DATETIME||';'||
CUSTOMER_COMPANY||';'||
CC_CUST_EMAIL||';'||
CUSTOMER_URL||';'||
B_NAME||';'||
B_ADDRESS||';'||
B_ZIP||';'||
B_COUNTRY||';'||
S_NAME||';'||
S_ADDRESS||';'||
S_ZIP||';'||
S_COUNTRY||';'||
SHIP_METHOD||';'||
COUPON_TYPE||';'||
SHIP_PRODUCT_COST||';'||
SHIP_VAT||';'||
SHIP_SHIPCOST||';'||
CURRENCY||';'||
QUANTITY||';'||
SKU||';'||
PO_NUMBER||';'|| 
SHIP_VAT_EUR||';'|| 
SHIP_SHIPCOST_EUR||';' ||
ship_vatfree_export||';'||
ship_vatpaid_export||';'
a_row
,hit_datetime
from sales_view_xrate;

