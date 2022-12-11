provider "aws" {
  region  = var.aws_region
}
 
# You cannot create a new backend by simply defining this and then
# immediately proceeding to "terraform apply". The S3 backend must
# be bootstrapped according to the simple yet essential procedure in
# https://github.com/cloudposse/terraform-aws-tfstate-backend#usage
module "terraform_state_backend" {
  source = "cloudposse/tfstate-backend/aws"
  # Cloud Posse recommends pinning every module to a specific version
  # version     = "x.x.x"
  namespace  = "alnwoks"
  stage      = "infra"
  name       = "terraform"
  attributes = ["state"]

  terraform_backend_config_file_path = "."
  terraform_backend_config_file_name = "backend.tf"
  force_destroy                      = false
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

#module "staticwebsite-cloudfront" {
#  source                = "./modules/cloudfront"
#  category              = var.category
#  distributionendpoint  = var.distributionendpoint
#  s3name                = var.s3name
#  s3regionaldomainname  = module.staticwebsite-s3.staticwebsite-s3regionaldomainname
#  iamrolearn            = var.iamrolearn
#  acmcertificatearn     = var.acmcertificatearn
#}