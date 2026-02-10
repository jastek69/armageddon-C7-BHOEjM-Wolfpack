############################################
# Bonus A - Data + Locals
############################################

# Explanation: Chewbacca wants to know “who am I in this galaxy?” so ARNs can be scoped properly.
#data "aws_caller_identity" "current_self01" {} #1b-caller-identity.tf called current_self01

# Explanation: Region matters—hyperspace lanes change per sector.
data "aws_region" "current_region01" {}

locals {
  # Explanation: Name prefix is the roar that echoes through every tag.
  armageddon_prefix = local.project_name

  # TODO: Students should lock this down after apply using the real secret ARN from outputs/state
  secret_arn_guess = "arn:aws:secretsmanager:${data.aws_region.current_region01.name}:${data.aws_caller_identity.current_self01.account_id}:secret:${local.armageddon_prefix}/rds/mysql*"
}
#This is already file 1a-8-secrets_manager.tf

############################################
# Move EC2 into PRIVATE subnet (no public IP)
############################################

# Explanation: Chewbacca hates exposure—private subnets keep your compute off the public holonet.
resource "aws_instance" "ec201_private_bonus" {
  ami                    = var.ny_cidr_blocks[0].image_id
  instance_type          = var.ny_cidr_blocks[0].instance_type
  subnet_id              = aws_subnet.private-us-east-1a.id
  vpc_security_group_ids = [aws_security_group.web_tier_ec2_sg01.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  # TODO: Students should remove/disable SSH inbound rules entirely and rely on SSM.
  # TODO: Students add user_data that installs app + CW agent; for true hard mode use a baked AMI.
  user_data = file("lab-1b-with-cloudwatch-agent.sh")

  tags = {
    Name = "${local.armageddon_prefix}-ec201-private"
  }
}

############################################
# Security Group for VPC Interface Endpoints
############################################

# Explanation: Even endpoints need guards—Chewbacca posts a Wookiee at every airlock.
resource "aws_security_group" "endpoint_vpce_sg01" {
  name        = "${local.armageddon_prefix}-vpce-sg01"
  description = "SG for VPC Interface Endpoints"
  vpc_id      = aws_vpc.app1-vpc-b-ny.id

  # TODO: Students must allow inbound 443 FROM the EC2 SG (or VPC CIDR) to endpoints.
  # NOTE: Interface endpoints ENIs receive traffic on 443.


  tags = {
    Name = "${local.armageddon_prefix}-vpce-sg01"
  }
}

resource "aws_vpc_security_group_ingress_rule" "endpoint_vpce_sg01_allow_https" {
  security_group_id = aws_security_group.endpoint_vpce_sg01.id

  referenced_security_group_id = aws_security_group.web_tier_ec2_sg01.id
  #cidr_ipv4   = var.ny_cidr_blocks[0].cidr_block #alternatively allow from VPC CIDR
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}

############################################
# VPC Endpoint - S3 (Gateway)
############################################

# Explanation: S3 is the supply depot—without this, your private world starves (updates, artifacts, logs).
resource "aws_vpc_endpoint" "endpoint_vpce_s3_gw01" {
  vpc_id            = aws_vpc.app1-vpc-b-ny.id
  service_name      = "com.amazonaws.${data.aws_region.current_region01.name}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.private-NY.id
  ]

  tags = {
    Name = "${local.armageddon_prefix}-vpce-s3-gw01"
  }
}

############################################
# VPC Endpoints - SSM (Interface)
############################################

# Explanation: SSM is your Force choke—remote control without SSH, and nobody sees your keys.
resource "aws_vpc_endpoint" "endpoint_vpce_ssm01" {
  vpc_id              = aws_vpc.app1-vpc-b-ny.id
  service_name        = "com.amazonaws.${data.aws_region.current_region01.name}.ssm"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = [aws_subnet.private-us-east-1a.id, aws_subnet.private-us-east-1b.id, aws_subnet.private-us-east-1c.id]
  security_group_ids = [aws_security_group.endpoint_vpce_sg01.id]

  tags = {
    Name = "${local.armageddon_prefix}-vpce-ssm01"
  }
}

# Explanation: ec2messages is the Wookiee messenger—SSM sessions won’t work without it.
resource "aws_vpc_endpoint" "endpoint_vpce_ec2messages01" {
  vpc_id              = aws_vpc.app1-vpc-b-ny.id
  service_name        = "com.amazonaws.${data.aws_region.current_region01.name}.ec2messages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = [aws_subnet.private-us-east-1a.id, aws_subnet.private-us-east-1b.id, aws_subnet.private-us-east-1c.id]
  security_group_ids = [aws_security_group.endpoint_vpce_sg01.id]

  tags = {
    Name = "${local.armageddon_prefix}-vpce-ec2messages01"
  }
}

# Explanation: ssmmessages is the holonet channel—Session Manager needs it to talk back.
resource "aws_vpc_endpoint" "endpoint_vpce_ssmmessages01" {
  vpc_id              = aws_vpc.app1-vpc-b-ny.id
  service_name        = "com.amazonaws.${data.aws_region.current_region01.name}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = [aws_subnet.private-us-east-1a.id, aws_subnet.private-us-east-1b.id, aws_subnet.private-us-east-1c.id]
  security_group_ids = [aws_security_group.endpoint_vpce_sg01.id]

  tags = {
    Name = "${local.armageddon_prefix}-vpce-ssmmessages01"
  }
}

