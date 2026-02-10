#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance
resource "aws_db_instance" "lab-mysql" {
  allocated_storage = 5
  db_name           = "labmysql"

  engine                      = "mysql"
  engine_version              = "8.4"
  allow_major_version_upgrade = true #The AllowMajorVersionUpgrade flag must be present when upgrading to a new major version.
  identifier                  = "lab-mysql"
  instance_class              = "db.t3.micro"
  #   manage_master_user_password = true #You can specify the manage_master_user_password attribute to enable managing the master password with Secrets Manager.
  username = "admin"
  password = random_password.rds_password.result #Conflicts with manage_master_user_password

  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.sql_database.id]
  db_subnet_group_name   = aws_db_subnet_group.RDS-subnet-group.name #specifying the VPC through its subnets
  publicly_accessible    = false                                     #This is the default value
  multi_az               = true
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group
resource "aws_db_subnet_group" "RDS-subnet-group" {
  name       = "lab-mysql-subnet-group"
  subnet_ids = [aws_subnet.private-us-east-1a.id, aws_subnet.private-us-east-1b.id, aws_subnet.private-us-east-1c.id]

  tags = {
    Name = "My DB subnet group"
  }
}