#declare variables
#Defines cidr_block as a variable 
# variable "tokyo_cidr_blocks" {
#     description = "cidr blocks for vpc and subnets"
#     type =list (object ({
#     cidr_block = string
#     name = string
#     region = string
#     image_id = string
#     availability_zone = string
#   }))
# }

variable "ny_cidr_blocks" {
  description = "cidr blocks for vpc and subnets"
  type = list(object({
    cidr_block        = string
    name              = string
    region            = string
    image_id          = string
    availability_zone = string
    instance_type     = string
  }))
}


# variable "london_cidr_blocks" {
#     description = "cidr blocks for vpc and subnets"
#     type =list (object ({
#     cidr_block = string
#     name = string
#     region = string
#     image_id = string
#     availability_zone = string
#   }))
# }

# variable "SaoPaulo_cidr_blocks" {
#     description = "cidr blocks for vpc and subnets"
#     type =list (object ({
#     cidr_block = string
#     name = string
#     region = string
#     image_id = string
#     availability_zone = string
#   }))
# }

# variable "Sydney_cidr_blocks" {
#     description = "cidr blocks for vpc and subnets"
#     type =list (object ({
#     cidr_block = string
#     name = string
#     region = string
#     image_id = string
#     availability_zone = string
#   }))
# }

# variable "HongKong_cidr_blocks" {
#     description = "cidr blocks for vpc and subnets"
#     type =list (object ({
#     cidr_block = string
#     name = string
#     region = string
#     image_id = string
#     availability_zone = string
#   }))
# }

# variable "california_cidr_blocks" {
#     description = "cidr blocks for vpc and subnets"
#     type =list (object ({
#     cidr_block = string
#     name = string
#     region = string
#     image_id = string
#     availability_zone = string
#   }))
# }

variable "igw" {
  description = "igw for each vpc"
  type        = list(string)
}

variable "nat" {
  description = "nat for each vpc"
  type        = list(string)
}

variable "eip" {
  description = "igw for each nat"
  type        = list(string)
}



variable "naming_convention3" {
  description = "creates names for resource ids"
  type = map(object({
    vpc_id     = string
    subnet_id1 = string
    subnet_id2 = string
    subnet_id3 = string
    subnet_id4 = string
    subnet_id5 = string
    subnet_id6 = string
    nat_id     = string
    igw_id     = string
    tags       = map(string)
  }))

  default = {
    "NewYork" = {
      vpc_id     = "app1-vpc-B-NY",
      subnet_id1 = "private-us-east-1a",
      subnet_id2 = "private-us-east-1b",
      subnet_id3 = "private-us-east-1c",
      subnet_id4 = "public-us-east-1a",
      subnet_id5 = "public-us-east-1b",
      subnet_id6 = "public-us-east-1c",
      nat_id     = "NY-nat",
      igw_id     = "NY_igw",
      tags = {
        Name    = "ForNewYork",
        Service = "application1"
    } },


    "Tokyo" = {
      vpc_id     = "app1-vpc-A-Tokyo",
      subnet_id1 = "private-ap-northeast-1a",
      subnet_id2 = "private-ap-northeast-1c",
      subnet_id3 = "private-ap-northeast-1d",
      subnet_id4 = "public-ap-northeast-1a",
      subnet_id5 = "public-ap-northeast-1c",
      subnet_id6 = "public-ap-northeast-1d",
      nat_id     = "tokyo-nat",
      igw_id     = "Tokyo_igw"
      tags = {
        Name    = "ForTokyo",
        Service = "application1"
    } },

    "London" = {
      vpc_id     = "app1-vpc-C-London",
      subnet_id1 = "private-eu-west-2a",
      subnet_id2 = "private-eu-west-2b",
      subnet_id3 = "private-eu-west-2c",
      subnet_id4 = "public-eu-west-2a",
      subnet_id5 = "public-eu-west-2b",
      subnet_id6 = "public-eu-west-2c",
      nat_id     = "London-nat",
      igw_id     = "London_igw",
      tags = {
        Name    = "ForTokyo",
        Service = "application1"
    } },

    "SaoPaulo" = {
      vpc_id     = "app1-vpc-D-Sao-Paulo",
      subnet_id1 = "private-sa-east-1a",
      subnet_id2 = "private-sa-east-1b",
      subnet_id3 = "private-sa-east-1c",
      subnet_id4 = "public-sa-east-1a",
      subnet_id5 = "public-sa-east-1b",
      subnet_id6 = "public-sa-east-1c",
      nat_id     = "Sao-Paulo-nat",
      igw_id     = "Sao-Paulo_igw",
      tags = {
        Name    = "ForTokyo",
        Service = "application1"
    } },

    "Sydney" = {
      vpc_id     = "app1-vpc-E-Sydney",
      subnet_id1 = "private-ap-northeast-2a",
      subnet_id2 = "private-ap-northeast-2b",
      subnet_id3 = "private-ap-northeast-2c",
      subnet_id4 = "public-ap-northeast-2a",
      subnet_id5 = "public-ap-northeast-2b",
      subnet_id6 = "public-ap-northeast-2c",
      nat_id     = "Sydney-nat",
      igw_id     = "Sydney_igw",
      tags = {
        Name    = "ForTokyo",
        Service = "application1"
    } },

    "HongKong" = {
      vpc_id     = "app1-vpc-F-Hong-Kong",
      subnet_id1 = "private-ap-east-1a",
      subnet_id2 = "private-ap-east-1b",
      subnet_id3 = "private-ap-east-1c",
      subnet_id4 = "public-ap-east-1a",
      subnet_id5 = "public-ap-east-1b",
      subnet_id6 = "public-ap-east-1c",
      nat_id     = "Hong-Kong-nat",
      igw_id     = "Hong-Kong_igw",
      tags = {
        Name    = "ForTokyo",
        Service = "application1"
    } },

    /*AZ 1a not available in California/ Can I still create placeholder routes?*/
    "California" = {
      vpc_id     = "app1-vpc-G-California",
      subnet_id1 = "private-us-west-1a",
      subnet_id2 = "private-us-west-1b",
      subnet_id3 = "private-us-west-1c",
      subnet_id4 = "public-us-west-1a",
      subnet_id5 = "public-us-west-1b",
      subnet_id6 = "public-us-west-1c",
      nat_id     = "California-nat",
      igw_id     = "California_igw",
      tags = {
        Name    = "ForTokyo",
        Service = "application1"
    } },

  }

}

output "content" {
  value = var.naming_convention3.NewYork.vpc_id
}
