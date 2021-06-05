create database if not exists test;
 
 use database test;
 
create or replace stage my_ext_stage
  url='<bucket name created with s3.tf>'
  storage_integration = '<storege_integration_name>';
  
 select $1
 from @my_ext_stage;