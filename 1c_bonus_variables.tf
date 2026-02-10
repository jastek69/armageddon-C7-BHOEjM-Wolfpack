variable "domain_name" {
  description = "Base domain students registered (e.g., madibamaximus.click)."
  type        = string
  default     = "madibamaximus.click"
}

variable "app_subdomain" {
  description = "App hostname prefix (e.g., app.madibamaximus.click)."
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

#variables for ALB access logs for S3 bucket 
variable "enable_alb_access_logs" {
  description = "Toggle ALB access logging to S3."
  type        = bool
  default     = true
}

variable "alb_access_logs_prefix" {
  description = "S3 prefix for ALB access logs."
  type        = string
  default     = "armageddon-alb-access-logs"
}

#I added
variable "waf_log_destination" {
  description = "Choose WAF log destination: 'cloudwatch' or 's3'."
  type        = string
  default     = "cloudwatch"


}

#I added
variable "waf_log_retention_days" {
  description = "Retention period for WAF logs in CloudWatch (if using CloudWatch)."
  type        = number
  default     = 30
}

#I added
variable "manage_route53_in_terraform" {
  description = "Whether to manage Route53 zone in Terraform."
  type        = bool
  default     = false #don't manage in terraform since we are using the dns lab and it creates a zone for us, but students can set to true if they want to create and manage the zone in terraform instead of using the one from the dns lab.
}

variable "route53_hosted_zone_id" {
  description = "Pre-existing Route53 hosted zone ID (if not managing in Terraform)."
  type        = string
  default     = "Z03960566UZQZIZPHD3F"
  #default = "Z06224832VMX6OHD8CBJ" #was created by terraform
}