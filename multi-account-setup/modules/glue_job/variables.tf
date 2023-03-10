variable "create" {
  default = true
}

variable "name" {}

variable "role_arn" {}

variable "connections" {
  default = []
}

variable "nr_of_workers" {
  default = 1
}

variable "worker_type" {
  default = "G.1X"
}

variable "script_location" {}

variable "command_name" {
  default = ""
}

variable "language" {
  default = "python"
}

variable "glue_version" {
  default = "3.0"
}

variable "python_version" {
  default = "3"
}

variable "command_type" {
  default = "glueetl"
}

variable "bookmark" {
  default     = "disabled"
  description = "It can be enabled, disabled or paused."
}

variable "bookmark_options" {
  type = map(string)

  default = {
    enabled  = "job-bookmark-enable"
    disabled = "job-bookmark-disable"
    paused   = "job-bookmark-pause"
  }
}

variable "temp_dir" {}

variable "description" {
  default = ""
}

variable "max_retries" {
  default = 1
}

variable "timeout" {
  default = 2880
}

variable "max_concurrent" {
  default = 1
}

variable "arguments" {
  type    = map(string)
  default = {}
}