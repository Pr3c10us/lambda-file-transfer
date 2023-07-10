data "aws_iam_policy_document" "role_policy" {
  statement {
    sid    = ""
    effect = "Allow"
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "lambda_policy" {
  statement {
    sid    = "S3Access"
    effect = "Allow"
    actions = [
      "s3:GetObject"
    ]
    resources = [
      data.aws_s3_bucket.source_bucket.arn
    ]
  }
  statement {
    sid    = "ListS3Bucket"
    effect = "Allow"
    actions = [
      "s3:ListBucket"
    ]
    resources = [
      data.aws_s3_bucket.source_bucket.arn
    ]
  }
  statement {
    sid    = "SecretsManagerAccess"
    effect = "Allow"
    actions = [
      "secretsmanager:GetResourcePolicy",
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecretVersionIds"
    ]
    resources = [
      aws_secretsmanager_secret.sftp_creds.arn
    ]
  }
}

resource "aws_iam_policy" "lambda_policy" {
  name        = "${var.name}-policy"
  description = "This policy allows lambda function ${var.name} to read from ${data.aws_s3_bucket.source_bucket.arn} bucket."
  policy      = data.aws_iam_policy_document.lambda_policy.json
}

resource "aws_iam_role" "role" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.role_policy.json
}

resource "aws_iam_role_policy_attachment" "s3_access" {
  policy_arn = aws_iam_policy.lambda_policy.arn
  role       = aws_iam_role.role.name
}