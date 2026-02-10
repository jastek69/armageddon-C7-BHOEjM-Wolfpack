############################################
# VPC Endpoint - S3 (Gateway)
############################################

# Explanation: S3 is the supply depot—without this, your private world starves (updates, artifacts, logs).
resource "aws_vpc_endpoint" "lab1c_vpce_s3_gw" {
  vpc_id            = aws_vpc.lab1c_vpc.id
  service_name      = "com.amazonaws.${data.aws_region.lab1c_region.region}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.lab1c_private_rt.id
  ]

  tags = {
    Name = "${local.name_prefix}-vpce-s3-gw"
  }
}
############################################
# VPC Endpoints - SSM (Interface)
############################################

# Explanation: SSM is your Force choke—remote control without SSH, and nobody sees your keys.
resource "aws_vpc_endpoint" "lab1c_vpce_ssm" {
  vpc_id              = aws_vpc.lab1c_vpc.id
  service_name        = "com.amazonaws.${data.aws_region.lab1c_region.region}.ssm"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = aws_subnet.lab1c_private_subnets[*].id
  security_group_ids = [aws_security_group.lab1c_vpce_sg.id]

  tags = {
    Name = "${local.name_prefix}-vpce-ssm"
  }
}
# Explanation: ec2messages is the Wookiee messenger—SSM sessions won’t work without it.
resource "aws_vpc_endpoint" "lab1c_vpce_ec2messages" {
  vpc_id              = aws_vpc.lab1c_vpc.id
  service_name        = "com.amazonaws.${data.aws_region.lab1c_region.region}.ec2messages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = aws_subnet.lab1c_private_subnets[*].id
  security_group_ids = [aws_security_group.lab1c_vpce_sg.id]

  tags = {
    Name = "${local.name_prefix}-vpce-ec2messages"
  }
}
# Explanation: ssmmessages is the holonet channel—Session Manager needs it to talk back.
resource "aws_vpc_endpoint" "lab1c_vpce_ssmmessages" {
  vpc_id              = aws_vpc.lab1c_vpc.id
  service_name        = "com.amazonaws.${data.aws_region.lab1c_region.region}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = aws_subnet.lab1c_private_subnets[*].id
  security_group_ids = [aws_security_group.lab1c_vpce_sg.id]

  tags = {
    Name = "${local.name_prefix}-vpce-ssmmessages"
  }
}
############################################
# VPC Endpoint - CloudWatch Logs (Interface)
############################################

# Explanation: CloudWatch Logs is the ship’s black box—Chewbacca wants crash data, always.
resource "aws_vpc_endpoint" "lab1c_vpce_logs" {
  vpc_id              = aws_vpc.lab1c_vpc.id
  service_name        = "com.amazonaws.${data.aws_region.lab1c_region.region}.logs"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = aws_subnet.lab1c_private_subnets[*].id
  security_group_ids = [aws_security_group.lab1c_vpce_sg.id]

  tags = {
    Name = "${local.name_prefix}-vpce-logs"
  }
}
############################################
# VPC Endpoint - Secrets Manager (Interface)
############################################

# Explanation: Secrets Manager is the locked vault—Chewbacca doesn’t put passwords on sticky notes.
resource "aws_vpc_endpoint" "lab1c_vpce_secrets" {
  vpc_id              = aws_vpc.lab1c_vpc.id
  service_name        = "com.amazonaws.${data.aws_region.lab1c_region.region}.secretsmanager"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = aws_subnet.lab1c_private_subnets[*].id
  security_group_ids = [aws_security_group.lab1c_vpce_sg.id]

  tags = {
    Name = "${local.name_prefix}-vpce-secrets"
  }
}