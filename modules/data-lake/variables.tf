variable "project_name" {
  description = "Project name for resource naming"
  type        = string
}

variable "environment" {
  description = "Environment (dev or prod)"
  type        = string
}

variable "account_id" {
  description = "AWS account ID for globally unique bucket names"
  type        = string
}

variable "raw_lifecycle_ia_days" {
  description = "Days before raw data transitions to IA"
  type        = number
}

variable "raw_lifecycle_glacier_days" {
  description = "Days before raw data transitions to Glacier"
  type        = number
}

variable "staging_expiration_days" {
  description = "Days before staging data is deleted"
  type        = number
}

variable "logs_expiration_days" {
  description = "Days before logs are deleted"
  type        = number
}

variable "curated_noncurrent_expiration_days" {
  description = "Days before old versions in curated are deleted"
  type        = number
}
