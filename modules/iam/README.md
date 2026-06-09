# IAM Module

Creates least-privilege IAM roles for data platform services (Lambda, EMR Serverless, ECS Fargate).

## Resources Created

- Lambda role + policies (S3 read/write, Bedrock invoke, CloudWatch logs)
- EMR role + policies (S3 read/write, Glue catalog, CloudWatch logs)
- ECS task role + policies (MSK read/write, S3 write, CloudWatch logs)

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| project_name | Project name for resource naming | string | - |
| environment | Environment (dev or prod) | string | - |
| aws_region | AWS region | string | - |
| account_id | AWS account ID | string | - |
| raw_bucket_arn | ARN of the raw S3 bucket | string | - |
| staging_bucket_arn | ARN of the staging S3 bucket | string | - |
| curated_bucket_arn | ARN of the curated S3 bucket | string | - |
| kms_key_arn | ARN of the KMS key | string | - |

## Outputs

| Name | Description |
|------|-------------|
| lambda_role_arn | ARN of the Lambda execution role |
| emr_role_arn | ARN of the EMR Serverless role |
| ecs_task_role_arn | ARN of the ECS task role |

## Usage

```hcl
module "iam" {
  source = "./modules/iam"

  project_name       = "shopstream"
  environment        = "dev"
  aws_region         = "us-east-1"
  account_id         = "123456789012"
  raw_bucket_arn     = module.data_lake.raw_bucket_arn
  staging_bucket_arn = module.data_lake.staging_bucket_arn
  curated_bucket_arn = module.data_lake.curated_bucket_arn
  kms_key_arn        = module.data_lake.kms_key_arn
}
```
