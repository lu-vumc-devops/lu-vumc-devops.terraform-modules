terraform {
  required_version = ">= 0.13.0"
}

provider "aws" {
  alias   = "product"
  region  = var.region
  profile = var.profile
}

module "null_label" {
  source = "git@github.com:cloudposse/terraform-null-label.git?ref=0.25.0"

  namespace  = var.namespace
  stage      = var.stage
  name       = var.name
  attributes = var.attributes
  delimiter  = var.delimiter
}

data "aws_caller_identity" "current" {
  provider = aws.product
}

resource "aws_iam_account_alias" "alias" {
  provider      = aws.product
  account_alias = var.account_alias
}

resource "aws_s3_bucket" "infra" {
  provider = aws.product
  bucket   = "${data.aws_caller_identity.current.account_id}-infrastructure"

  tags = module.null_label.tags
}

resource "aws_s3_bucket_versioning" "infra_s3_versioning" {
  bucket = aws_s3_bucket.infra.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "infra_s3_sse" {
  bucket = aws_s3_bucket.infra.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "infra_access" {
  provider = aws.product
  bucket   = aws_s3_bucket.infra.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
