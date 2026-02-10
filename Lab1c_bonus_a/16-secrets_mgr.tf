############################################
# Secrets Manager (DB Credentials)
############################################

# Explanation: Secrets Manager is lab1c’s locked holster—credentials go here, not in code.
resource "aws_secretsmanager_secret" "lab1c_db_secret" {
  name = "${local.name_prefix}/rds/mysql_v14"
}

# Explanation: Secret payload—students should align this structure with their app (and support rotation later).
resource "aws_secretsmanager_secret_version" "lab1c_db_secret_version" {
  secret_id = aws_secretsmanager_secret.lab1c_db_secret.id

  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
    host     = aws_db_instance.lab1c_rds.address
    port     = aws_db_instance.lab1c_rds.port
    dbname   = var.db_name
  })
}