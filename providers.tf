
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "amzn-s3-p3-tt98"
    key    = "terraform_modules/terraform.tfstate"
    region = "ap-south-1"
  }
}


