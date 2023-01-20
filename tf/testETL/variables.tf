#### GLUE JOB ##########
variable "create_job" {
  default = true
}

variable "job_name" {
  default = ""
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
  default = ""
}

variable "job_language" {
  default = "python"
}

variable "job_bookmark" {
  default = "disabled"
}

variable "job_arguments" {
  type    = map(string)
  default = {
    S3_TARGET_BUCKET = module.s3_target_bucket.s3_bucket_arn
  }
}
###### GLUE JOB S3 TARGET BUCKET ########
variable "job_target_bucket" {
  default = ""
}
###### GLUE JOB S3 TMP BUCKET ########
variable "job_tmp_bucket" {
  default = ""
}
###### GLUE JOB S3 SOURCE BUCKET ########
variable "job_script_bucket" {
  default = ""
}
###### GLUE JOB IAM ROLE ########
variable "job_iam_role" {
  default = ""
}


