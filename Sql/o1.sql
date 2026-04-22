DROP TABLE gme_batch_header;
CREATE TABLE gme_batch_header (
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

DROP TABLE gme_unallocated_items_gtmp;
CREATE TABLE gme_unallocated_items_gtmp (
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

INSERT INTO gme_unallocated_items_gtmp VALUES('abc', 'abc', 'abc', 'abc', 123, 'abc', 123, 'abc', 'abc', 'abc');
INSERT INTO gme_unallocated_items_gtmp VALUES('abc', 'abc', 'abc', 'abc', 123, 'abc', 123, 'abc', 'abc', 'abc');
INSERT INTO gme_unallocated_items_gtmp VALUES('abc', 'abc', 'abc', 'abc', 123, 'abc', 123, 'abc', 'abc', 'abc');
INSERT INTO gme_unallocated_items_gtmp VALUES('abc', 'abc', 'abc', 'abc', 123, 'abc', 123, 'abc', 'abc', 'abc');

CREATE OR REPLACE
PACKAGE gme_api_pub AS
  api_version CONSTANT NUMBER := 1;
  max_errors CONSTANT NUMBER := 100;

  TYPE unallocated_materials_tab IS TABLE OF gme_unallocated_items_gtmp%rowtype
    INDEX BY binary_integer;

PROCEDURE create_batch(
  p_api_version IN NUMBER := gme_api_pub.api_version,
  p_validation_level IN NUMBER := gme_api_pub.max_errors,
  p_init_msg_list IN BOOLEAN := FALSE,
  p_commit IN BOOLEAN := FALSE,
  x_message_count OUT NOCOPY NUMBER,
  x_message_list OUT NOCOPY VARCHAR2,
  x_return_status OUT NOCOPY VARCHAR2,
  p_batch_header IN gme_batch_header%rowtype,
  x_batch_header OUT NOCOPY gme_batch_header%rowtype,
  p_batch_size IN NUMBER,
  p_batch_size_uom IN VARCHAR2,
  p_creation_mode IN VARCHAR2,
  p_recipe_id IN NUMBER := NULL,
  p_recipe_no IN VARCHAR2 := NULL,
  p_recipe_version IN NUMBER := NULL,
  p_product_no IN VARCHAR2 := NULL,
  p_product_id IN NUMBER := NULL,
  p_ignore_qty_below_cap IN BOOLEAN := TRUE,
  p_ignore_shortages IN BOOLEAN,
  p_use_shop_cal IN NUMBER := NULL,
  p_contiguity_override IN NUMBER := 1,
  x_unallocated_material OUT NOCOPY gme_api_pub.unallocated_materials_tab
);

PROCEDURE release_batch(
  p_api_version IN NUMBER := gme_api_pub.api_version,
  p_validation_level IN NUMBER := gme_api_pub.max_errors,
  p_init_msg_list IN BOOLEAN := FALSE,
  p_commit IN BOOLEAN := FALSE,
  x_message_count OUT NOCOPY NUMBER,
  x_message_list OUT NOCOPY VARCHAR2,
  x_return_status OUT NOCOPY VARCHAR2,
  p_batch_header IN gme_batch_header%rowtype,
  x_batch_header OUT NOCOPY gme_batch_header%rowtype,
  p_ignore_shortages IN BOOLEAN,
  p_consume_avail_plain_item IN BOOLEAN DEFAULT FALSE,
  x_unallocated_material OUT NOCOPY gme_api_pub.unallocated_materials_tab,
  p_ignore_unalloc IN BOOLEAN DEFAULT FALSE
);

PROCEDURE certify_batch(
  p_api_version IN NUMBER := gme_api_pub.api_version,
  p_validation_level IN NUMBER := gme_api_pub.max_errors,
  p_init_msg_list IN BOOLEAN := FALSE,
  p_commit IN BOOLEAN := FALSE,
  x_message_count OUT NOCOPY NUMBER,
  x_message_list OUT NOCOPY VARCHAR2,
  x_return_status OUT NOCOPY VARCHAR2,
  p_del_incomplete_manual IN BOOLEAN := FALSE,
  p_ignore_shortages IN BOOLEAN := FALSE,
  p_batch_header IN gme_batch_header%rowtype,
  x_batch_header OUT NOCOPY gme_batch_header%rowtype,
  x_unallocated_material OUT NOCOPY gme_api_pub.unallocated_materials_tab
);

END gme_api_pub;
/

CREATE OR REPLACE
PACKAGE BODY GME_API_PUB AS

PROCEDURE create_batch(
  p_api_version IN NUMBER := gme_api_pub.api_version,
  p_validation_level IN NUMBER := gme_api_pub.max_errors,
  p_init_msg_list IN boolean := FALSE,
  p_commit IN boolean := FALSE,
  x_message_count OUT NOCOPY NUMBER,
  x_message_list OUT NOCOPY VARCHAR2,
  x_return_status OUT NOCOPY VARCHAR2,
  p_batch_header IN gme_batch_header%rowtype,
  x_batch_header OUT NOCOPY gme_batch_header%rowtype,
  p_batch_size IN NUMBER,
  p_batch_size_uom IN VARCHAR2,
  p_creation_mode IN VARCHAR2,
  p_recipe_id IN NUMBER := NULL,
  p_recipe_no IN VARCHAR2 := NULL,
  p_recipe_version IN NUMBER := NULL,
  p_product_no IN VARCHAR2 := NULL,
  p_product_id IN NUMBER := NULL,
  p_ignore_qty_below_cap IN boolean := TRUE,
  p_ignore_shortages IN boolean,
  p_use_shop_cal IN NUMBER := NULL, -- Pawan kumar bug 823188
  p_contiguity_override IN NUMBER := 1,
  x_unallocated_material OUT NOCOPY gme_api_pub.unallocated_materials_tab
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

  select * bulk collect into x_unallocated_material from gme_unallocated_items_gtmp;
END create_batch;

PROCEDURE release_batch(
  p_api_version IN NUMBER := gme_api_pub.api_version,
  p_validation_level IN NUMBER := gme_api_pub.max_errors,
  p_init_msg_list IN BOOLEAN := FALSE,
  p_commit IN BOOLEAN := FALSE,
  x_message_count OUT NOCOPY NUMBER,
  x_message_list OUT NOCOPY VARCHAR2,
  x_return_status OUT NOCOPY VARCHAR2,
  p_batch_header IN gme_batch_header%rowtype,
  x_batch_header OUT NOCOPY gme_batch_header%rowtype,
  p_ignore_shortages IN BOOLEAN,
  p_consume_avail_plain_item IN BOOLEAN DEFAULT FALSE,
  x_unallocated_material OUT NOCOPY gme_api_pub.unallocated_materials_tab,
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

  select * bulk collect into x_unallocated_material from gme_unallocated_items_gtmp;
END release_batch;

PROCEDURE certify_batch(
  p_api_version IN NUMBER := gme_api_pub.api_version,
  p_validation_level IN NUMBER := gme_api_pub.max_errors,
  p_init_msg_list IN BOOLEAN := FALSE,
  p_commit IN BOOLEAN := FALSE,
  x_message_count OUT NOCOPY NUMBER,
  x_message_list OUT NOCOPY VARCHAR2,
  x_return_status OUT NOCOPY VARCHAR2,
  p_del_incomplete_manual IN BOOLEAN := FALSE,
  p_ignore_shortages IN BOOLEAN := FALSE,
  p_batch_header IN gme_batch_header%rowtype,
  x_batch_header OUT NOCOPY gme_batch_header%rowtype,
  x_unallocated_material OUT NOCOPY gme_api_pub.unallocated_materials_tab
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

  select * bulk collect into x_unallocated_material from gme_unallocated_items_gtmp;
END certify_batch;

END GME_API_PUB;
/

