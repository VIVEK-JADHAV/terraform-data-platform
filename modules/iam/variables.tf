variable "project_name" {
  description = "Project name for resource naming"
  type        = string
}

variable "environment" {
  description = "Environment (dev or prod)"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "raw_bucket_arn" {
  description = "ARN of the raw S3 bucket"
  type        = string
}

variable "staging_bucket_arn" {
  description = "ARN of the staging S3 bucket"
  type        = string
}

variable "curated_bucket_arn" {
  description = "ARN of the curated S3 bucket"
  type        = string
}

variable "kms_key_arn" {
  description = "ARN of the KMS key for data lake"
  type        = string
}