############################################
# VPC Endpoint - CloudWatch Logs (Interface)
############################################

# Explanation: CloudWatch Logs is the ship’s black box—Chewbacca wants crash data, always.
resource "aws_vpc_endpoint" "endpoint_vpce_logs01" {
  vpc_id              = aws_vpc.app1-vpc-b-ny.id
  service_name        = "com.amazonaws.${data.aws_region.current_region01.name}.logs"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = [aws_subnet.private-us-east-1a.id, aws_subnet.private-us-east-1b.id, aws_subnet.private-us-east-1c.id]
  security_group_ids = [aws_security_group.endpoint_vpce_sg01.id]

  tags = {
    Name = "${local.armageddon_prefix}-vpce-logs01"
  }
}

############################################
# VPC Endpoint - Secrets Manager (Interface)
############################################

# Explanation: Secrets Manager is the locked vault—Chewbacca doesn’t put passwords on sticky notes.
resource "aws_vpc_endpoint" "endpoint_vpce_secrets01" {
  vpc_id              = aws_vpc.app1-vpc-b-ny.id
  service_name        = "com.amazonaws.${data.aws_region.current_region01.name}.secretsmanager"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = [aws_subnet.private-us-east-1a.id, aws_subnet.private-us-east-1b.id, aws_subnet.private-us-east-1c.id]
  security_group_ids = [aws_security_group.endpoint_vpce_sg01.id]

  tags = {
    Name = "${local.armageddon_prefix}-vpce-secrets01"
  }
}

############################################
# Optional: VPC Endpoint - KMS (Interface)
############################################

# Explanation: KMS is the encryption kyber crystal—Chewbacca prefers locked doors AND locked safes.
resource "aws_vpc_endpoint" "endpoint_vpce_kms01" {
  vpc_id              = aws_vpc.app1-vpc-b-ny.id
  service_name        = "com.amazonaws.${data.aws_region.current_region01.name}.kms"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = [aws_subnet.private-us-east-1a.id, aws_subnet.private-us-east-1b.id, aws_subnet.private-us-east-1c.id]
  security_group_ids = [aws_security_group.endpoint_vpce_sg01.id]

  tags = {
    Name = "${local.armageddon_prefix}-vpce-kms01"
  }
}

############################################
# Least-Privilege IAM (BONUS A)
############################################

# Explanation: Chewbacca doesn’t hand out the Falcon keys—this policy scopes reads to your lab paths only.
resource "aws_iam_policy" "policy_leastpriv_read_params01" {
  name        = "${local.armageddon_prefix}-lp-ssm-read01"
  description = "Least-privilege read for SSM Parameter Store under /armageddon/1b/database/*"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "ReadLabDbParams"
        Effect = "Allow"
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:GetParametersByPath",
          "logs:FilterLogEvents" #filter log events from ssm because ssh is not allowed
          #https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_FilterLogEvents.html
        ]
        Resource = [
          "arn:aws:ssm:${data.aws_region.current_region01.name}:${data.aws_caller_identity.current_self01.account_id}:parameter/armageddon/1b/database/*"
        ]
      }
    ]
  })
}

# Explanation: Chewbacca only opens *this* vault—GetSecretValue for only your secret (not the whole planet).
resource "aws_iam_policy" "policy_leastpriv_read_secret01" {
  name        = "${local.armageddon_prefix}-lp-secrets-read01"
  description = "Least-privilege read for the lab DB secret"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "ReadOnlyLabSecret"
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = local.secret_arn_guess
        #Resource = aws_secretsmanager_secret.lab1a-rds-mysql-v25.arn #FROM 1a-8-secrets_manager.tf
      }
    ]
  })
}

# Explanation: When the Falcon logs scream, this lets Chewbacca ship logs to CloudWatch without giving away the Death Star plans.
resource "aws_iam_policy" "policy_leastpriv_cwlogs01" {
  name        = "${local.armageddon_prefix}-lp-cwlogs01"
  description = "Least-privilege CloudWatch Logs write for the app log group"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "WriteLogs"
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams",
          "logs:FilterLogEvents" #filter log events from ssm because ssh is not allowed
          #https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_FilterLogEvents.html
        ]
        Resource = [
          "${aws_cloudwatch_log_group.lab-1b-ec2-to-rds-logs.arn}:*"
        ]
      }
    ]
  })
}

# Explanation: Attach the scoped policies—Chewbacca loves power, but only the safe kind.
resource "aws_iam_role_policy_attachment" "policy_attach_lp_params01" {
  role       = aws_iam_role.ec2-to-secretsmanager-rolev2.name
  policy_arn = aws_iam_policy.policy_leastpriv_read_params01.arn
}

resource "aws_iam_role_policy_attachment" "policy_attach_lp_secret01" {
  role       = aws_iam_role.ec2-to-secretsmanager-rolev2.name
  policy_arn = aws_iam_policy.policy_leastpriv_read_secret01.arn
}

resource "aws_iam_role_policy_attachment" "policy_attach_lp_cwlogs01" {
  role       = aws_iam_role.ec2-to-secretsmanager-rolev2.name
  policy_arn = aws_iam_policy.policy_leastpriv_cwlogs01.arn
}
