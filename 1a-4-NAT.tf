#Creates an elastic IP for NY NAT
resource "aws_eip" "NY-eip" {
  #vpc = true
  domain = "vpc"

  tags = {
    Name = var.eip[1]
  }

  depends_on = [aws_internet_gateway.NY_igw] # explict dependency
}

resource "aws_nat_gateway" "NY-nat" {
  allocation_id = aws_eip.NY-eip.id
  subnet_id     = aws_subnet.public-us-east-1a.id

  tags = {
    # Name = "nat"
    # Name = var.naming_convention3["NewYork"].nat_id
    Name = var.nat[1]
  }

  depends_on = [aws_internet_gateway.NY_igw]
}
