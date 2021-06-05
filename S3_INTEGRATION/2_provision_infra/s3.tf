resource "aws_s3_bucket" "snowflake-ingestion" {
  bucket = var.bucket_name
  force_destroy = true
  acl = "private"
  tags = local.common_tags
}

