

CREATE TYPE typ_person AS OBJECT (
  name        VARCHAR2(30),
  phone       VARCHAR2(20) ) not final;
.
/
  
CREATE TABLE typ_person_table OF typ_person;

CREATE TYPE typ_person2 AS OBJECT (
  name    VARCHAR2(30),
  manager REF typ_person );
.
/

CREATE TABLE typ_person_table2 OF typ_person2;

CREATE TYPE typ_location as object (
  building_no NUMBER,
  city        VARCHAR2(40) );
.
/

CREATE TYPE typ_person3 as object (
  ssno        NUMBER,
  name        VARCHAR2(100),
  address     VARCHAR2(100),
  office      typ_location );
.
/

CREATE TABLE typ_person_extent OF typ_person3 (
  ssno        PRIMARY KEY );
.
/

CREATE TABLE typ_department (
  deptno      CHAR(5) PRIMARY KEY, 
  dept_name   CHAR(20),
  dept_mgr    typ_person3,
  dept_loc    typ_location,
  CONSTRAINT  dept_loc_cons1
      UNIQUE (dept_loc.building_no, dept_loc.city),
  CONSTRAINT  dept_loc_cons2
       CHECK (dept_loc.city IS NOT NULL) );
.
/


CREATE TYPE typ_prices AS VARRAY(10) OF NUMBER(12,2); 
.
/


CREATE TYPE typ_person4 as object (
  ssno        NUMBER,
  name        VARCHAR2(100),
  address     VARCHAR2(100),
  office      typ_prices);
.
/

CREATE TYPE typ_number_table AS TABLE OF number; 
.
/

CREATE TYPE typ_person5 as object (
  ssno        NUMBER,
  name        VARCHAR2(100),
  address     VARCHAR2(100),
  office      typ_number_table);
.
/


CREATE TYPE typ_Employee UNDER typ_Person
( empid NUMBER, 
  mgr VARCHAR2(30));
.
/

CREATE TABLE typ_person_table_inherit OF typ_employee;
.
/


