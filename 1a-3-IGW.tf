resource "aws_internet_gateway" "NY_igw" {
  vpc_id = aws_vpc.app1-vpc-b-ny.id

  tags = {
    Name    = var.igw[1]
    Service = "application1"
    Owner   = "Mighty"
    Planet  = "Maximus"
  }
}
