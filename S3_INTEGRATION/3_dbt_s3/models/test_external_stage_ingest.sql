{{
  config(
    materialized='from_external_stage',
    stage_url = 's3://snowflake-s3-data',
    format_name = 'snowflake_s3_data_format'
  )
}}

select 
$1 id, 
$2 order_id, 
$3 payment_method, 
$4 amount
from {{ external_stage() }}