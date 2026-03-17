############################################
# Bonus B - Route53 Zone Apex + ALB Access Logs to S3
############################################

############################################
# Route53: Zone Apex (root domain) -> ALB
############################################

# Explanation: The zone apex is the throne room—lab1c-growl.com itself should lead to the ALB.
resource "aws_route53_record" "lab1c_apex_alias01" {
  zone_id = local.lab1c_zone_id
  name = "app.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.lab1c_alb01.dns_name
    zone_id                = aws_lb.lab1c_alb01.zone_id
    evaluate_target_health = true
  }
}

############################################
# S3 bucket for ALB access logs
############################################

# Explanation: This bucket is lab1c’s log vault—every visitor to the ALB leaves footprints here.
resource "aws_s3_bucket" "lab1c_alb_logs_bucket01" {
  count = var.enable_alb_access_logs ? 1 : 0

  bucket = "${var.project_name}-alb-logs-${data.aws_caller_identity.lab1c_self01.account_id}"

  tags = {
    Name = "${var.project_name}-alb-logs-bucket01"
  }
}

# Explanation: Block public access—lab1c does not publish the ship’s black box to the galaxy.
resource "aws_s3_bucket_public_access_block" "lab1c_alb_logs_pab01" {
  count = var.enable_alb_access_logs ? 1 : 0

  bucket                  = aws_s3_bucket.lab1c_alb_logs_bucket01[0].id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Explanation: Bucket ownership controls prevent log delivery chaos—lab1c likes clean chain-of-custody.
resource "aws_s3_bucket_ownership_controls" "lab1c_alb_logs_owner01" {
  count = var.enable_alb_access_logs ? 1 : 0

  bucket = aws_s3_bucket.lab1c_alb_logs_bucket01[0].id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# Explanation: TLS-only—lab1c growls at plaintext and throws it out an airlock.
resource "aws_s3_bucket_policy" "lab1c_alb_logs_policy01" {
  count = var.enable_alb_access_logs ? 1 : 0

  bucket = aws_s3_bucket.lab1c_alb_logs_bucket01[0].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "DenyInsecureTransport"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.lab1c_alb_logs_bucket01[0].arn,
          "${aws_s3_bucket.lab1c_alb_logs_bucket01[0].arn}/*"
        ]
        Condition = {
          Bool = { "aws:SecureTransport" = "false" }
        }
      },
      {
        Sid    = "AllowALBLogDelivery"
        Effect = "Allow"
        Principal = {
          Service = "logdelivery.elasticloadbalancing.amazonaws.com"
        }
        Action   = "s3:PutObject"
        Resource = "${aws_s3_bucket.lab1c_alb_logs_bucket01[0].arn}/${var.alb_access_logs_prefix}/AWSLogs/${data.aws_caller_identity.lab1c_self01.account_id}/*"
      }
    ]
  })
}

###########################################
# Enable ALB access logs (on the ALB resource)
# ###########################################

# Explanation: Turn on access logs—lab1c wants receipts when something goes wrong.
# NOTE: This is a skeleton patch: students must merge this into aws_lb.lab1c_alb01
# by adding/accessing the `access_logs` block. Terraform does not support "partial" blocks.

# Add this inside resource "aws_lb" "lab1c_alb01" { ... } in bonus_b.tf:

# access_logs {
#   bucket  = aws_s3_bucket.lab1c_alb_logs_bucket01[0].bucket
#   prefix  = var.alb_access_logs_prefix
#   enabled = var.enable_alb_access_logs
# }