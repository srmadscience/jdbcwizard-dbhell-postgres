set echo on
set feedback on
set showmode on

connect system/manager@&1

drop user osoft cascade;

drop tablespace osoft including contents;
create tablespace osoft datafile '/export/data/oradata/&1/osoft.dbf' size 100M reuse;

alter tablespace osoft add datafile '/export/data/oradata/&1/osoft2.dbf' size 400M reuse;

alter tablespace osoft add datafile '/export/data/oradata/&1/osoft3.dbf' size 200M reuse;

drop tablespace osoft_sort including contents;
create temporary tablespace osoft_sort tempfile '/export/data/oradata/&1/osoft_sort.dbf' size 100M reuse;

grant connect, resource,dba to osoft identified by osoft;

alter user osoft default tablespace osoft;
alter user osoft temporary tablespace osoft_sort;


connect osoft/osoft@&1

exit

create or replace function ipmap(ip varchar2) return number as
--
begin
--
if ip like '%0'
or ip like '%1'
or ip like '%2'
or ip like '%3'
or ip like '%4' then
--
  return(0);
--
end if;
--
return (1);
--
end;
/

create table osoft_sitehit
(client_cookie			varchar2(100)
,client_session			varchar2(100)
,hit_time			date
,client_ip			varchar2(100)
,client_hostname_by_addr 	varchar2(100)
,client_agent			varchar2(255)
,url            		varchar2(2048)
,referrer			varchar2(2048)
,client_username 		varchar2(100)
,client_host 			varchar2(100)
,hit_path			varchar2(300)
,hit_path_trans			varchar2(300)
,hit_query_string		varchar2(2048)
,hit_request_method 		varchar2(100)
,hit_script_name		varchar2(100)
,hit_server_name                varchar2(100)
,hit_server_port                number
,hit_server_protocol		varchar2(100)
,hit_server_software		varchar2(100)
,download_filename              varchar2(100)
,download_username              varchar2(100)
,download_location     		varchar2(100)
,download_oracle_815_YN         varchar2(1)
,download_oracle_816_YN         varchar2(1)
,download_oracle_817_YN         varchar2(1)
,download_oracle_901_YN         varchar2(1)
,download_oracle_920_YN         varchar2(1)
,download_dba_yn		varchar2(1)
,download_java_yn		varchar2(1)
,download_techman_yn		varchar2(1)
,download_projman_yn		varchar2(1)
,download_nontechman_yn		varchar2(1)
,download_orgtype		varchar2(100)
,download_tz			varchar2(80)
,download_exper			varchar2(80)
,download_plsqlrec_yn		varchar2(1)
,download_objtype_yn            varchar2(1)
,download_varray_yn		varchar2(1)
,download_none_yn		varchar2(1)
,download_clueless_yn		varchar2(1)
,download_previous		varchar2(100)
,download_lic_accept_yn		varchar2(1)
,processed_n_or_null		varchar2(1) DEFAULT 'N')
TABLESPACE osoft;

alter table osoft_sitehit add
(adcode				varchar2(12));

create table adcodes
(adcode                         varchar2(12) not null
,descr				varchar2(80))
TABLESPACE osoft;

create table osoft_rawlog
(client_ip			varchar2(100)
,client_hostname_by_addr 	varchar2(100)
,client_username 		varchar2(100)
,request	 		varchar2(2048)
,request_referrer		varchar2(2048)
,hit_time_string		varchar2(100)
,hit_tz_string			varchar2(100)
,request_retcode		varchar2(50)
,request_size			varchar2(50)
,request_browser		varchar2(255)
,processed_n_or_null		varchar2(1) DEFAULT 'N')
TABLESPACE osoft;

alter table osoft_rawlog add
(ipmap number);



create table osoft_errorlog
(hit_time_string                varchar2(100)
,error_type			varchar2(100)
,client_ip                      varchar2(100)
,error_message                  varchar2(2048)
,processed_n_or_null            varchar2(1) DEFAULT 'N')
TABLESPACE osoft;



