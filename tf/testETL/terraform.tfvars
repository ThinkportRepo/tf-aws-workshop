job_name="tf-aws-workshop-test-job"
job_script="./scripts/test_etl.py"
job_arguments = {
  S3_TARGET_BUCKET = ""
}
job_temp_dir = ""
job_target_bucket = "test-etl-result"
job_tmp_bucket = "test-etl-tmp"