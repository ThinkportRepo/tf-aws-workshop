terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
#  backend "s3" {
#    bucket = "my-terraform-state"
#    key    = "path/to/my-state-file"
#    region = "eu-central-1"
#    dynamodb_table = "terraform_locks"
#  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
  profile = "thinkport"
}