create table osoft_prospect
(client_cookie                  varchar2(100)
,client_session                 varchar2(100)
,hit_time                       date
,client_ip                      varchar2(100)
,client_hostname_by_addr        varchar2(100)
,org_name			varchar2(100)
,org_addr1			varchar2(100)
,org_addr2			varchar2(100)
,org_city			varchar2(100)
,org_region_state		varchar2(100)
,org_zip_postal_code		varchar2(100)
,org_country			varchar2(100)
,contact_name			varchar2(100)
,contact_email			varchar2(100)
,contact_phone			varchar2(100)
,contact_fax			vahchar2(100)
,copies_interest		number
,duration_interest		number
,comment			varchar2(255)
);

drop table osoft_prospect;

create table products
(product_name 	varchar2(80))
tablespace osoft;

ALTER TABLE products
       ADD  ( CONSTRAINT products_pk  PRIMARY KEY (product_name)
       USING INDEX
              TABLESPACE osoft) ;


insert into products values ('OrindaBuild 2.0');

create table builds
(build_number   number not null
,start_date 	date not null 
,end_date 	date )
tablespace osoft;

ALTER TABLE builds
       ADD  ( CONSTRAINT builds_pk  PRIMARY KEY (build_number)
       USING INDEX
              TABLESPACE osoft) ;

create sequence sku_seq start with 522 increment by 17;

create table skus
(sku_id         number          not null
,product_name   varchar2(80) 	not null
,build_number   number 		not null
,release_date     date         	not null
,expire_date	  date          not null
,sku_filename     varchar2(80)    not null)
tablespace osoft;

ALTER TABLE skus
       ADD  ( CONSTRAINT skus_pk  PRIMARY KEY (sku_id)
       USING INDEX
              TABLESPACE osoft) ;

ALTER TABLE skus
       ADD  ( CONSTRAINT skus_uk  UNIQUE (product_name, build_number, expire_date)
       USING INDEX
              TABLESPACE osoft) ;


ALTER TABLE skus
       ADD  ( CONSTRAINT sku_products
              FOREIGN KEY (product_name)
                             REFERENCES products 
                             ON DELETE CASCADE ) ;


ALTER TABLE skus
       ADD  ( CONSTRAINT sku_builds
              FOREIGN KEY (build_number)
                             REFERENCES builds ON DELETE CASCADE ) ;


create table coupon_types
(name	varchar2(80)
,type   varchar2(3) default 'PCT'
,pct	number)
tablespace osoft;

ALTER TABLE coupon_types
       ADD  ( CONSTRAINT coupon_types_pk  PRIMARY KEY (name)
       USING INDEX
              TABLESPACE osoft) ;

insert into coupon_types
(name, pct)
values 
('CUSTOMER 10',10);

insert into coupon_types
(name, pct)
values 
('CUSTOMER 20',20);

insert into coupon_types
(name, pct)
values 
('CUSTOMER 30',30);

insert into coupon_types
(name, pct)
values 
('CUSTOMER 40',40);

insert into coupon_types
(name, pct)
values 
('CUSTOMER 50',50);

insert into coupon_types
(name, pct)
values 
('CUSTOMER 60',60);

insert into coupon_types
(name, pct)
values 
('CUSTOMER 70',70);

insert into coupon_types
(name, pct)
values 
('CUSTOMER 80',80);

insert into coupon_types
(name, pct)
values 
('CUSTOMER 90',90);

insert into coupon_types
(name, pct)
values 
('CUSTOMER 100',100);

insert into coupon_types
(name, pct)
values 
('OSOFT_SPECIAL_PROMO_10',10);

insert into coupon_types
(name, pct)
values 
('OSOFT_SPECIAL_PROMO_20',20);

insert into coupon_types
(name, pct)
values 
('OSOFT_SPECIAL_PROMO_30',30);

insert into coupon_types
(name, pct)
values 
('OSOFT_SPECIAL_PROMO_40',40);

insert into coupon_types
(name, pct)
values 
('OSOFT_SPECIAL_PROMO_50',50);

insert into coupon_types
(name, pct)
values 
('OSOFT_SPECIAL_PROMO_60',60);

insert into coupon_types
(name, pct)
values 
('OSOFT_SPECIAL_PROMO_70',70);

