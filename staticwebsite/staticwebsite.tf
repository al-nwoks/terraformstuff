provider "aws" {
  region  = var.aws_region
}
 
terraform {
  backend "s3" {
    bucket = "kaye-terraform-states"
    region = "ap-southeast-1"
    key    = "StaticWebsiteDemo.tfstate"
  }
  required_version = ">= 1.0.11"
}

resource "aws_s3_bucket" "staticwebsite-s3" {
  bucket = "${var.s3name}"
  lifecycle {
    ignore_changes = [
      website
    ]
  }
  tags = {
    Category         = var.category
  }
}

resource "aws_s3_bucket_website_configuration" "staticwebsite-s3websiteconfig" {
  bucket = aws_s3_bucket.staticwebsite-s3.bucket
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "index.html"
  }
}
resource "aws_s3_bucket_public_access_block" "staticwebsite-s3publicaccess" {
  bucket                  = aws_s3_bucket.staticwebsite-s3.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "staticwebsite-s3bucketowner" {
  bucket = aws_s3_bucket.staticwebsite-s3.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.staticwebsite-s3.id
  versioning_configuration {
    status = "${var.s3versioning}"
  }
}
