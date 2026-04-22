
CREATE OR REPLACE PROCEDURE timestamp_interval
(p_in            all_normal_datatypes_9i%ROWTYPE
,p_in_out in out all_normal_datatypes_9i%ROWTYPE
,p_out       out all_normal_datatypes_9i%ROWTYPE
)
--
AS
--
BEGIN
--
  p_out := p_in;
  p_in_out.name := 'tweaked';
--
END;
.
/

show errors

CREATE OR REPLACE PROCEDURE timestamp_subtypes
(p_t_un TIMESTAMP_UNCONSTRAINED
,p_tz_un    TIMESTAMP_TZ_UNCONSTRAINED
,p_ltz_un    TIMESTAMP_LTZ_UNCONSTRAINED
,p_ym_un    YMINTERVAL_UNCONSTRAINED
,p_ds_un    DSINTERVAL_UNCONSTRAINED
)
--
AS
--
BEGIN
--
  NULL;
--
END;
.
/

show errors

exit

