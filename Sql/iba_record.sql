DROP TABLE iba_rowtype_batch_header;
CREATE TABLE iba_rowtype_batch_header (
  batch_id VARCHAR2(40),
  batch_no INTEGER,
  plant_code VARCHAR2(40),
  batch_type INTEGER,
  actual_start_date DATE,
  actual_cmplt_date DATE,
  plan_start_date DATE,
  plan_cmplt_date DATE,
  due_date DATE,
  recipe_validity_rule_id VARCHAR2(40),
  wip_whse_code VARCHAR2(40)
);

DROP TABLE iba_rowtype_table;

CREATE TABLE iba_rowtype_table (
  batch_id VARCHAR2(40),
  batch_no VARCHAR2(40),
  material_detail_id VARCHAR2(40),
  line_type VARCHAR2(40),
  line_no INTEGER,
  item_id VARCHAR2(40),
  item_no INTEGER,
  alloc_qty VARCHAR2(40),
  unalloc_qty VARCHAR2(40),
  alloc_uom VARCHAR2(40)
);

INSERT INTO iba_rowtype_table VALUES('abc', 'abc', 'abc', 'abc', 123, 'abc', 123, 'abc', 'abc', 'abc');
INSERT INTO iba_rowtype_table VALUES('abc', 'abc', 'abc', 'abc', 123, 'abc', 123, 'abc', 'abc', 'abc');
INSERT INTO iba_rowtype_table VALUES('abc', 'abc', 'abc', 'abc', 123, 'abc', 123, 'abc', 'abc', 'abc');
INSERT INTO iba_rowtype_table VALUES('abc', 'abc', 'abc', 'abc', 123, 'abc', 123, 'abc', 'abc', 'abc');

CREATE OR REPLACE
PACKAGE iba_rowtype_api_pub /* */ AS
  api_version CONSTANT NUMBER := 1;
  max_errors CONSTANT NUMBER := 100;

/* misleading comment TYPE unallocated_materials_tab IS TABLE OF fruitbat%rowtype */

  TYPE unallocated_materials_tab IS TABLE OF iba_rowtype_table%rowtype
    INDEX BY binary_integer;



type ast_array is TABLE OF lsvielm_ast_inst%rowtype
    INDEX BY binary_integer;

TYPE ast_table  IS TABLE OF lsvielm_ast_inst%ROWTYPE;

TYPE ast_VARRAY  IS VARRAY(100) OF lsvielm_ast_inst%ROWTYPE;

PROCEDURE do_test(
  p_api_version IN NUMBER := iba_rowtype_api_pub.api_version,
  p_validation_level IN NUMBER := iba_rowtype_api_pub.max_errors,
  p_init_msg_list IN BOOLEAN := FALSE,
  p_commit IN BOOLEAN := FALSE,
  x_message_count OUT NOCOPY NUMBER,
  x_message_list OUT NOCOPY VARCHAR2,
  x_return_status OUT NOCOPY VARCHAR2,
  p_batch_header IN iba_rowtype_batch_header%rowtype,
  x_batch_header OUT NOCOPY iba_rowtype_batch_header%rowtype,
  p_ignore_shortages IN BOOLEAN,
  p_consume_avail_plain_item IN BOOLEAN DEFAULT FALSE,
  x_unallocated_material IN   iba_rowtype_api_pub.unallocated_materials_tab,
  y_unallocated_material IN OUT iba_rowtype_api_pub.unallocated_materials_tab,
  z_unallocated_material OUT iba_rowtype_api_pub.unallocated_materials_tab,
  p_ignore_unalloc IN BOOLEAN DEFAULT FALSE
);

PROCEDURE do_test2(
  p_api_version IN NUMBER := iba_rowtype_api_pub.api_version,
  p_validation_level IN NUMBER := iba_rowtype_api_pub.max_errors,
  p_init_msg_list IN BOOLEAN := FALSE,
  p_commit IN BOOLEAN := FALSE,
  x_message_count OUT NOCOPY NUMBER,
  x_message_list OUT NOCOPY VARCHAR2,
  x_return_status OUT NOCOPY VARCHAR2,
  p_batch_header IN iba_rowtype_batch_header%rowtype,
  x_batch_header OUT NOCOPY iba_rowtype_batch_header%rowtype,
  p_ignore_shortages IN BOOLEAN,
  p_consume_avail_plain_item IN BOOLEAN DEFAULT FALSE,
  x_unallocated_material IN   iba_rowtype_api_pub.unallocated_materials_tab,
  y_unallocated_material IN OUT iba_rowtype_api_pub.unallocated_materials_tab,
  z_unallocated_material OUT iba_rowtype_api_pub.unallocated_materials_tab,
  x_rowtype in     ast_array,
  y_rowtype in out     ast_array,
  z_rowtype    out  ast_array,
  x_table in     ast_table,
  y_table in out     ast_table,
  z_table    out  ast_table,
  x_varray in     ast_varraY,
  y_varray in out     ast_vARRAY,
  z_varray    out  ast_varray,
  p_ignore_unalloc IN out BOOLEAN 
);

