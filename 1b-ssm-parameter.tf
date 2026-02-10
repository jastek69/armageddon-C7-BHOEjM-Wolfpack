# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter

# locals {
#   db_endpoint=aws_db_instance.lab-mysql.endpoint
#   db_port=aws_db_instance.lab-mysql.port
#   db_name=aws_db_instance.lab-mysql.db_name
# }


# resource "aws_ssm_parameter" "db-endpoint-parameter-1b" {
#   name        = "/armageddon/1b/database/endpoint"
#   description = "DB Endpoint"
#   type        = "SecureString"
#   value       = local.db_endpoint

#   tags = {
#     environment = "armageddon"
#   }
# }

# resource "aws_ssm_parameter" "db-port-parameter-1b" {
#   name        = "/armageddon/1b/database/port"
#   description = "DB Port"
#   type        = "String"
#   value       = local.db_port

#   tags = {
#     environment = "armageddon"
#   }
# }

# resource "aws_ssm_parameter" "db-name-parameter-1b" {
#   name        = "/armageddon/1b/database/name"
#   description = "DB Name"
#   type        = "String"
#   value       = local.db_name
#   tags = {
#     environment = "armageddon"
#   }
# }


variable "db_parameters_for_ssm_parameter" {
  description = "Database parameters stored in SSM Parameter Store"
  type        = map(string)
  default = {
    endpoint = "lab-mysql.c23c4ck0msxh.us-east-1.rds.amazonaws.com"
    port     = "3306"
    name     = "lab-mysql"
  }
}

# Source - https://stackoverflow.com/a
# Posted by Marko E, modified by community. See post 'Timeline' for change history
# Retrieved 2026-01-11, License - CC BY-SA 4.0

resource "aws_ssm_parameter" "db-parameters-for-1b" {
  for_each = var.db_parameters_for_ssm_parameter
  name     = "/armageddon/1b/database/${each.key}"
  type     = "SecureString"
  value    = each.value
}

resource "aws_iam_role_policy_attachment" "AmazonSSMManagedInstanceCore_policy_attachment" {
  role       = aws_iam_role.ec2-to-secretsmanager-rolev2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}