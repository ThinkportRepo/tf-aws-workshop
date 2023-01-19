terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  # Configure remote backend with state locking
  backend "s3" {
    bucket = "my-terraform-state"
    key    = "path/to/my-state-file"
    region = "eu-central-1"
    dynamodb_table = "terraform_locks"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
}


module "glue_job" {
  source = "../modules/glue_job"

  create = var.create_job

  name   = var.job_name
  role_arn = var.job_role_arn
  script_location = var.job_script

  connections = var.job_connections
  max_capacity = var.job_max_capacity
  arguments = var.job_arguments
  temp_dir = var.job_temp_dir
}