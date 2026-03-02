terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "amzn-s3-p3-tt98"                     # bucket name
    key    = "terraform_modules/terraform.tfstate" #where actully stores the files
    region = "ap-south-1"
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = "ap-south-1"
  access_key = "xxxxx-xxxxx"
  secret_key = "xxxxx-xxxxx-xxxxx"
}
