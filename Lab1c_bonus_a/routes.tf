############################################
# Routing (Public + Private Route Tables)
############################################

# Explanation: Public route table = “open lanes” to the galaxy via IGW.
resource "aws_route_table" "lab1c_public_rt" {
  vpc_id = aws_vpc.lab1c_vpc.id

  tags = {
    Name = "${local.name_prefix}-public-rt"
  }
}

# Explanation: This route is the Kessel Run—0.0.0.0/0 goes out the IGW.
resource "aws_route" "lab1c_public_default_route" {
  route_table_id         = aws_route_table.lab1c_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.lab1c_igw.id
}

# Explanation: Attach public subnets to the “public lanes.”
resource "aws_route_table_association" "lab1c_public_rta" {
  count          = length(aws_subnet.lab1c_public_subnets)
  subnet_id      = aws_subnet.lab1c_public_subnets[count.index].id
  route_table_id = aws_route_table.lab1c_public_rt.id
}

# Explanation: Private route table = “stay hidden, but still ship supplies.”
resource "aws_route_table" "lab1c_private_rt" {
  vpc_id = aws_vpc.lab1c_vpc.id

  tags = {
    Name = "${local.name_prefix}-private-rt"
  }
}

# Explanation: Private subnets route outbound internet via NAT (lab1c-approved stealth).
resource "aws_route" "lab1c_private_default_route" {
  route_table_id         = aws_route_table.lab1c_private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.lab1c_nat.id
}

# Explanation: Attach private subnets to the “stealth lanes.”
resource "aws_route_table_association" "lab1c_private_rta" {
  count          = length(aws_subnet.lab1c_private_subnets)
  subnet_id      = aws_subnet.lab1c_private_subnets[count.index].id
  route_table_id = aws_route_table.lab1c_private_rt.id
}
