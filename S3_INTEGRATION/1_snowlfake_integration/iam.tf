resource "aws_iam_role" "snowflake_read_role" {
  name               = "snowflake-read-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

output "rolename" {
 value = aws_iam_role.snowflake_read_role.arn
 description = "use this role arn as storage_aws_role_arn for snowflake S3 storage instegration"
}