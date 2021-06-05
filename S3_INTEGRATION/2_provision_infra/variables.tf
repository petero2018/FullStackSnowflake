# //////////////////////////////
# VARIABLES
# //////////////////////////////
variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "project_name" {}

variable "aws_region" {}

variable "bucket_name" {}

# for values, run this query in snowflake:
# DESC STORAGE INTEGRATION
variable "STORAGE_AWS_IAM_USER_ARN" {}

variable "STORAGE_AWS_EXTERNAL_ID" {}