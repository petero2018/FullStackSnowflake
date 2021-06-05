use role accountadmin;

create or replace storage integration <storege_integration_name>
  type = external_stage
  storage_provider = s3
  enabled = true
  storage_aws_role_arn = '<IAM ARN created with iam.tf>'
  storage_allowed_locations = ('<bucket name created with s3.tf>')
  ;
  
 DESC INTEGRATION <storege_integration_name>;

 