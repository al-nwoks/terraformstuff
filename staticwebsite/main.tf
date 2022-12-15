provider "aws" {
  region  = var.aws_region
}
 
data "aws_caller_identity" "current" {}

# You cannot create a new backend by simply defining this and then
# immediately proceeding to "terraform apply". The S3 backend must
# be bootstrapped according to the simple yet essential procedure in
# https://github.com/cloudposse/terraform-aws-tfstate-backend#usage
module "terraform_state_backend" {
  source     = "cloudposse/tfstate-backend/aws"
  version    = "0.38.1"
  namespace  = var.organization
  name       = var.name
  attributes = [data.aws_caller_identity.current.account_id]

  terraform_backend_config_file_path = ""
  terraform_backend_config_file_name = "backend.tf"

  terraform_state_file = "${var.name}/terraform.tfstate"
  force_destroy        = false
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
  iamrolearn            = module.staticwebsite_role.iam_role_arn
}

#module "staticwebsite-cloudfront" {
#  source                = "./modules/cloudfront"
#  category              = var.category
#  distributionendpoint  = var.distributionendpoint
#  s3name                = var.s3name
#  s3regionaldomainname  = module.staticwebsite-s3.staticwebsite-s3regionaldomainname
#  iamrolearn            = var.iamrolearn
#  acmcertificatearn     = module.acm.acm_certificate_arn
#}


module "staticwebsite_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  
  create_role            = true
  role_name              = var.staticwebsiterole
  attach_readonly_policy = true

}

module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  domain_name  = var.domain_name
  zone_id      = var.zone_id 

  subject_alternative_names = [
    "*.${var.domain_name}",
    "app.sub.${var.domain_name}",
  ]

  wait_for_validation = true

  tags = {
    Name = "${var.domain_name}"
  }
}

