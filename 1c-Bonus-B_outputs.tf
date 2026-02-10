# Explanation: Outputs are the mission coordinates — where to point your browser and your blasters.
output "alb_dns_name" {
  value = aws_lb.web_tier_alb01.dns_name
}

output "app_fqdn" {
  value = "${var.app_subdomain}.${var.domain_name}"
}

output "target_group_arn" {
  value = aws_lb_target_group.web_tier_tg01.arn
}

output "acm_cert_arn" {
  value = aws_acm_certificate.domain_acm_cert01.arn
}

output "waf_arn" {
  value = var.enable_waf ? aws_wafv2_web_acl.alb_waf01[0].arn : null
}

output "dashboard_name" {
  value = aws_cloudwatch_dashboard.cloudwatch_dashboard01.dashboard_name
}


output "dns_ip_address-1-list" {
  value = "http://${aws_lb.web_tier_alb01.dns_name}/list"
}