terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  # Configure remote backend with state locking in automation account
  backend "s3" {
    bucket         = "ou-anm4-0exbp2yg-tf-remote-backend"
    key            = "testETL/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "ou-anm4-0exbp2yg-tf-s3-state-lock"
  }
}

locals {
  account_id        = lookup(var.account_id, var.aws_account)
  job_script_bucket = join("-", [var.job_script_bucket, terraform.workspace])
  job_tmp_bucket    = join("-", [var.job_tmp_bucket, terraform.workspace])
  job_name          = join("-", [var.job_name, terraform.workspace])
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
  # will be assumed if pipeline is run via gh actions
  dynamic "assume_role_with_web_identity" {
    for_each = var.is_local == true ? [] : [1]

    content {
      role_arn                = "arn:aws:iam::${local.account_id}:role/AutomationAccountAccessRole"
      web_identity_token_file = var.web_identity_token_file
    }
  }
  # set variable is_local to true if run locally with iam user
  dynamic "assume_role" {
    for_each = var.is_local == true ? [1] : []
    content {
      role_arn = "arn:aws:iam::${local.account_id}:role/AutomationAccountAccessRole"
    }
  }
}

### Example for local module and submodules
module "glue_job" {
  source = "../modules/glue_job"

  create = var.create_job

  name            = local.job_name
  role_arn        = module.glue_job_role.arn
  script_location = "s3://${module.s3_script_bucket.s3_bucket_id}/test_etl.py"
  nr_of_workers   = var.nr_of_workers
  temp_dir = "s3://${module.s3_tmp_bucket.s3_bucket_id}/"
}

module "s3_tmp_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  bucket  = local.job_tmp_bucket

  acl = "private"

  # Auto-delete objects in bucket
  force_destroy = true

  versioning = {
    enabled = true
  }
  object_lock_enabled = true

  # S3 bucket-level Public Access Block configuration
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  # S3 Bucket Ownership Controls
  control_object_ownership = true
  object_ownership         = "ObjectWriter"
}


module "s3_script_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket  = local.job_script_bucket

  acl = "private"

  # Auto-delete objects in bucket
  force_destroy = true

  versioning = {
    enabled = true
  }
  object_lock_enabled = true

  # S3 bucket-level Public Access Block configuration
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  # S3 Bucket Ownership Controls
  control_object_ownership = true
  object_ownership         = "ObjectWriter"
}

# Upload local glue script to s3 bucket (example submodule)
resource "aws_s3_object" "job_script" {
  bucket        = module.s3_script_bucket.s3_bucket_id
  key           = "test_etl.py"
  source        = "${path.module}/scripts/test_etl.py"
  force_destroy = true
  etag          = filemd5("${path.module}/scripts/test_etl.py")
}


module "glue_job_role" {
  source = "cloudposse/iam-role/aws"
  # pin module to a specific version
  version = "0.17.0"

  enabled = true
  name    = var.job_iam_role

  policy_description = "Policy for AWS Glue with access to EC2, S3, and Cloudwatch Logs"
  role_description   = "Role for AWS Glue with access to EC2, S3, and Cloudwatch Logs"

  principals = {
    "Service" = ["glue.amazonaws.com"]
  }
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ]

  policy_documents = [
    data.aws_iam_policy_document.s3_access.json
  ]
}

# Define Glue Job Policy
data "aws_iam_policy_document" "s3_access" {
  statement {
    effect = "Allow"
    resources = [
      "arn:aws:s3:::${local.job_script_bucket}",
      "arn:aws:s3:::${local.job_script_bucket}/*",
      "arn:aws:s3:::${local.job_tmp_bucket}",
      "arn:aws:s3:::${local.job_tmp_bucket}/*"
    ]

    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:ListBucket",
    ]
  }
}