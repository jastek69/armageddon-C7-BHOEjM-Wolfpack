############################################
# RDS Instance (MySQL)
############################################

# Explanation: This is the holocron of state—your relational data lives here, not on the EC2.
resource "aws_db_instance" "lab1c_rds" {

  identifier        = "${local.name_prefix}-rds"
  engine            = var.db_engine
  engine_version    = "8.4.7"
  instance_class    = var.db_instance_class
  allocated_storage = 20
  db_name           = var.db_name
  username          = var.db_username
  password          = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.lab1c_rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.lab1c_rds_sg.id]

  publicly_accessible = false
  skip_final_snapshot = true
  multi_az            = false

  # TODO: student sets multi_az / backups / monitoring as stretch goals

  tags = {
    Name = "${local.name_prefix}-rds"
  }
}
