

drop tablespace ssir_inds including contents;
create tablespace ssir_inds datafile '/export/data/oradata/&1/ssir_inds.dbf' size 100M reuse;

drop tablespace ssir_tabs including contents;
create tablespace ssir_tabs datafile '/export/data/oradata/&1/ssir_tabs.dbf' size 100M reuse;

