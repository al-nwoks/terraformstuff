variable "aws_region" {
  type = string
  default = "us-east-1"
}
variable "name" {
  type = string
  default = "staticwebsite"
}
variable "organization" {
  type = string
  default = "al"
}
variable "category" {
  type = string
  default = "demo"
}
variable "s3name" {
  type    = string
  default = "alnwoks-staticwebsite"
}
variable "s3versioning" {
  type    = string
  default = "Disabled"
}
variable "distributionendpoint" {
  type    = string
  default = "codeninja.click"
}
variable "iamrolearn" {
  type    = string
  default = "arn:aws:iam::443420183404:role/s3read"
}
variable "acmcertificatearn" {
  type    = string
  default = "arn:aws:acm:us-east-1:443420183404:certificate/42996f31-4960-42d1-ae47-91a19c0f76db"
}
variable "domain_name" {
  type    = string
  default = "alnwoks.com"
}
variable "zone_id" {
  type    = string
  default = "Z2ES7B9AZ6SHAE"
}
variable "staticwebsiterole" {
  type    = string
  default = "websitereader"
}

