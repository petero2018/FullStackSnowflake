
resource "aws_iam_role" "snowflake_read_role" {
  name               = "snowflake-read-role"
  assume_role_policy = data.aws_iam_policy_document.snowflake_read_role_doc.json
  tags = merge(
    local.common_tags,
    tomap({
      Name = "${var.project_name}-role"
    })
  )
}

data "aws_iam_policy_document" "snowflake_read_role_doc" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    effect = "Allow"
  }

  statement {
    actions = ["sts:AssumeRole"]

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"

      values = ["${var.aws_external_id}"]
    }

    principals {
      type        = "AWS"
      identifiers = ["${var.snowflake_iam_user}"]
    }

    effect = "Allow"
  }
}

resource "aws_iam_role_policy_attachment" "snowflake_read" {
  role       = aws_iam_role.snowflake_read_role.name
  policy_arn = aws_iam_policy.snowflake_s3_read_policy.arn
}


resource "aws_iam_policy" "snowflake_s3_read_policy" {
  name        = "snowflake-read-policy"
  description = "snowflake read s3 access"
  policy      = data.aws_iam_policy_document.snowflake_s3_read_policy_doc.json
  tags = merge(
    local.common_tags,
    tomap({
      Name = "${var.project_name}-policy"
    })
  )
}

data "aws_iam_policy_document" "snowflake_s3_read_policy_doc" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion"
    ]

    effect = "Allow"
    
    resources = [
      "${aws_s3_bucket.snowflake-ingestion.arn}/*"
    ]
  }

  statement {
    actions = [
      "s3:ListBucket"
    ]

    effect = "Allow"

    resources = [
      "${aws_s3_bucket.snowflake-ingestion.arn}"
    ]
  }
}
