select /* PARAM_PRODUCT_NAME */ o2.owner "Owner", o2.object_name "Name", 'X' "Selected" 
 , decode(o2.owner,user,'User Object' ,'Other User''s Object') "Accessed Via" 
 , o2.owner "Real Owner", o2.object_name "Real Name" 
 , 'X' "Oracle Name", 'X' "Java Name", 'X' "Fixed Java Name", null "Package",null "Real Package" 
from all_objects o2 
where (o2.owner = 'DBHELL' or  o2.owner LIKE 'DBHELL') 
and not exists (select null from all_arguments o3 where o2.owner = o3.owner 
                and o2.object_name = o3.object_name and o3.package_name is null) 
and o2.object_type = 'PROCEDURE' 
group by o2.owner, o2.object_name 
order by 1,10,4,2 
/

select as2.owner "Function Owner",  as2.synonym_name "Function Name", 'X' "Selected" 
     , decode(as2.owner,'PUBLIC','Public Synonym','Private Synonym') "Accessed Via" 
 , o6.owner "Real Owner", o6.object_name "Real Name" 
 , 'X' "Oracle Name", 'X' "Java Name", 'X' "Fixed Java Name", null "Package", null "Real Package" 
from all_synonyms as2 
   , all_objects o6 
where (as2.owner = 'DBHELL' or  as2.table_owner LIKE 'DBHELL') 
and as2.table_owner = o6.owner 
and as2.table_name = o6.object_name 
and o6.object_type = 'PROCEDURE' 
and not exists (select null from all_arguments o33 where o6.owner = o33.owner 
                and o6.object_name = o33.object_name and o33.package_name is null) 
group by as2.owner, as2.synonym_name, o6.owner, o6.object_name 
order by 1,10,4,2 
/

select /* PARAM_PRODUCT_NAME */ o2.owner "Owner", o2.object_name "Name", 'X' "Selected" 
 , decode(o2.owner,user,'User Object' ,'Other User''s Object') "Accessed Via" 
 , o2.owner "Real Owner", o2.object_name "Real Name" 
 , 'X' "Oracle Name", 'X' "Java Name", 'X' "Fixed Java Name",o2.package_name "Package",o2.package_name "Real Package" 
from all_arguments o2 
where (o2.owner = 'DBHELL' or  o2.owner LIKE 'DBHELL') 
group by o2.owner, o2.object_name, o2.package_name 
order by 1,10,4,2 
/

select asyn.owner "Function Owner",  asyn.synonym_name "Function Name", 'X' "Selected" 
     , decode(asyn.owner,'PUBLIC','Public Synonym','Private Synonym') "Accessed Via" 
 , aseqs.owner "Real Owner", aseqs.object_name "Real Name" 
 , 'X' "Oracle Name", 'X' "Java Name", 'X' "Fixed Java Name", aseqs.package_name "Package", aseqs.package_name "Real Package" 
from all_synonyms asyn 
   , all_arguments aseqs 
   , all_objects obwk
where (asyn.owner = 'DBHELL' or  asyn.table_owner LIKE 'DBHELL') 
and asyn.table_owner = obwk.owner 
and asyn.table_name = obwk.object_name 
and obwk.object_type = 'PROCEDURE'
and asyn.table_owner = aseqs.owner (+)
and asyn.table_name = aseqs.object_name (+)
and  decode(aseqs.package_name,null,'YES','NO') = 'YES'
and 2 > aseqs.position (+)
group by asyn.owner ,  asyn.synonym_name , 'X' 
     , decode(asyn.owner,'PUBLIC','Public Synonym','Private Synonym') 
 , aseqs.owner , aseqs.object_name 
 , aseqs.package_name 
order by 1,10,4,2 
/

select /*+ ORDERED */ asyn2.owner "Function Owner",  aseqs2.object_name "Function Name", 'X' "Selected" 
     , decode(asyn2.owner,'PUBLIC','Public Synonym','Private Synonym') "Accessed Via" 
 , aseqs2.owner "Real Owner", aseqs2.object_name "Real Name" 
 , 'X' "Oracle Name", 'X' "Java Name", 'X' "Fixed Java Name", asyn2.synonym_name "Package", aseqs2.package_name "Real Package" 
from all_synonyms asyn2 
   , all_arguments aseqs2 
where (asyn2.owner = 'DBHELL' or  asyn2.table_owner LIKE 'DBHELL' ) 
and asyn2.table_owner = aseqs2.owner 
and asyn2.table_name = aseqs2.package_name 
group by asyn2.owner ,  asyn2.synonym_name , 'X' 
     , decode(asyn2.owner,'PUBLIC','Public Synonym','Private Synonym') 
 , aseqs2.owner , aseqs2.object_name 
 , aseqs2.package_name 
order by 1,10,4,2 
/

