terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  # Configure remote backend with state locking
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
}

# Example for local module
module "glue_job" {
  source = "../modules/glue_job"

  create = var.create_job

  name   = var.job_name
  role_arn = var.job_role_arn
  script_location = module.s3_bucket_tmp_bucket.s3_bucket_arn

  connections = var.job_connections
  max_capacity = var.job_max_capacity
  arguments = var.job_arguments
  temp_dir = module.s3_bucket_tmp_bucket.s3_bucket_arn
}

# Example for TF registry module
module "s3_bucket_target_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = var.job_target_bucket

  acl    = "private"

  # Auto-delete objects in bucket
  force_destroy = true

  versioning = {
    status     = true
    mfa_delete = false
  }

  # S3 bucket-level Public Access Block configuration
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  # S3 Bucket Ownership Controls
  control_object_ownership = true
  object_ownership         = "ObjectWriter"

}

module "s3_bucket_tmp_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = var.job_tmp_bucket

  acl    = "private"

  # Auto-delete objects in bucket
  force_destroy = true

  versioning = {
    status     = true
    mfa_delete = false
  }

  # S3 bucket-level Public Access Block configuration
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  # S3 Bucket Ownership Controls
  control_object_ownership = true
  object_ownership         = "ObjectWriter"
}

