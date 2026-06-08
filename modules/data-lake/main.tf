locals {
  bucket_prefix = "${var.project_name}-${var.environment}-${var.account_id}"
}

resource "aws_kms_key" "data_lake" {
  description             = "KMS key for ${var.project_name} data lake encryption"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = {
    Name = "${var.project_name}-${var.environment}-data-lake-key"
  }
}

resource "aws_kms_alias" "data_lake" {
  name          = "alias/${var.project_name}-${var.environment}-data-lake"
  target_key_id = aws_kms_key.data_lake.key_id
}

# --- LOGS BUCKET ---

resource "aws_s3_bucket" "logs" {
  bucket = "${local.bucket_prefix}-logs"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "logs" {
  bucket = aws_s3_bucket.logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id

  rule {
    id     = "expire-old-logs"
    status = "Enabled"

    expiration {
      days = var.logs_expiration_days
    }
  }
}

# --- RAW ZONE ---

resource "aws_s3_bucket" "raw" {
  bucket = "${local.bucket_prefix}-raw"
}

resource "aws_s3_bucket_versioning" "raw" {
  bucket = aws_s3_bucket.raw.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "raw" {
  bucket = aws_s3_bucket.raw.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.data_lake.arn
    }
    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_public_access_block" "raw" {
  bucket = aws_s3_bucket.raw.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "raw" {
  bucket = aws_s3_bucket.raw.id

  rule {
    id     = "transition-to-ia-and-glacier"
    status = "Enabled"

    transition {
      days          = var.raw_lifecycle_ia_days
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = var.raw_lifecycle_glacier_days
      storage_class = "GLACIER"
    }
  }
}

resource "aws_s3_bucket_logging" "raw" {
  bucket = aws_s3_bucket.raw.id

  target_bucket = aws_s3_bucket.logs.id
  target_prefix = "raw/"
}

# --- STAGING ZONE ---

resource "aws_s3_bucket" "staging" {
  bucket = "${local.bucket_prefix}-staging"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "staging" {
  bucket = aws_s3_bucket.staging.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.data_lake.arn
    }
    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_public_access_block" "staging" {
  bucket = aws_s3_bucket.staging.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "staging" {
  bucket = aws_s3_bucket.staging.id

  rule {
    id     = "expire-intermediate-data"
    status = "Enabled"

    expiration {
      days = var.staging_expiration_days
    }
  }
}

resource "aws_s3_bucket_logging" "staging" {
  bucket = aws_s3_bucket.staging.id

  target_bucket = aws_s3_bucket.logs.id
  target_prefix = "staging/"
}

# --- CURATED ZONE ---

resource "aws_s3_bucket" "curated" {
  bucket = "${local.bucket_prefix}-curated"
}

resource "aws_s3_bucket_versioning" "curated" {
  bucket = aws_s3_bucket.curated.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "curated" {
  bucket = aws_s3_bucket.curated.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.data_lake.arn
    }
    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_public_access_block" "curated" {
  bucket = aws_s3_bucket.curated.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_logging" "curated" {
  bucket = aws_s3_bucket.curated.id

  target_bucket = aws_s3_bucket.logs.id
  target_prefix = "curated/"
}

resource "aws_s3_bucket_lifecycle_configuration" "curated" {
  bucket = aws_s3_bucket.curated.id

  rule {
    id     = "cleanup-old-versions"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = var.curated_noncurrent_expiration_days
    }
  }
}