insert into coupon_types
(name, pct)
values 
('OSOFT_SPECIAL_PROMO_80',80);

insert into coupon_types
(name, pct)
values 
('OSOFT_SPECIAL_PROMO_90',90);

insert into coupon_types
(name, pct)
values 
('OSOFT_SPECIAL_PROMO_100',100);

create table customers
(customer_id	varchar2(256) not null)
tablespace osoft;

alter table customers 
add
(customer_company       varchar2(80)
,customer_email		varchar2(256)
,customer_url		varchar2(1024)
,billto_firstname 	varchar2(40)
,billto_lastname    	varchar2(80)
,billto_address1	varchar2(80)
,billto_address2	varchar2(80)
,billto_city		varchar2(80)
,billto_state		varchar2(80)
,billto_zippostalcode   varchar2(12)
,billto_country		varchar2(80)
,billto_telephone	varchar2(80)
,shipto_address1	varchar2(80)
,shipto_address2	varchar2(80)
,shipto_city		varchar2(80)
,shipto_state		varchar2(80)
,shipto_zippostalcode   varchar2(12)
,shipto_country		varchar2(80)
,shipto_telephone	varchar2(80)
);

ALTER TABLE customers
       ADD  ( CONSTRAINT customers_pk  PRIMARY KEY (customer_id)
       USING INDEX
              TABLESPACE osoft) ;

insert into customers
(customer_id)
values
('GENERIC');


create table issued_coupons
(coupon_type varchar2(80) 	not null
,customer_id varchar2(256)	default 'GENERIC')
tablespace osoft;

ALTER TABLE issued_coupons
       ADD  ( CONSTRAINT issued_coupons_pk  PRIMARY KEY (coupon_type, customer_id)
       USING INDEX
              TABLESPACE osoft) ;

ALTER TABLE issued_coupons
       ADD  ( CONSTRAINT issued_coupons_coupon_types
              FOREIGN KEY (coupon_type)
                             REFERENCES coupon_types ON DELETE CASCADE ) ;

ALTER TABLE issued_coupons
       ADD  ( CONSTRAINT issued_coupons_customers
              FOREIGN KEY (customer_id)
                             REFERENCES customers ON DELETE CASCADE ) ;

insert into issued_coupons
(coupon_type,customer_id)
select name, 'GENERIC'
from coupon_types;


create table shipments
(shipment_id		varchar2(256) not null
,customer_id		varchar2(256) not null
,ship_method		varchar2(100) DEFAULT 'DOWNLOAD'
,ship_createdate	date 
,ship_status		varchar2(30)
,ship_carrier   	varchar2(100)
,ship_tracking_url 	varchar2(1024)
,ship_tracking_id	varchar2(80)
,shipto_address1	varchar2(80)
,shipto_address2	varchar2(80)
,shipto_city		varchar2(80)
,shipto_state		varchar2(80)
,shipto_zippostalcode   varchar2(12)
,shipto_country		varchar2(80)
,shipto_telephone	varchar2(80))
tablespace osoft;

alter table shipments
add
(ship_product_cost	number(9,2)
,ship_vat		number(9,2)
,ship_shipcost		number(9,2)
);

alter table osoft_rawlog
add (hit_seqno number
    ,hit_batchno number);

create sequence hit_seq;

alter table osoft_rawlog
add (entry_seqno number
    ,refer_source varchar2(40));

ALTER TABLE osoft_rawlog
       ADD  ( CONSTRAINT orl_pk  PRIMARY KEY (hit_seqno)
       USING INDEX
              TABLESPACE osoft) ;

ALTER TABLE osoft_rawlog
       ADD  ( CONSTRAINT orl_orl_fk
              FOREIGN KEY (entry_seqno)
             REFERENCES  osoft_rawlog );

create index orl_orl_fk_index
on osoft_rawlog(entry_seqno)
tablespace osoft;

alter table osoft_rawlog
add (is_a_download_y_or_null varchar2(1)
    ,is_a_pdf_y_or_null varchar2(1)
    ,is_a_purchase_y_or_null varchar2(1));

