output "vpc_id" {
  description = "ID of the VPC"
  value       = module.networking.vpc_id
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = module.networking.private_subnet_ids
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = module.networking.public_subnet_ids
}

output "data_services_sg_id" {
  description = "Security group ID for data services"
  value       = module.networking.data_services_sg_id
}

output "raw_bucket_name" {
  description = "Name of the raw data lake bucket"
  value       = module.data_lake.raw_bucket_name
}

output "staging_bucket_name" {
  description = "Name of the staging bucket"
  value       = module.data_lake.staging_bucket_name
}

output "curated_bucket_name" {
  description = "Name of the curated bucket"
  value       = module.data_lake.curated_bucket_name
}

output "kms_key_arn" {
  description = "ARN of the data lake KMS key"
  value       = module.data_lake.kms_key_arn
}

output "lambda_role_arn" {
  description = "ARN of the Lambda execution role"
  value       = module.iam.lambda_role_arn
}

output "emr_role_arn" {
  description = "ARN of the EMR Serverless role"
  value       = module.iam.emr_role_arn
}

output "ecs_task_role_arn" {
  description = "ARN of the ECS task role"
  value       = module.iam.ecs_task_role_arn
}
