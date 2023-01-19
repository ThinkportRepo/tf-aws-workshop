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

variable "job_temp_dir" {
  default = ""
}

variable "job_arguments" {
  type    = map(string)
  default = {}
}
###### GLUE JOB S3 TARGET BUCKET ########
variable "job_target_bucket" {
  default = ""
}
###### GLUE JOB S3 TMP BUCKET ########
variable "job_tmp_bucket" {
  default = ""
}