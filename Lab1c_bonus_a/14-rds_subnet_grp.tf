############################################
# RDS Subnet Group
############################################

# Explanation: RDS hides in private subnets like the Rebel base on Hoth—cold, quiet, and not public.
resource "aws_db_subnet_group" "lab1c_rds_subnet_group" {
  name       = "${local.name_prefix}-rds-subnet-group"
  subnet_ids = aws_subnet.lab1c_private_subnets[*].id

  tags = {
    Name = "${local.name_prefix}-rds-subnet-group"
  }
}

