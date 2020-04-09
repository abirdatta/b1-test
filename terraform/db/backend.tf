provider "aws" {
  region = "ap-southeast-1"
}

terraform {
  backend "s3" {
    bucket = "b1-test.terraform.tfstate"
    key    = "b1-test-db"
    region = "ap-southeast-1"
  }
}