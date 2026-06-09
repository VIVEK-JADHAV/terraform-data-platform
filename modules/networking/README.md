# Networking Module

Creates a production VPC with public/private subnet separation for data platform services.

## Resources Created

- VPC (10.0.0.0/16)
- 2 public subnets (for NAT Gateway, load balancers)
- 3 private subnets (for MSK, Redshift, ECS — one per AZ)
- Internet Gateway
- NAT Gateway + Elastic IP
- Route tables (public → IGW, private → NAT)
- Security group (VPC-only ingress, all egress)

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| project_name | Project name for resource naming | string | - |
| environment | Environment (dev or prod) | string | - |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | ID of the VPC |
| private_subnet_ids | List of private subnet IDs |
| public_subnet_ids | List of public subnet IDs |
| data_services_sg_id | Security group ID for data services |

## Usage

```hcl
module "networking" {
  source = "./modules/networking"

  project_name = "shopstream"
  environment  = "dev"
}
```