alter table osoft_rawlog
add (is_a_patch_y_or_null varchar2(1));

create index orl_dyn
on osoft_rawlog(is_a_download_y_or_null)
tablespace osoft;

create index orl_pyn
on osoft_rawlog(is_a_purchase_y_or_null)
tablespace osoft;

create index orl_fyn
on osoft_rawlog(is_a_pdf_y_or_null)
tablespace osoft;

create index orl_cyn
on osoft_rawlog(is_a_patch_y_or_null)
tablespace osoft;

create table refer_sources
(refer_source varchar2(40)
,monthly_fixed_cost number(9,2)
,per_unit_cost      number(9,2))
tablespace osoft;

alter table refer_sources
add (entry_point_y_or_null varchar2(1) );

alter table refer_sources
add (revenue_generating_y_or_null varchar2(1) );



ALTER TABLE refer_sources
       ADD  ( CONSTRAINT refer_sources_pk  PRIMARY KEY (refer_source)
       USING INDEX
              TABLESPACE osoft) ;


create index orl_rs_fk_index
on osoft_rawlog(refer_source)
tablespace osoft;

ALTER TABLE osoft_rawlog
       ADD  ( CONSTRAINT orl_rs_fk
              FOREIGN KEY (refer_source)
             REFERENCES  refer_sources);



ALTER TABLE shipments
       ADD  ( CONSTRAINT shipments_pk  PRIMARY KEY (shipment_id)
       USING INDEX
              TABLESPACE osoft) ;

alter table osoft_rawlog
add (refer_http varchar2(80));

alter table osoft_rawlog
add (refer_original_source varchar2(80));

alter table osoft_rawlog
add (hit_datetime date);

create index orl_ros_fk_index
on osoft_rawlog(refer_original_source)
tablespace osoft;

create index orl_client_ip_index
on osoft_rawlog(client_ip)
tablespace osoft;

create index orl_processed
on osoft_rawlog(processed_n_or_null)
tablespace osoft;

create index orl_client_hostname_by_index
on osoft_rawlog(client_hostname_by_addr)
tablespace osoft;

ALTER TABLE osoft_rawlog
       ADD  ( CONSTRAINT orl_ros_fk
              FOREIGN KEY (refer_original_source)
             REFERENCES  refer_sources);


create or replace view vw_download_totals as
select refer_source, trunc(hit_datetime) day, count(*) total
, sum(decode(ipmap, 0,1,0)) total0 
, sum(decode(ipmap, 1,1,0)) total1
from osoft_rawlog
where is_a_download_y_or_null is not null
group by refer_source, trunc(hit_datetime) 
/

create or replace view vw_hit_totals
as
select refer_source, trunc(hit_datetime) day, count(*) total
, sum(decode(ipmap, 0,1,0)) total0 
, sum(decode(ipmap, 1,1,0)) total1
from osoft_rawlog
where refer_source is not null
group by refer_source, trunc(hit_datetime) 
/

create or replace view vw_activity_days
as
select trunc(hit_datetime) day, refer_sources.refer_source, refer_sources.revenue_generating_y_or_null
from osoft_rawlog
   , refer_sources
group by trunc(hit_datetime), refer_sources.refer_source,refer_sources.revenue_generating_y_or_null;

create table purchases
(shipment_id 	varchar2(256) not null
,shipment_line  number not null
,sku_id		number not null
,sku_qty	number not null
,sku_price	number not null
,coupon_type 	varchar2(80)       
,customer_id 	varchar2(256)    )
tablespace osoft;

ALTER TABLE purchases
       ADD  ( CONSTRAINT purchases_pk  PRIMARY KEY (shipment_id,shipment_line)
       USING INDEX
              TABLESPACE osoft) ;


ALTER TABLE purchases
       ADD  ( CONSTRAINT purchases_skus
              FOREIGN KEY (sku_id)
                             REFERENCES skus ) ;

ALTER TABLE purchases
       ADD  ( CONSTRAINT purchases_shipments
              FOREIGN KEY (shipment_id)
                             REFERENCES shipments) ;

