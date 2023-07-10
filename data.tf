data "aws_region" "current" {}

data "aws_s3_bucket" "source_bucket" {
  bucket = var.source_s3_name
}
