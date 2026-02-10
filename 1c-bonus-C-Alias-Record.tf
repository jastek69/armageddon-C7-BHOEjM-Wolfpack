#Continue bonus_b_route53.tf — ALIAS record app → ALB

############################################
# ALIAS record: app.chewbacca-growl.com -> ALB
############################################

# Explanation: This is the holographic sign outside the cantina—app.chewbacca-growl.com points to your ALB.
resource "aws_route53_record" "maximus_app_alias01" {
  zone_id = local.dns_zone_id
  name    = local.dns_app_fqdn
  type    = "A"

  alias {
    name                   = aws_lb.web_tier_alb01.dns_name
    zone_id                = aws_lb.web_tier_alb01.zone_id
    evaluate_target_health = true
  }
}

# Add outputs (append to outputs.tf)
# Explanation: Outputs are the nav computer readout—Chewbacca needs coordinates that humans can paste into browsers.
output "maximus_route53_zone_id" {
  value = local.dns_zone_id
}

output "maximus_app_url_https" {
  value = "https://${var.app_subdomain}.${var.domain_name}"
}

output "app_url_website_url-1" {
  value = "http://${var.app_subdomain}.${var.domain_name}/list"
}

output "app_url_ip_address-1-init" {
  value = "http://${var.app_subdomain}.${var.domain_name}/init"
}

output "app_url_ip_address-1-add-note" {
  value = "http://${var.app_subdomain}.${var.domain_name}/add?note=first_note"
}