ALTER TABLE purchases
       ADD  ( CONSTRAINT purchases_issued_coupons
              FOREIGN KEY (coupon_type, customer_id)
                             REFERENCES issued_coupons) ;


create table osoft_purchase_steps
(client_cookie                  varchar2(100)
,client_session                 varchar2(100)
,hit_time                       date
,step_name_empty			varchar2(80) 
,step_name			varchar2(80) 
,client_ip                      varchar2(100)
,client_hostname_by_addr        varchar2(100)
,client_agent                   varchar2(255)
,url                            varchar2(500)
,referrer                       varchar2(2000)
,client_username                varchar2(100)
,client_host                    varchar2(100)
,customer_company       varchar2(80)
,customer_email         varchar2(256)
,customer_url           varchar2(1024)
,billto_firstname       varchar2(40)
,billto_lastname        varchar2(80)
,billto_address1        varchar2(80)
,billto_address2        varchar2(80)
,billto_city            varchar2(80)
,billto_state           varchar2(80)
,billto_zippostalcode   varchar2(12)
,billto_country         varchar2(80)
,billto_telephone       varchar2(80)
,shipto_address1        varchar2(80)
,shipto_address2        varchar2(80)
,shipto_city            varchar2(80)
,shipto_state           varchar2(80)
,shipto_zippostalcode   varchar2(12)
,shipto_country         varchar2(80)
,shipto_telephone       varchar2(80)
,shipment_id            varchar2(256) 
,customer_id            varchar2(256) 
,ship_method            varchar2(100) DEFAULT 'DOWNLOAD'
,ship_status            varchar2(30)
,ship_carrier           varchar2(100)
,ship_product_cost      number(9,2)
,ship_vat               number(9,2)
,ship_shipcost          number(9,2)
,coupon_type     	varchar2(80)
,month_1_sku_id		number
,month_1_sku_qty	number 
,month_1_sku_price	number(9,2) 
,month_3_sku_id		number 
,month_3_sku_qty	number 
,month_3_sku_price	number(9,2) 
,month_6_sku_id		number 
,month_6_sku_qty	number 
,month_6_sku_price	number(9,2) 
,month_9_sku_id		number 
,month_9_sku_qty	number 
,month_9_sku_price	number(9,2) 
,month_12_sku_id	number 
,month_12_sku_qty	number 
,month_12_sku_price	number(9,2) 
,vat_number             varchar2(80)
,vat_country            varchar2(2)
,po_number              varchar2(80)
,payment_type           varchar2(20)
,month_99_sku_id	number 
,month_99_sku_qty	number 
,month_99_sku_price	number(9,2) 
,processed_n_or_null    varchar2(1) default 'N'
)
tablespace osoft;

