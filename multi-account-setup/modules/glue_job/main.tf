locals {
  default_arguments = {
    "--job-language"        = var.language
    "--job-bookmark-option" = lookup(var.bookmark_options, var.bookmark)
    "--TempDir"             = var.temp_dir
  }
}

resource "aws_glue_job" "glue_job" {
  count = var.create ? 1 : 0

  name               = var.name
  role_arn           = var.role_arn
  connections        = var.connections
  number_of_workers  = var.nr_of_workers
  worker_type        = var.worker_type
  glue_version       = var.glue_version

  command {
    script_location = var.script_location
    python_version  = var.python_version
    name            = var.command_type
  }

  default_arguments = merge(local.default_arguments, var.arguments)

  description = var.description
  max_retries = var.max_retries
  timeout     = var.timeout

  execution_property {
    max_concurrent_runs = var.max_concurrent
  }
}