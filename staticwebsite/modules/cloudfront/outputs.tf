output "staticwebsite-iamarn" {
  value = aws_cloudfront_origin_access_identity.staticwebsite-oai.iam_arn
}
output "staticwebsite-s3can" {
  value = aws_cloudfront_origin_access_identity.staticwebsite-oai.s3_canonical_user_id
  #https://github.com/hashicorp/terraform-provider-aws/issues/10158
}