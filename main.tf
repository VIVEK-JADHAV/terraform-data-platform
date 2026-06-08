terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}

data "aws_caller_identity" "current" {}

module "networking" {
  source = "./modules/networking"

  project_name = var.project_name
  environment  = var.environment
}

module "data_lake" {
  source = "./modules/data-lake"

  project_name                       = var.project_name
  environment                        = var.environment
  account_id                         = data.aws_caller_identity.current.account_id
  raw_lifecycle_ia_days              = var.raw_lifecycle_ia_days
  raw_lifecycle_glacier_days         = var.raw_lifecycle_glacier_days
  staging_expiration_days            = var.staging_expiration_days
  logs_expiration_days               = var.logs_expiration_days
  curated_noncurrent_expiration_days = var.curated_noncurrent_expiration_days
}

module "iam" {
  source = "./modules/iam"

  project_name       = var.project_name
  environment        = var.environment
  aws_region         = var.aws_region
  account_id         = data.aws_caller_identity.current.account_id
  raw_bucket_arn     = module.data_lake.raw_bucket_arn
  staging_bucket_arn = module.data_lake.staging_bucket_arn
  curated_bucket_arn = module.data_lake.curated_bucket_arn
  kms_key_arn        = module.data_lake.kms_key_arn
}
