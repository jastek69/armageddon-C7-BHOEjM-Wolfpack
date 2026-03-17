terraform {
  backend "s3" {
    bucket = "s3states2026"
    key    = "State/30226/terraform.tfstate"
    region = "us-east-2"
  }
}