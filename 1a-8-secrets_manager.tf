#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret
resource "aws_secretsmanager_secret" "lab1a-rds-mysql-v36" {
  name = "lab1a-rds-mysql-v36"
  #region = "us-east-1" #not needed because of the default provider region
}

# The map here can come from other supported configurations
# like locals, resource attribute, map() built-in, etc.
# variable "rds_credentials" {
#   default = {
#     username = aws_db_instance.lab-mysql.username #Variables may not be used here.
#     password = random_password.rds_password.result
#     host     = aws_db_instance.lab-mysql.address
#     port     = aws_db_instance.lab-mysql.port
#     db_name  = aws_db_instance.lab-mysql.db_name
#   }

#   type = map(string)
# }

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version
resource "aws_secretsmanager_secret_version" "lab1a-rds-mysql-version" {
  secret_id = aws_secretsmanager_secret.lab1a-rds-mysql-v36.id
  # secret_string = jsonencode(var.rds_credentials) #May have to hardcode variable.
  secret_string = jsonencode({
    username = aws_db_instance.lab-mysql.username
    password = random_password.rds_password.result
    host     = aws_db_instance.lab-mysql.address
    port     = aws_db_instance.lab-mysql.port
    db_name  = aws_db_instance.lab-mysql.db_name
  })
}

#This resulted in replaceing the imported secret being replaced with a new name and a new ARN
# import {
#   to = aws_secretsmanager_secret.lab1a-rds-mysql-v1
#   identity = {
#     "arn" = "arn:aws:secretsmanager:us-east-1:314146336018:secret:lab1a-rds-mysql-6pN6va"
#   }
# }

#Alternative import syntax: In Terraform v1.5.0 and later, use an import block to import aws_secretsmanager_secret using the secret Amazon Resource Name (ARN). For example:
# import {
#   to = aws_secretsmanager_secret.lab1a-rds-mysql-v1
#   id = "arn:aws:secretsmanager:us-east-1:314146336018:secret:lab1a-rds-mysql-6pN6va"
# }

#Using terraform import, import aws_secretsmanager_secret using the secret Amazon Resource Name (ARN). For example:
#% terraform import aws_secretsmanager_secret.lab1a-rds-mysql-v1 arn:aws:secretsmanager:us-east-1:314146336018:secret:lab1a-rds-mysql-6pN6va

output "lab1a-rds-mysql-arn" {
  value = aws_secretsmanager_secret.lab1a-rds-mysql-v36.arn
}
