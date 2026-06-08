output "raw_bucket_name" {
  description = "Name of the raw data lake bucket"
  value       = aws_s3_bucket.raw.id
}

output "raw_bucket_arn" {
  description = "ARN of the raw data lake bucket"
  value       = aws_s3_bucket.raw.arn
}

output "staging_bucket_name" {
  description = "Name of the staging bucket"
  value       = aws_s3_bucket.staging.id
}

output "staging_bucket_arn" {
  description = "ARN of the staging bucket"
  value       = aws_s3_bucket.staging.arn
}

output "curated_bucket_name" {
  description = "Name of the curated bucket"
  value       = aws_s3_bucket.curated.id
}

output "curated_bucket_arn" {
  description = "ARN of the curated bucket"
  value       = aws_s3_bucket.curated.arn
}

output "kms_key_arn" {
  description = "ARN of the KMS key for data lake encryption"
  value       = aws_kms_key.data_lake.arn
}