REMcreate or replace TRIGGER osoft_purchase_steps
REM      AFTER INSERT ON osoft_purchase_steps
REM      FOR EACH ROW
REMBEGIN
REM--
REM  INSERT INTO CUSTOMERS
REM  (customer_id
REM  ,customer_company       
REM  ,customer_email         
REM  ,customer_url           
REM  ,billto_firstname       
REM  ,billto_lastname        
REM  ,billto_address1        
REM  ,billto_address2        
REM  ,billto_city           
REM  ,billto_state           
REM  ,billto_zippostalcode   
REM  ,billto_country         
REM  ,billto_telephone       
REM  ,shipto_address1        
REM  ,shipto_address2        
REM  ,shipto_city            
REM  ,shipto_state           
REM  ,shipto_zippostalcode   
REM  ,shipto_country         
REM  ,shipto_telephone) 
REM  VALUES
REM  (:new.customer_id
REM  ,:new.customer_company       
REM  ,:new.customer_email         
REM  ,:new.customer_url           
REM  ,:new.billto_firstname       
REM  ,:new.billto_lastname        
REM  ,:new.billto_address1        
REM  ,:new.billto_address2        
REM  ,:new.billto_city           
REM  ,:new.billto_state           
REM  ,:new.billto_zippostalcode   
REM  ,:new.billto_country         
REM  ,:new.billto_telephone       
REM  ,:new.shipto_address1        
REM  ,:new.shipto_address2        
REM  ,:new.shipto_city            
REM  ,:new.shipto_state           
REM  ,:new.shipto_zippostalcode   
REM  ,:new.shipto_country         
REM  ,:new.shipto_telephone) ;
REM--
REM  INSERT INTO shipments
REM  (shipment_id            
REM  ,customer_id            
REM  ,ship_method            
REM  ,ship_createdate        
REM  ,ship_status            
REM  ,ship_carrier           
REM  ,shipto_address1        
REM  ,shipto_address2        
REM  ,shipto_city            
REM  ,shipto_state           
REM  ,shipto_zippostalcode   
REM  ,shipto_country         
REM  ,shipto_telephone       
REM  ,ship_product_cost      
REM  ,ship_vat               
REM  ,ship_shipcost)
REM  VALUES
REM  (:new.shipment_id            
REM  ,:new.customer_id            
REM  ,:new.ship_method            
REM  ,sysdate
REM  ,:new.ship_status            
REM  ,:new.ship_carrier           
REM  ,:new.shipto_address1        
REM  ,:new.shipto_address2        
REM  ,:new.shipto_city            
REM  ,:new.shipto_state           
REM  ,:new.shipto_zippostalcode   
REM  ,:new.shipto_country         
REM  ,:new.shipto_telephone       
REM  ,:new.ship_product_cost     
REM  ,:new.ship_vat               
REM  ,:new.ship_shipcost);
REM--
REM  INSERT INTO purchases
REM  (shipment_id   
REM  ,shipment_line  
REM  ,sku_id         
REM  ,sku_qty        
REM  ,sku_price      
REM  ,coupon_type    
REM  ,customer_id)
REM  VALUES
REM  (:new.shipment_id   
REM  , 1 
REM  ,:new.month_1_sku_id         
REM  ,:new.month_1_sku_qty        
REM  ,:new.month_1_sku_price      
REM  ,:new.coupon_type    
REM  ,:new.customer_id);
REMEND;
REM.
REM/

create table osoft_hosts
(CLIENT_IP	varchar2(40)
,CLIENT_HOSTNAME_BY_ADDR varchar2(80))
tablespace osoft;

