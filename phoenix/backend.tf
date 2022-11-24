terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "s3-tf-state-phoenix"
    dynamodb_table = "phoenix-dynamodb-tf-state-lock"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
  }
}