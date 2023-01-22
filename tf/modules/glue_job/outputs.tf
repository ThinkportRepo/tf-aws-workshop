output "name" {
  value = join(",", aws_glue_job.glue_job.*.id)
}

output "dpu" {
  value = join(",", aws_glue_job.glue_job.*.max_capacity)
}