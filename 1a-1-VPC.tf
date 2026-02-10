# this  makes  vpc.id which is aws_vpc.app1-vpc-b-ny.id
resource "aws_vpc" "app1-vpc-b-ny" {
  cidr_block = var.ny_cidr_blocks[0].cidr_block

  instance_tenancy     = "default" # optional, default option is setting this argument to default
  enable_dns_hostnames = true
  enable_dns_support   = true # optional, defaults to true 

  tags = {
    Name    = "app1-vpc-b-ny"
    Service = "application1"
    Owner   = "Michael"
    Planet  = "Maximus"
  }
}

output "vpc-id" {
  value = aws_vpc.app1-vpc-b-ny.id
} 