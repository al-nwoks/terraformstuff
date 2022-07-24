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

variable "iamrolearn" {
  type    = string
  default = "arn:aws:iam::372287445072:role/s3read"
}