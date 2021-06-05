terraform {
  backend "s3" {
    bucket = "snowflake-tfstate"
    key    = "snowflake-infra/terraform.tfstate"
    region = "eu-west-2"

    dynamodb_table = "snowflake-tfstatelock"
    encrypt        = true
  }
}
