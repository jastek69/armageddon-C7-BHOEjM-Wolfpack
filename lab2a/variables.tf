variable "aws_region" {
  description = "AWS Region for lab1c build."
  type        = string
  default     = "us-east-2"
}

variable "project_name" {
  description = "Armageddon."
  type        = string
  default     = "lab2a"
}

variable "vpc_cidr" {
  description = "VPC CIDR (use 10.x.x.x/xx as instructed)."
  type        = string
  default     = "10.238.0.0/16" # TODO: student supplies
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs (use 10.x.x.x/xx)."
  type        = list(string)
  default     = ["10.238.1.0/24", "10.238.2.0/24","10.238.3.0/24" ] # TODO: student supplies
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs (use 10.x.x.x/xx)."
  type        = list(string)
  default     = ["10.238.11.0/24", "10.238.12.0/24", "10.238.13.0/24"] # TODO: student supplies
}

variable "azs" {
  description = "Availability Zones list (match count with subnets)."
  type        = list(string)
  default     = ["us-east-2a", "us-east-2b","us-east-2c" ] # TODO: student supplies
}

variable "ec2_ami_id" {
  description = "AMI ID for the EC2 app host."
  type        = string
  default     = "ami-0276d84182b995d5b" # TODO
}

variable "ec2_instance_type" {
  description = "EC2 instance size for the app."
  type        = string
  default     = "t3.micro"
}

variable "db_engine" {
  description = "RDS engine."
  type        = string
  default     = "mysql"
}

variable "db_instance_class" {
  description = "RDS instance class."
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Initial database name."
  type        = string
  default     = "lab1cdb" # Students can change
}

variable "db_username" {
  description = "DB master username (students should use Secrets Manager in 1B/1C)."
  type        = string
  default     = "admin" # TODO: student supplies
}

variable "db_password" {
  description = "DB master password (DO NOT hardcode in real life; for lab only)."
  type        = string
  sensitive   = true
  default     = "lab1cpassworD" # TODO: student supplies
}

variable "sns_email_endpoint" {
  description = "Email for SNS subscription (PagerDuty simulation)."
  type        = string
  default     = "cjjamieson1983@gmail.com" # TODO: student supplies
}
variable "domain_name" {
  description = "Base domain students registered (e.g., lab1c-growl.com)."
  type        = string
  default     = "aster-project.site"
}

variable "app_subdomain" {
  description = "App hostname prefix (e.g., app.chewbacca-growl.com)."
  type        = string
  default     = "app"
}

variable "certificate_validation_method" {
  description = "ACM validation method. Students can do DNS (Route53) or EMAIL."
  type        = string
  default     = "DNS"
}

variable "enable_waf" {
  description = "Toggle WAF creation."
  type        = bool
  default     = true
}

variable "alb_5xx_threshold" {
  description = "Alarm threshold for ALB 5xx count."
  type        = number
  default     = 10
}

variable "alb_5xx_period_seconds" {
  description = "CloudWatch alarm period."
  type        = number
  default     = 300
}

variable "alb_5xx_evaluation_periods" {
  description = "Evaluation periods for alarm."
  type        = number
  default     = 1
}
variable "manage_route53_in_terraform" {
  description = "If true, create/manage the Route53 hosted zone in Terraform. If false, use an existing hosted zone id."
  type        = bool
  default     = true
}

variable "route53_hosted_zone_id" {
  description = "Existing Route53 hosted zone ID to use when manage_route53_in_terraform is false."
  type        = string
  default     = "Z1033674DW5XVXLEFOS2"
}
variable "enable_alb_access_logs" {
  description = "Whether to enable ALB access logs"
  type        = bool
  default     = true
}

variable "alb_access_logs_prefix" {
  description = "Prefix within the ALB access logs bucket to store logs"
  type        = string
  default     = "alb-access-logs"
}

# variable "waf_log_destination" {
#   description = "List of ARNs where AWS WAF logs should be delivered (e.g., CloudWatch Log Group ARN or Kinesis Firehose ARN)"
#   type        = list(string)
#   default     = []
# }

variable "waf_log_destination" { 
  description = "Choose ONE destination per WebACL: cloudwatch | s3 | firehose" 
  type = string 
  default = "s3"
   }

variable "waf_log_retention_days" { 
  description = "Retention for WAF CloudWatch log group." 
  type = number 
  default = 14 
    }

variable "enable_waf_sampled_requests_only" { 
  description = "If true, students can optionally filter/redact fields later. (Placeholder toggle.)" 
  type = bool 
  default = false 
  }

variable "cloudfront_acm_cert_arn" {
  description = "ACM certificate ARN in us-east-1 for CloudFront (covers aster-project.site and app.aster-project.site)."
  type        = string
}