output "raw_bucket_name" {
  description = "Name of the raw data lake bucket"
  value       = aws_s3_bucket.raw.id
}

output "staging_bucket_name" {
  description = "Name of the staging data lake bucket"
  value       = aws_s3_bucket.staging.id
}

output "curated_bucket_name" {
  description = "Name of the curated data lake bucket"
  value       = aws_s3_bucket.curated.id
}

output "data_lake_kms_key_arn" {
  description = "ARN of the KMS key used for data lake encryption"
  value       = aws_kms_key.data_lake.arn
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "private_subnet_ids" {
  description = "IDs of private subnets (for MSK, Redshift, ECS)"
  value       = aws_subnet.private[*].id
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = aws_subnet.public[*].id
}

output "data_services_sg_id" {
  description = "Security group ID for data services"
  value       = aws_security_group.data_services.id
}
