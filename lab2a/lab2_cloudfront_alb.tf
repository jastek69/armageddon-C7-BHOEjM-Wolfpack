# Explanation: CloudFront is the only public doorway — lab2a stands behind it with private infrastructure.
resource "aws_cloudfront_distribution" "lab2a_cf01" {
  depends_on = [
  aws_s3_bucket_ownership_controls.lab2a_cf_logs_owner01,
  aws_s3_bucket_acl.lab2a_cf_logs_acl01,
  aws_s3_bucket_public_access_block.lab2a_cf_logs_pab01
]
  enabled         = true
  is_ipv6_enabled = true
  comment         = "${var.project_name}-cf01"

logging_config {
  include_cookies = false
  bucket          = aws_s3_bucket.lab2a_cf_logs.bucket_domain_name
  prefix          = "cloudfront/"
}


  origin {
    origin_id   = "${var.project_name}-alb-origin01"
    domain_name = aws_lb.lab1c_alb01.dns_name

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }

    # Explanation: CloudFront whispers the secret growl — the ALB only trusts this.
    custom_header {
      name  = "XIX-aster-project"
      value = random_password.lab2a_origin_header_value01.result
    }
  }

  default_cache_behavior {
    target_origin_id       = "${var.project_name}-alb-origin01"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods  = ["GET", "HEAD"]

    # TODO: students choose cache policy / origin request policy for their app type
    # For APIs, typically forward all headers/cookies/querystrings.
    forwarded_values {
      query_string = true
      headers      = ["*"]
      cookies { forward = "all" }
    }
  }

  # Explanation: Attach WAF at the edge — now WAF moved to CloudFront.
  web_acl_id = aws_wafv2_web_acl.lab2a_cf_waf01.arn

  # TODO: students set aliases for lab2a-growl.com and app.lab2a-growl.com
  aliases = [
    var.domain_name,
    "${var.app_subdomain}.${var.domain_name}"
  ]

  # TODO: students must use ACM cert in us-east-1 for CloudFront
  viewer_certificate {

    acm_certificate_arn      = aws_acm_certificate.lab2a_cf_cert01.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}
resource "aws_acm_certificate" "lab2a_cf_cert01" {
  provider          = aws.use1
  domain_name       = var.domain_name
  validation_method = "DNS"

  subject_alternative_names = [
    "${var.app_subdomain}.${var.domain_name}"
  ]

  tags = {
    Name = "${var.project_name}-cf-cert01"
  }
}

resource "aws_s3_bucket" "lab2a_cf_logs" {
  bucket = "${var.project_name}-cf-logs-${data.aws_caller_identity.lab1c_self01.account_id}"
}

resource "aws_s3_bucket_ownership_controls" "lab2a_cf_logs_owner01" {
  bucket = aws_s3_bucket.lab2a_cf_logs.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "lab2a_cf_logs_acl01" {
  depends_on = [aws_s3_bucket_ownership_controls.lab2a_cf_logs_owner01]
  bucket     = aws_s3_bucket.lab2a_cf_logs.id
  acl        = "private"
}

resource "aws_s3_bucket_public_access_block" "lab2a_cf_logs_pab01" {
  bucket = aws_s3_bucket.lab2a_cf_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# #You’ll need this variable:
# variable "cloudfront_acm_cert_arn" {
#   description = "ACM certificate ARN in us-east-1 for CloudFront (covers lab2a-growl.com and app.lab2a-growl.com)."
#   type        = string
# }

