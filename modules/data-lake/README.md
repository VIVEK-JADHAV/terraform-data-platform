# Data Lake Module

Creates a 3-zone S3 data lake with KMS encryption, lifecycle policies, and access logging.

## Resources Created

- KMS key (auto-rotation enabled) + alias
- S3 bucket: raw (versioned, IA → Glacier transition)
- S3 bucket: staging (expires after N days — recomputable)
- S3 bucket: curated (versioned, old versions expire)
- S3 bucket: logs (captures access logs from all zones)
- Public access blocked on all buckets
- Access logging enabled on raw, staging, curated → logs bucket

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| project_name | Project name for resource naming | string | - |
| environment | Environment (dev or prod) | string | - |
| account_id | AWS account ID for unique bucket names | string | - |
| raw_lifecycle_ia_days | Days before raw → Infrequent Access | number | - |
| raw_lifecycle_glacier_days | Days before raw → Glacier | number | - |
| staging_expiration_days | Days before staging data is deleted | number | - |
| logs_expiration_days | Days before logs are deleted | number | - |
| curated_noncurrent_expiration_days | Days before old curated versions are deleted | number | - |

## Outputs

| Name | Description |
|------|-------------|
| raw_bucket_name | Name of the raw bucket |
| raw_bucket_arn | ARN of the raw bucket |
| staging_bucket_name | Name of the staging bucket |
| staging_bucket_arn | ARN of the staging bucket |
| curated_bucket_name | Name of the curated bucket |
| curated_bucket_arn | ARN of the curated bucket |
| kms_key_arn | ARN of the data lake KMS key |

## Usage

```hcl
module "data_lake" {
  source = "./modules/data-lake"

  project_name                       = "shopstream"
  environment                        = "dev"
  account_id                         = "123456789012"
  raw_lifecycle_ia_days              = 60
  raw_lifecycle_glacier_days         = 180
  staging_expiration_days            = 90
  logs_expiration_days               = 30
  curated_noncurrent_expiration_days = 30
}
```
