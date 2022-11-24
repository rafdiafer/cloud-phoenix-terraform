provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

resource "aws_dynamodb_table" "dynamodb_tf_state_lock" {
  name           = "${var.app_name}-dynamodb-tf-state-lock"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToLive"
    enabled        = false
  }

  tags = {
    "Name" = "TF State lock table in DynamoDB"
  }
}

resource "aws_s3_bucket" "s3_tf_state" {
  bucket = "s3-tf-state-${var.app_name}"

  tags = {
    "Name" = "S3 bucket to store TF State file"
  }
}

resource "aws_s3_bucket_acl" "s3_acl" {
  bucket = aws_s3_bucket.s3_tf_state.id
  acl    = "private"
}

resource "aws_ecr_repository" "ecr_image_url" {
  name = var.app_name

  tags = {
    "Name" = "Application image repository in ECR"
  }
}

