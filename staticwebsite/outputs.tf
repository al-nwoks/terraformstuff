output "role_arn" {
  value = module.oidc_github.iam_role_arn
}

output "s3_bucket_domain_name" {
  value = module.terraform_state_backend.s3_bucket_domain_name
}

output "s3_bucket_id" {
  value = module.terraform_state_backend.s3_bucket_id
}

output "s3_bucket_arn" {
  value = module.terraform_state_backend.s3_bucket_arn
}

output "dynamodb_table_arn" {
  value = module.terraform_state_backend.dynamodb_table_arn
}

output "dynamodb_table_name" {
  value = module.terraform_state_backend.dynamodb_table_name
}

output "dynamodb_table_id" {
  value = module.terraform_state_backend.dynamodb_table_id
}