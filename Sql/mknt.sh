#!/bin/sh

cd
HOMEDIR=`pwd`
cd OrindaSoft
cd DB
cd Sql
echo  '1,$s_/export/data/leapfrog/oradata/_C:\\\\oracle\\\\ora90\\\\oradata\\\\DB920A21\\\\_g' > nt.sed
echo  '1,$s_/export/data/oradata/&1/_C:\\\\oracle\\\\ora90\\\\oradata\\\\DB920A21\\\\_g' >> nt.sed
echo  '1,$s_/export/data/testdata/&1/_C:\\\\oracle\\\\ora90\\\\oradata\\\\testdata\\\\_g' >> nt.sed

sed -f nt.sed < dbhell.sql > dbhell_nt.sql
sed -f nt.sed < synuser.sql > synuser_nt.sql
sed -f nt.sed < bigtables.sql > bigtables_nt.sql
sed -f nt.sed < orindademo.sql > orindademo_nt.sql

cd
cd OrindaSoft/Lib/OtherDbs/javaSched

sed -f ${HOMEDIR}/OrindaSoft/DB/Sql/nt.sed < js.sql > js_nt.sql

cd
cd OrindaSoft/Lib/OtherDbs/nterdesk

sed -f ${HOMEDIR}/OrindaSoft/DB/Sql/nt.sed < eiadb1.sql > eiadb1_nt.sql
sed -f ${HOMEDIR}/OrindaSoft/DB/Sql/nt.sed < eiadb2.sql > eiadb2_nt.sql


