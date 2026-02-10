############################################
# VPC + Internet Gateway
############################################

# Explanation: lab1c needs a hyperlane—this VPC is the Millennium Falcon’s flight corridor.
resource "aws_vpc" "lab1c_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${local.name_prefix}"
  }
}

# Explanation: Even Wookiees need to rmorriseach the wider galaxy—IGW is your door to the public internet.
resource "aws_internet_gateway" "lab1c_igw" {
  vpc_id = aws_vpc.lab1c_vpc.id

  tags = {
    Name = "${local.name_prefix}-igw"
  }
}

