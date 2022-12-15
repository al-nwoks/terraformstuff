variable "category" {
  type = string
}
variable "s3name" {
  type    = string
}
variable "s3arn" {
  type    = string
}
variable "iamrolearn" {
  type    = string
}

variable "cloudfrontoaiarn" {
  type = string
  default = "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity EU2IZEGACPVHL"
}