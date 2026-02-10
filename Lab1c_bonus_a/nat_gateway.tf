# NAT Gateway + EIP
############################################

# Explanation: lab1c wants the private base to call home—EIP gives the NAT a stable “holonet address.”
resource "aws_eip" "lab1c_nat_eip" {
  domain = "vpc"

  tags = {
    Name = "${local.name_prefix}-nat-eip"
  }
}

# Explanation: NAT is lab1c’s smuggler tunnel—private subnets can reach out without being seen.
resource "aws_nat_gateway" "lab1c_nat" {
  allocation_id = aws_eip.lab1c_nat_eip.id
  subnet_id     = aws_subnet.lab1c_public_subnets[0].id # NAT in a public subnet

  tags = {
    Name = "${local.name_prefix}-nat"
  }

  depends_on = [aws_internet_gateway.lab1c_igw]
}
