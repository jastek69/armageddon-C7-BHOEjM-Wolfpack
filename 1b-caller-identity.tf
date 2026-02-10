#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity
data "aws_caller_identity" "current_self01" {}

# output "account_id" {
#   value = data.aws_caller_identity.current_self01.account_id
# }

# output "caller_arn" {
#   value = data.aws_caller_identity.current_self01.arn
# }

# output "caller_user" {
#   value = data.aws_caller_identity.current_self01.user_id
# }
