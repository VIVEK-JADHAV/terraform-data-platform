variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (dev or prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "Environment must be 'dev' or 'prod'."
  }
}

variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
  default     = "shopstream"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{2,20}$", var.project_name))
    error_message = "Project name must be lowercase, start with a letter, 3-21 chars, only letters/numbers/hyphens."
  }
}

variable "raw_lifecycle_ia_days" {
  description = "Days before raw data transitions to Infrequent Access"
  type        = number
  default     = 60

  validation {
    condition     = var.raw_lifecycle_ia_days >= 30
    error_message = "IA transition must be at least 30 days (AWS minimum)."
  }
}

variable "raw_lifecycle_glacier_days" {
  description = "Days before raw data transitions to Glacier"
  type        = number
  default     = 180

  validation {
    condition     = var.raw_lifecycle_glacier_days > var.raw_lifecycle_ia_days
    error_message = "Glacier transition must be after IA transition."
  }
}

variable "staging_expiration_days" {
  description = "Days before staging data is deleted"
  type        = number
  default     = 90
}

variable "logs_expiration_days" {
  description = "Days before access logs are deleted"
  type        = number
  default     = 30
}

variable "curated_noncurrent_expiration_days" {
  description = "Days before old versions in curated bucket are deleted"
  type        = number
  default     = 30
}
