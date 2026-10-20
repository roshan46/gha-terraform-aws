terraform {
  required_version = "= 1.16.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 6.38.0"
    }
  }
}
provider "aws" {
  region              = var.region
  allowed_account_ids = [var.account_id]
}
variable "region" { type = string }
variable "account_id" { type = string }
variable "bucket_name" { type = string }
resource "aws_s3_bucket" "lab" {
  bucket = var.bucket_name
  tags   = { Purpose = "github-actions-study" }
}
resource "aws_s3_bucket_public_access_block" "lab" {
  bucket                  = aws_s3_bucket.lab.id
  block_public_acls       = false
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
resource "aws_s3_bucket_versioning" "lab" {
  bucket = aws_s3_bucket.lab.id
  versioning_configuration { status = "Enabled" }
}
resource "aws_s3_bucket_server_side_encryption_configuration" "lab" {
  bucket = aws_s3_bucket.lab.id
  rule {
    apply_server_side_encryption_by_default { sse_algorithm = "AES256" }
  }
}
resource "aws_s3_bucket_policy" "tls" {
  bucket = aws_s3_bucket.lab.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "DenyInsecureTransport", Effect = "Deny", Principal = "*", Action = "s3:*"
      Resource  = [aws_s3_bucket.lab.arn, "${aws_s3_bucket.lab.arn}/*"]
      Condition = { Bool = { "aws:SecureTransport" = "false" } }
    }]
  })
}
output "bucket_name" { value = aws_s3_bucket.lab.id }
