#https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password
resource "random_password" "rds_password" {
  length  = 8
  lower   = true
  upper   = true
  numeric = true
  special = false
}

output "rds_password" {
  value     = random_password.rds_password.result
  sensitive = true #Just a test
}