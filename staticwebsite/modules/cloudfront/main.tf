resource "aws_cloudfront_distribution" "staticwebsite-distribution" {
  enabled             = false
  aliases             = [ "www.codeninja.com","codeninja.com" ] #this is the URL
  default_root_object = "index.html"

  origin {
    
    domain_name = "${var.s3regionaldomainname}"
    origin_id   = "${var.s3regionaldomainname}"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.staticwebsite-oai.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    allowed_methods         = ["GET","HEAD"]
    cached_methods          = ["GET","HEAD"]
    target_origin_id        = "${var.s3regionaldomainname}"
    viewer_protocol_policy  = "allow-all" #"redirect-to-https"

    forwarded_values {
      headers       = []
      query_string  = true
      
      cookies {
        forward     = "all"
      }
    }
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = "${var.acmcertificatearn}"
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
  custom_error_response {
    error_caching_min_ttl = 10
    error_code = 403
    response_page_path = "/index.html"
    response_code = 200
  }

  custom_error_response {
    error_code = 404
    response_page_path = "/index.html"
    response_code = 200
  }

  tags = {
    Category        = var.category
  }
}

resource "aws_cloudfront_origin_access_identity" "staticwebsite-oai" {
  comment = "OAI for ${var.s3name}"
}
