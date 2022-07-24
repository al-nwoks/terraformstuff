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

module "staticwebsite-s3" {
  source                = "./modules/s3"
  category              = var.category
  s3name                = var.s3name
  s3versioning          = var.s3versioning
}
module "staticwebsite-s3policy" {
  source                = "./modules/s3policy"
  category              = var.category
  s3name                = var.s3name
  s3arn                 = module.staticwebsite-s3.staticwebsite-s3arn
  iamrolearn            = var.iamrolearn
}