############################################
# Security Groups (EC2 + RDS)
############################################

# Explanation: EC2 SG is lab1c’s bodyguard—only let in what you mean to.
resource "aws_security_group" "lab1c_ec2_sg" {
  name        = "${local.name_prefix}-ec2-sg"
  description = "EC2 app security group"
  vpc_id      = aws_vpc.lab1c_vpc.id

#   ingress {
#     description = "Allow HTTP"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "Allow SSH from my IP"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     description = "Allow all outbound"
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   # TODO: student adds inbound rules (HTTP 80, SSH 22 from their IP)
#   # TODO: student ensures outbound allows DB port to RDS SG (or allow all outbound)

#   tags = {
#     Name = "${local.name_prefix}-ec2-sg"
#   }
}

# Explanation: RDS SG is the Rebel vault—only the app server gets a keycard.
resource "aws_security_group" "lab1c_rds_sg" {
  name        = "${local.name_prefix}-rds-sg"
  description = "RDS security group"
  vpc_id      = aws_vpc.lab1c_vpc.id

  ingress {
    description     = "Allow MySQL from EC2 only"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.lab1c_ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # TODO: student adds inbound MySQL 3306 from aws_security_group.lab1c_ec2_sg01.id

  tags = {
    Name = "${local.name_prefix}-rds-sg"
  }
}

############################################
# Security Group for VPC Interface Endpoints
############################################
resource "aws_security_group" "lab1c_vpce_sg" {
  name        = "${local.name_prefix}-vpce-sg"
  description = "SG for VPC Interface Endpoints"
  vpc_id      = aws_vpc.lab1c_vpc.id

  # TODO: Students must allow inbound 443 FROM the EC2 SG (or VPC CIDR) to endpoints.
  # NOTE: Interface endpoints ENIs receive traffic on 443.

  tags = {
    Name = "${local.name_prefix}-vpce-sg"
  }
}
