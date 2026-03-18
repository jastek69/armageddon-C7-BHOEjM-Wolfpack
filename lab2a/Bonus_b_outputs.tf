# Explanation: Outputs are the mission coordinates — where to point your browser and your blasters.
output "lab1c_alb_dns_name" {
  value = aws_lb.lab1c_alb01.dns_name
}

output "lab1c_app_fqdn" {
  value = "${var.app_subdomain}.${var.domain_name}"
}

output "lab1c_target_group_arn" {
  value = aws_lb_target_group.lab1c_tg01.arn
}

output "lab1c_acm_cert_arn" {
  value = aws_acm_certificate.lab1c_acm_cert01.arn
}

output "lab1c_waf_arn" {
  value = var.enable_waf ? aws_wafv2_web_acl.lab1c_waf01[0].arn : null
}

output "lab1c_dashboard_name" {
  value = aws_cloudwatch_dashboard.lab1c_dashboard01.dashboard_name
}

output "lab1c_route53_zone_id" { 
  value = local.lab1c_zone_id 
}

output "lab1c_app_url_https" { 
  value = "https://${var.app_subdomain}.${var.domain_name}" 
}