PROCEDURE do_test3(
  p_api_version IN NUMBER := iba_rowtype_api_pub.api_version,
  z_varray    out  ast_array,
  p_validation_level IN NUMBER := iba_rowtype_api_pub.max_errors,
  p_init_msg_list IN BOOLEAN := FALSE,
  y_table in out     ast_table,
  x_message_count OUT NOCOPY NUMBER,
  x_varray in     ast_vARRAY,
  x_message_list OUT NOCOPY VARCHAR2,
  x_return_status OUT NOCOPY VARCHAR2,
  p_batch_header IN iba_rowtype_batch_header%rowtype,
  x_batch_header OUT NOCOPY iba_rowtype_batch_header%rowtype,
  p_ignore_shortages IN BOOLEAN,
  p_consume_avail_plain_item IN BOOLEAN DEFAULT FALSE,
  y_unallocated_material IN OUT iba_rowtype_api_pub.unallocated_materials_tab,
  z_unallocated_material OUT iba_rowtype_api_pub.unallocated_materials_tab,
  x_rowtype in     ast_array,
  y_rowtype in out     ast_array,
  z_rowtype    out  ast_array,
  x_table in     ast_table,
  z_table    out  ast_table,
  y_varray in out     ast_vARRAY,
  p_commit IN BOOLEAN := FALSE,
  p_ignore_unalloc IN out BOOLEAN,
  x_unallocated_material IN   iba_rowtype_api_pub.unallocated_materials_tab
);

END iba_rowtype_api_pub;
/

show errors

l


CREATE OR REPLACE
PACKAGE BODY iba_rowtype_api_pub AS


PROCEDURE do_test(
  p_api_version IN NUMBER := iba_rowtype_api_pub.api_version,
  p_validation_level IN NUMBER := iba_rowtype_api_pub.max_errors,
  p_init_msg_list IN BOOLEAN := FALSE,
  p_commit IN BOOLEAN := FALSE,
  x_message_count OUT NOCOPY NUMBER,
  x_message_list OUT NOCOPY VARCHAR2,
  x_return_status OUT NOCOPY VARCHAR2,
  p_batch_header IN iba_rowtype_batch_header%rowtype,
  x_batch_header OUT NOCOPY iba_rowtype_batch_header%rowtype,
  p_ignore_shortages IN BOOLEAN,
  p_consume_avail_plain_item IN BOOLEAN DEFAULT FALSE,
  x_unallocated_material IN   iba_rowtype_api_pub.unallocated_materials_tab,
  y_unallocated_material IN OUT iba_rowtype_api_pub.unallocated_materials_tab,
  z_unallocated_material OUT iba_rowtype_api_pub.unallocated_materials_tab,
  p_ignore_unalloc IN BOOLEAN DEFAULT FALSE
) AS
BEGIN
  x_batch_header.batch_id := p_batch_header.batch_id;
  x_batch_header.batch_no := p_batch_header.batch_no;
  x_batch_header.plant_code := p_batch_header.plant_code;
  x_batch_header.batch_type := p_batch_header.batch_type;
  x_batch_header.actual_start_date := p_batch_header.actual_start_date;
  x_batch_header.actual_cmplt_date := p_batch_header.actual_cmplt_date;
  x_batch_header.plan_start_date := p_batch_header.plan_start_date;
  x_batch_header.plan_cmplt_date := p_batch_header.plan_cmplt_date;
  x_batch_header.due_date := p_batch_header.due_date;
  x_batch_header.recipe_validity_rule_id := p_batch_header.recipe_validity_rule_id;
  x_batch_header.wip_whse_code := p_batch_header.wip_whse_code;

  x_return_status := 'S';

  select * bulk collect into y_unallocated_material from iba_rowtype_table where rownum < 3;

  select * bulk collect into z_unallocated_material from iba_rowtype_table;

END do_test;


