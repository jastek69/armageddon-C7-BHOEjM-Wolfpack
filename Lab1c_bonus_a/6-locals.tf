############################################
# Locals (naming convention: lab1c-*)
############################################
# Explanation: Chewbacca wants to know “who am I in this galaxy?” so ARNs can be scoped properly.

data "aws_caller_identity" "lab1c" {}


# Explanation: Region matters—hyperspace lanes change per sector.

data "aws_region" "lab1c_region" {}

locals {
name_prefix = var.project_name
vpc_cidr            = "10.249.0.0/16"
instance_type       = "t3.micro"
db_instance_class   = "db.t3.micro"
db_name             = "labdb"

}

