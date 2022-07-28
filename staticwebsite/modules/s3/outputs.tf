output "staticwebsite-s3arn" {
  value = aws_s3_bucket.staticwebsite-s3.arn
}
output "staticwebsite-s3regionaldomainname" {
  value = aws_s3_bucket.staticwebsite-s3.bucket_regional_domain_name
}