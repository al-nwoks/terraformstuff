variable "aws_region" {
  type = string
  default = "us-east-1"
}
variable "category" {
  type = string
  default = "StaticWebsiteDemo"
}

variable "s3name" {
  type    = string
  default = "kaye-staticwebsite"
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
  default = "arn:aws:iam::372287445072:role/s3read"
}

variable "acmcertificatearn" {
  type    = string
  default = "arn:aws:acm:us-east-1:372287445072:certificate/42996f31-4960-42d1-ae47-91a19c0f76db"
}