PROCEDURE do_test2(
  p_api_version IN NUMBER := iba_rowtype_api_pub.api_version,
  p_validation_level IN NUMBER := iba_rowtype_api_pub.max_errors,
  p_init_msg_list IN BOOLEAN := FALSE,
  p_commit IN BOOLEAN := FALSE,
  x_message_count OUT NOCOPY NUMBER,
  x_message_list OUT NOCOPY VARCHAR2,
  x_return_status OUT NOCOPY VARCHAR2,
  p_batch_header IN iba_rowtype_batch_header%rowtype,
  x_batch_header OUT NOCOPY iba_rowtype_batch_header%rowtype,
  p_ignore_shortages IN BOOLEAN,
  p_consume_avail_plain_item IN BOOLEAN DEFAULT FALSE,
  x_unallocated_material IN   iba_rowtype_api_pub.unallocated_materials_tab,
  y_unallocated_material IN OUT iba_rowtype_api_pub.unallocated_materials_tab,
  z_unallocated_material OUT iba_rowtype_api_pub.unallocated_materials_tab,
  x_rowtype in     ast_array,
  y_rowtype in out     ast_array,
  z_rowtype    out  ast_array,
  x_table in     ast_table,
  y_table in out     ast_table,
  z_table    out  ast_table,
  x_varray in     ast_vARRAY,
  y_varray in out     ast_vARRAY,
  z_varray    out  ast_vARRAY,
  p_ignore_unalloc IN out BOOLEAN 
) AS
BEGIN

  select * bulk collect into z_rowtype from lsvielm_ast_inst where rownum <= 10; 
  select * bulk collect into z_table  from lsvielm_ast_inst where rownum <= 50;
  select * bulk collect into z_varray  from lsvielm_ast_inst where rownum <= 100;

  x_batch_header.batch_id := p_batch_header.batch_id;
  x_batch_header.batch_no := p_batch_header.batch_no;
  x_batch_header.plant_code := p_batch_header.plant_code;
  x_batch_header.batch_type := p_batch_header.batch_type;
  x_batch_header.actual_start_date := p_batch_header.actual_start_date;
  x_batch_header.actual_cmplt_date := p_batch_header.actual_cmplt_date;
  x_batch_header.plan_start_date := p_batch_header.plan_start_date;
  x_batch_header.plan_cmplt_date := p_batch_header.plan_cmplt_date;
  x_batch_header.due_date := p_batch_header.due_date;
  x_batch_header.recipe_validity_rule_id := p_batch_header.recipe_validity_rule_id;
  x_batch_header.wip_whse_code := p_batch_header.wip_whse_code;

  x_return_status := 'S';

  select * bulk collect into y_unallocated_material from iba_rowtype_table where rownum < 3;

  select * bulk collect into z_unallocated_material from iba_rowtype_table;

END do_test2;

PROCEDURE do_test3(
 p_api_version IN NUMBER := iba_rowtype_api_pub.api_version,
  z_varray    out  ast_array,
  p_validation_level IN NUMBER := iba_rowtype_api_pub.max_errors,
  p_init_msg_list IN BOOLEAN := FALSE,
  y_table in out     ast_table,
  x_message_count OUT NOCOPY NUMBER,
  x_varray in     ast_vARRAY,
  x_message_list OUT NOCOPY VARCHAR2,
  x_return_status OUT NOCOPY VARCHAR2,
  p_batch_header IN iba_rowtype_batch_header%rowtype,
  x_batch_header OUT NOCOPY iba_rowtype_batch_header%rowtype,
  p_ignore_shortages IN BOOLEAN,
  p_consume_avail_plain_item IN BOOLEAN DEFAULT FALSE,
  y_unallocated_material IN OUT iba_rowtype_api_pub.unallocated_materials_tab,
  z_unallocated_material OUT iba_rowtype_api_pub.unallocated_materials_tab,
  x_rowtype in     ast_array,
  y_rowtype in out     ast_array,
  z_rowtype    out  ast_array,
  x_table in     ast_table,
  z_table    out  ast_table,
  y_varray in out     ast_vARRAY,
  p_commit IN BOOLEAN := FALSE,
  p_ignore_unalloc IN out BOOLEAN,
  x_unallocated_material IN   iba_rowtype_api_pub.unallocated_materials_tab) AS
BEGIN

  select * bulk collect into z_rowtype from lsvielm_ast_inst where rownum <= 10;
  select * bulk collect into z_table  from lsvielm_ast_inst where rownum <= 50;
  select * bulk collect into z_varray  from lsvielm_ast_inst where rownum <= 100;

  x_batch_header.batch_id := p_batch_header.batch_id;
  x_batch_header.batch_no := p_batch_header.batch_no;
  x_batch_header.plant_code := p_batch_header.plant_code;
  x_batch_header.batch_type := p_batch_header.batch_type;
  x_batch_header.actual_start_date := p_batch_header.actual_start_date;
  x_batch_header.actual_cmplt_date := p_batch_header.actual_cmplt_date;
  x_batch_header.plan_start_date := p_batch_header.plan_start_date;
  x_batch_header.plan_cmplt_date := p_batch_header.plan_cmplt_date;
  x_batch_header.due_date := p_batch_header.due_date;
  x_batch_header.recipe_validity_rule_id := p_batch_header.recipe_validity_rule_id;
  x_batch_header.wip_whse_code := p_batch_header.wip_whse_code;

  x_return_status := 'S';

  select * bulk collect into y_unallocated_material from iba_rowtype_table where rownum < 3;

  select * bulk collect into z_unallocated_material from iba_rowtype_table;

END ;
END ;
/

show errors

exit

