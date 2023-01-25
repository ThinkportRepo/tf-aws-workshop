#### GLUE JOB ##########
variable "create_job" {
  default = true
}

variable "job_name" {
  default = "tf-aws-workshop-test-job"
}

variable "job_role_arn" {
  default = ""
}

variable "job_connections" {
  type    = list(string)
  default = []
}

variable "job_max_capacity" {
  default = 2
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

###### GLUE JOB S3 TARGET BUCKET ########
variable "job_target_bucket" {
  default = "test-etl-result"
}
###### GLUE JOB S3 TMP BUCKET ########
variable "job_tmp_bucket" {
  default = "test-etl-tmp"
}
###### GLUE JOB S3 SOURCE BUCKET ########
variable "job_script_bucket" {
  default = "job_script_bucket"
}
###### GLUE JOB IAM ROLE ########
variable "job_iam_role" {
  default = "test-job-iam-role"
}
####### AWS Provider ###############
variable "aws_account" {
  default = ""
}

variable "aws_region" {
  default = "eu-central-1"
}

