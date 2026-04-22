
set echo on
set feedback on
set showmode on

connect system/manager@&1


grant connect, resource to proxy_user identified by proxy_user;

alter user proxy_user quota unlimited on users;

alter user orindademo grant connect through proxy_user;

alter user orindademo account unlock;

alter user orindademo identified by orindademo;

connect proxy_user/proxy_user@&1

exit
