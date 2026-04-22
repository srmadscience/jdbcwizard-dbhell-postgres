create or replace view
sales_view as
select substr('WORLDPAY',1,10) channel
     , transid worldpay_id 
     , client_session
     , client_ip
     , hit_time hit_datetime
     , customer_company
     , cc_cust_email
     , customer_url
     , cc_cust_name b_name
     , cc_cust_address b_address
     , cc_cust_zip b_zip
     , cc_cust_country b_country
     , cc_cust_name s_name
     , cc_cust_address s_address
     , cc_cust_zip s_zip
     , cc_cust_country s_country
     , ship_method
     , coupon_type
     , ship_product_cost
     , ship_vat
     , authamount ship_shipcost
     , authcurrency currency
     , quantity
     , sku
     , substr('',1,30) po_number
from worldpay_purchase
where rawauthmessage != 'cardbe.msg.testSuccess'
and   lower(cc_cust_email) != 'david.rolfe@pobox.com'
and   lower(cc_cust_email) != 'dwrolfe@orindasoft.com'
union all
select substr(decode(step_name, 'PayPal Purchase','PAYPAL','Purchase Order','PO','OTHER'),1,10) channel
     , to_number(null) worldpay_id 
     , client_session
     , client_ip
     , hit_time hit_datetime
     , customer_company
     , customer_email
     , customer_url
     , billto_firstname||' '||billto_lastname b_name
     , replace(ltrim(billto_address1 || ' ' || billto_address2 ||' ' || billto_city||' '||billto_state),'  ',' ') b_address
     , billto_zippostalcode b_zip
     , billto_country       b_country
     , billto_firstname||' '||billto_lastname s_name
     , replace(ltrim(shipto_address1 || ' ' || shipto_address2 ||' ' || shipto_city||' '||shipto_state),'  ',' ') s_address
     , shipto_zippostalcode s_zip
     , shipto_country       s_country
     , ship_method
     , coupon_type
     , ship_product_cost
     , ship_vat
     , ship_shipcost
     , substr('USD',1,3) currency
     , greatest(nvl(month_99_sku_qty,0)
               ,nvl(month_12_sku_qty,0) 
               ,nvl(month_9_sku_qty,0) 
               ,nvl(month_6_sku_qty,0) 
               ,nvl(month_3_sku_qty,0) 
               ,nvl(month_1_sku_qty,0) 
                ) quantity
     , greatest(nvl(month_99_sku_id,0)
               ,nvl(month_12_sku_id,0) 
               ,nvl(month_9_sku_id,0) 
               ,nvl(month_6_sku_id,0) 
               ,nvl(month_3_sku_id,0) 
               ,nvl(month_1_sku_id,0) 
                ) sku
     , po_number
from osoft_purchase_steps
where step_name in ('PayPal Purchase','Purchase Order')
and   customer_email not like '%orindasoft.com' 
and   customer_email not like 'f@f.com'
and   customer_email not like '%seahorse-design.com'
and   lower(customer_email) != 'david.rolfe@pobox.com'
and   customer_email !=       'sadf@lll.ll'
union all
select CHANNEL
,WORLDPAY_ID
,CLIENT_session
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
,po_number
from other_purchases
order by hit_datetime
/


create or replace view sales_view_xrate as
select s.*
, trunc(ship_vat * r.rate_value,2) ship_vat_eur
, trunc(ship_shipcost * r.rate_value,2) ship_shipcost_eur
,trunc(decode(nvl(ship_vat,0),0, ship_shipcost * r.rate_value ,0),2)  ship_vatfree_export
,trunc(decode(nvl(ship_vat,0),0, 0, (ship_shipcost - ship_vat) * r.rate_value),2)  ship_vatpaid_export
from sales_view s
   , exchange_rates r
where currency  = r.from_currency (+)
and   'EUR'     = r.to_currency (+)
and   trunc(hit_datetime) = r.rate_date (+)
/

