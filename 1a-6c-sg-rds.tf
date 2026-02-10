
# for RDS 
#ALB SD ID goes here (ALB is the source of HTTP traffic for web APPS)
resource "aws_security_group" "sql_database" {
  name        = "allow_port_for_rds"
  description = "Allow access to RDS"
  vpc_id      = aws_vpc.app1-vpc-b-ny.id
  # <resource type>.<resource local name>.<attribute type>

  tags = {
    Name = "allow_access-RDS"
  }
}


# resource "aws_vpc_security_group_ingress_rule" "web_load_balancer_allow_http" {
#   security_group_id = aws_security_group.web_load_balancer.id

#   cidr_ipv4   = "0.0.0.0/0"
#   from_port   = 80
#   ip_protocol = "tcp"
#   to_port     = 80
# }


resource "aws_vpc_security_group_ingress_rule" "sql_database_allow_ec2_web_tier_sg" {
  security_group_id = aws_security_group.sql_database.id

  referenced_security_group_id = aws_security_group.web_tier_ec2_sg01.id
  from_port                    = 3306
  ip_protocol                  = "tcp"
  to_port                      = 3306
}

resource "aws_vpc_security_group_egress_rule" "sql_database_allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.sql_database.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" #semantically equivalent to all ports
}