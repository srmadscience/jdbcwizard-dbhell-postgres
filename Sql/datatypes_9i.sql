
create or replace package dbhell.datatype_test_9i as
--
function  timestamp_func(in_param timestamp) return timestamp;
--
procedure timestamp_proc(in_param in timestamp
                     ,out_param out timestamp
                     ,in_out_param in out timestamp);
--
function  timestamp_with_time_zone_func(in_param timestamp with time zone) return timestamp 
with time zone;
--
procedure timestamp_with_time_zone_proc(in_param in timestamp with time zone
                     ,out_param out timestamp with time zone
                     ,in_out_param in out timestamp with time zone);
--
function  timestamp_with_ltz_func(in_param timestamp with local time zone) return timestamp
with local time zone;
--
procedure timestamp_with_ltz_proc(in_param in timestamp with local time zone
                     ,out_param out timestamp with local time zone
                     ,in_out_param in out timestamp with local time zone);
--
end;
.
/

show errors;

create or replace package body dbhell.datatype_test_9i
as
function  timestamp_func(in_param timestamp) return timestamp is
--
foo timestamp := null;
--
BEGIN
--
  foo := TO_TIMESTAMP ('1999-12-01 11:00:00', 'YYYY-MM-DD HH:MI:SS');
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(foo));
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(in_param));
--
--
commit;
  IF in_param IS NOT NULL THEN
--
    return(greatest(foo,in_param));
--
  ELSE
--
    return(in_param);
--
  END IF;
--
END;
--
procedure timestamp_proc(in_param in timestamp
                     ,out_param out timestamp
                     ,in_out_param in out timestamp) is
--
foo timestamp := null;
--
BEGIN
--
  foo := TO_TIMESTAMP ('1967-12-12 11:00:00', 'YYYY-MM-DD HH:MI:SS');
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(foo));
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(in_param));
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(greatest(foo, in_param)));
--
-- least doesnt work!
--
  out_param := greatest(foo, in_param);
--
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(out_param));
--
  commit;
--
    out_param := in_param;
  in_out_param := in_param;
--
END;
--
function  timestamp_with_time_zone_func(in_param timestamp with time zone) return timestamp with time zone is
--
foo timestamp with time zone := null;
--
BEGIN
--
  foo := TO_TIMESTAMP_TZ ('1999-12-01 11:00:00 -08:00', 'YYYY-MM-DD HH:MI:SS TZH:TZM');
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(foo));
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(in_param));
--
--
commit;
  IF in_param IS NOT NULL THEN
--
    return(greatest(foo,in_param));
--
  ELSE
--
    return(in_param);
--
  END IF;
--
END;
--
procedure timestamp_with_time_zone_proc(in_param in timestamp with time zone
                     ,out_param out timestamp with time zone
                     ,in_out_param in out timestamp with time zone) is
--
foo timestamp with time zone := null;
--
BEGIN
--
  foo := TO_TIMESTAMP ('1967-12-12 11:00:00', 'YYYY-MM-DD HH:MI:SS');
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(foo));
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(in_param));
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(greatest(foo, in_param)));
--
-- least doesnt work!
--
  out_param := greatest(foo, in_param);
--
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(out_param));
--
  commit;
--
    out_param := in_param;
  in_out_param := in_param;
--
END;
--
function  timestamp_with_ltz_func(in_param timestamp with local time zone) return timestamp with local time zone is
--
foo timestamp with local time zone := null;
--
BEGIN
--
  foo := TO_TIMESTAMP ('1999-12-01 11:00:00', 'YYYY-MM-DD HH:MI:SS');
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(foo));
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(in_param));
--
--
commit;
  IF in_param IS NOT NULL THEN
--
    return(greatest(foo,in_param));
--
  ELSE
--
    return(in_param);
--
  END IF;
--
END;
--
procedure timestamp_with_ltz_proc(in_param in timestamp with local time zone
                     ,out_param out timestamp with local time zone
                     ,in_out_param in out timestamp with local time zone) is
--
foo timestamp with local time zone := null;
--
BEGIN
--
  foo := TO_TIMESTAMP ('1967-12-12 11:00:00', 'YYYY-MM-DD HH:MI:SS');
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(foo));
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(in_param));
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(greatest(foo, in_param)));
--
-- least doesnt work!
--
  out_param := greatest(foo, in_param);
--
--
  INSERT into message_table
   values
  (message_seq.nextval, to_char(out_param));
--
  commit;
--
    out_param := in_param;
  in_out_param := in_param;
--
END;
--
END;
.
/

show errors


