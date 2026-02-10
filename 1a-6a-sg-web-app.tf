
# for ASG EC2 instances
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
resource "aws_security_group" "web_tier_ec2_sg01" {
  name        = "allow_http_ssh_web_app"
  description = "Allow inbound HTTP and SSH for web apps in web tier"
  vpc_id      = aws_vpc.app1-vpc-b-ny.id
  # <resource type>.<resource local name>.<attribute type>

  tags = {
    Name = "allow_http_ssh_web_app"
  }
}


resource "aws_vpc_security_group_ingress_rule" "web_tier_allow_http" {
  security_group_id = aws_security_group.web_tier_ec2_sg01.id
  # #ALB SD ID goes here (ALB is the source of HTTP traffic for web APPS)
  cidr_ipv4 = "0.0.0.0/0" #testing of public instance
  #referenced_security_group_id = aws_security_group.web_load_balancer_alb_sg01.id

  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}
#Duplicated ALB to EC2 security group in 1c-bonus-b.tf

resource "aws_vpc_security_group_ingress_rule" "web_tier_allow_https" {
  security_group_id = aws_security_group.web_tier_ec2_sg01.id
  # #ALB SD ID goes here (ALB is the source of HTTP traffic for web APPS)
  #cidr_ipv4 = "0.0.0.0/0"
  referenced_security_group_id = aws_security_group.web_load_balancer_alb_sg01.id

  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule
#Disable SSH access for better security posture for 1c
# resource "aws_vpc_security_group_ingress_rule" "web_tier_allow_ssh" {
#   security_group_id = aws_security_group.web_tier_ec2_sg01.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 22
#   ip_protocol       = "tcp"
#   to_port           = 22
# }

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule
resource "aws_vpc_security_group_egress_rule" "web_tier_egress" {
  security_group_id = aws_security_group.web_tier_ec2_sg01.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

############################ SG for ping 
resource "aws_security_group" "ping" {
  name        = "ping"
  description = "Allow icmp for ping"
  vpc_id      = aws_vpc.app1-vpc-b-ny.id

  tags = {
    Name = "icmp-for-ping"
  }
}

resource "aws_vpc_security_group_ingress_rule" "icmp" {
  security_group_id = aws_security_group.ping.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = -1
  ip_protocol = "icmp"
  to_port     = -1
}

resource "aws_vpc_security_group_egress_rule" "egress_for_ping" {
  security_group_id = aws_security_group.ping.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}