alter table osoft_hosts add
(CLIENT_IP_ZPAD   varchar2(40)
,NETBLOCK  varchar2(80);

alter table osoft_hosts add
(create_date date);

ALTER TABLE osoft_hosts
       ADD  ( CONSTRAINT hst_pk
              PRIMARY KEY (client_ip) USING INDEX tablespace osoft);

create table osoft_netblock
(iprange varchar2(33) not null
,ipstart varchar2(15) not null
,ipend   varchar2(15) not null
,country varchar2(2)  null
,net_manager varchar2(30)
,net_descr   varchar2(240)
,create_date date default sysdate
,message_text varchar2(512))
tablespace osoft;

create table osoft_netblock_text
(iprange varchar2(33) not null
,lineno  number       not null
,fieldname  varchar2(10)
,fieldvalue varchar2(132))
tablespace osoft;

ALTER TABLE osoft_hosts
       ADD  ( CONSTRAINT hst_pk
              PRIMARY KEY (client_ip) USING INDEX tablespace osoft);

ALTER TABLE osoft_netblock
       ADD  ( CONSTRAINT nbk_pk
              PRIMARY KEY (iprange) USING INDEX tablespace osoft);

ALTER TABLE osoft_netblock_text
       ADD  ( CONSTRAINT nbt_pk
              PRIMARY KEY (iprange,lineno) USING INDEX tablespace osoft);

ALTER TABLE osoft_netblock
       ADD  ( CONSTRAINT nbk_uk1
              UNIQUE (ipstart, ipend ) USING INDEX tablespace osoft);

create index nbk_ix1 on osoft_netblock (country) tablespace osoft;

create index nbk_ix2 on osoft_netblock (ipstart, ipend desc) tablespace osoft;

ALTER TABLE osoft_hosts
       ADD  ( CONSTRAINT hst_fk_netblock
              FOREIGN KEY (netblock) references osoft_netblock);

ALTER TABLE osoft_netblock_text
       ADD  ( CONSTRAINT nbt_fk_netblock
              FOREIGN KEY (iprange) references osoft_netblock on delete cascade);

create index hst_ix1 on osoft_hosts (CLIENT_IP_ZPAD) tablespace osoft;

create or replace function ipzpad (p_ip varchar2) return varchar2
as 
--
  ip_1 number(3) := null;
  ip_2 number(3) := null;
  ip_3 number(3) := null;
  ip_4 number(3) := null;
--
  ip_dot number := 0;
--
  ipaddress varchar2(15) := p_ip;
--
begin
--
  if length(p_ip) = 15 then
--
   RETURN(p_ip) ;
--
  end if;
--
  ip_dot := instr(ipaddress,'.');
  ip_1 :=  to_number(substr(ipaddress, 0, ip_dot - 1));
  ipaddress := substr(ipaddress,ip_dot + 1);
--
  ip_dot := instr(ipaddress,'.');
  ip_2 :=  to_number(substr(ipaddress, 0, ip_dot - 1));
  ipaddress := substr(ipaddress,ip_dot + 1);
--
  ip_dot := instr(ipaddress,'.');
  ip_3 :=  to_number(substr(ipaddress, 0, ip_dot - 1));
  ipaddress := substr(ipaddress,ip_dot + 1);
--
  ip_4 :=  ipaddress;
--
--
  RETURN(lpad(ip_1,3,'0')||'.'||lpad(ip_2,3,'0')||'.'||lpad(ip_3,3,'0')||'.'||lpad(ip_4,3,'0'));
--
 exception
--
   when others then
--
   RETURN('ERROR: '||p_ip) ;
--
end;
.
/

show errors

create table worldpay_purchase
(client_cookie varchar2(100)
,client_session varchar2(100)
,hit_time date
,transid number
,transstatus varchar2(100)
,transtime_long number
,transtime_date date default sysdate
,authamount number
,authcurrency varchar2(100)
,authamountstring varchar2(100)
,rawauthmessage varchar2(100)
,rawauthcode varchar2(100)
,callbackpw varchar2(100)
,cardtype varchar2(100)
,countrytype varchar2(100)
,avs varchar2(100)
,cc_cust_name varchar2(100)
,cc_cust_address varchar2(100)
,cc_cust_zip varchar2(100)
,cc_cust_country varchar2(100)
,cc_cust_tel varchar2(100)
,cc_cust_fax varchar2(100)
,cc_cust_email varchar2(100))
tablespace osoft
/

alter table worldpay_purchase 
add (client_ip varchar2(15)
    ,customer_company varchar2(100)
    ,customer_url     varchar2(100)
    ,ship_method      varchar2(30)
    ,coupon_type      varchar2(30)
    ,ship_product_cost number
    ,ship_vat         number
    ,quantity         number
    ,sku              number);

create table osoft_actlog
(client_cookie varchar2(100)
,client_session varchar2(100)
,hit_time date
,request	 		varchar2(2048)
,message  varchar2(1000))
tablespace osoft
/

create table browser_install
(client_cookie 			varchar2(100)
,client_agent                   varchar2(255)
,create_date                    date
,message_text                   varchar2(512))
tablespace osoft;

ALTER TABLE browser_install
       ADD  ( CONSTRAINT bi_pk  PRIMARY KEY (client_cookie)
       USING INDEX
              TABLESPACE osoft) ;

alter table browser_install
add
(arrive_seqno 			number
,download_seqno                 number
,firstrun_seqno                 number
,firstlogin_seqno               number
,purchase1_seqno                number
);


create table browser_sessions
(client_session 		varchar2(100)
,client_cookie			varchar2(100)
,client_ip			varchar2(100)
,client_ip2			varchar2(100)
,client_hostname_by_addr 	varchar2(100)
,start_date                    date
,end_date                      date
,session_number                number default 1
,refer_source                  varchar2(40)
)
tablespace osoft;


ALTER TABLE browser_sessions
       ADD  ( CONSTRAINT bs_pk  PRIMARY KEY (client_session,client_cookie)
       USING INDEX
              TABLESPACE osoft) ;


alter table osoft_rawlog
add (search_engine_string varchar2(255) null);


