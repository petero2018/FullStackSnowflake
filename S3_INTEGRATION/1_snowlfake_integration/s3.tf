resource "aws_s3_bucket" "snowflake-ingestion" {
  bucket = var.bucket_name
  force_destroy = true
  acl = "private"
  tags = local.common_tags
}

output "bucket_name" {
  value = "s3://${aws_s3_bucket.snowflake-ingestion.bucket}"
  description = "use this bucket name as storage_allowed_locations to create a snowflake S3 integration"
}