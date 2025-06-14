resource "aws_cloudfront_distribution" "log_enabled" {
  origin {
    domain_name = "testing-bucket-for-logs-123.s3.amazonaws.com"
    origin_id   = "origin1"
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront with S3 logging"
  default_root_object = "index.html"

  default_cache_behavior {
    target_origin_id       = "origin1"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]

    cached_methods = ["GET", "HEAD"]

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  logging_config {
    include_cookies = false
    bucket          = "testing-bucket-for-logs-123.s3.amazonaws.com"
    prefix          = "cloudfront-logs/"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
