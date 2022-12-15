
resource "aws_s3_bucket_policy" "staticwebsite-s3bucketpolicy" {
  bucket = "${var.s3name}"
  policy = data.aws_iam_policy_document.staticwebsite-s3bucketpolicydata.json
}

data "aws_iam_policy_document" "staticwebsite-s3bucketpolicydata" {
  statement {
    sid = "ReadObject"
    principals {
      type        = "AWS"
      identifiers = ["${var.iamrolearn}"]
    }
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
      "${var.s3arn}",
      "${var.s3arn}/*"
    ]
  }
  statement {
    sid = "CloudFrontAccess"
    principals {
      type        = "AWS"
      identifiers = ["${var.cloudfrontoaiarn}"]
    }
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
      "${var.s3arn}",
      "${var.s3arn}/*"
    ]
  }
}
