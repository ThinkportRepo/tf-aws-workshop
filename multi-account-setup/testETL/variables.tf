#### GLUE JOB ##########
variable "create_job" {
  default = true
}

variable "job_name" {
  default = "test-etl-job"
}

variable "job_role_arn" {
  default = ""
}

variable "job_connections" {
  type    = list(string)
  default = []
}

variable "nr_of_workers" {
  default = 1
}

variable "job_script" {
  default = "./scripts/test_etl.py"
}

variable "job_language" {
  default = "python"
}

variable "job_bookmark" {
  default = "disabled"
}

###### GLUE JOB S3 TMP BUCKET ########
variable "job_tmp_bucket" {
  default = "test-etl-tmp"
}
###### GLUE JOB S3 SOURCE BUCKET ########
variable "job_script_bucket" {
  default = "test-etl-script-bucket"
}
###### GLUE JOB IAM ROLE ########
variable "job_iam_role" {
  default = "test-job-iam-role"
}
####### AWS Provider ###############
variable "aws_account" {
  default = "dev"
}

variable "aws_region" {
  default = "eu-central-1"
}

##### JWT Token
variable "web_identity_token_file" {
  type    = string
  default = "/tmp/web_identity_token_file"
}

##### Account Ids
variable "account_id" {
  type = map(string)

  default = {
    prod    = "<fill_account_id_here>"
    dev     = "<fill_account_id_here>"
    staging = "<fill_account_id_here>"
  }
}

### Identity executing terraform
variable "is_local" {
  type    = bool
  default = false
}

