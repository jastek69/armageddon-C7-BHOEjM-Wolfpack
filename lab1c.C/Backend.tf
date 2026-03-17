terraform {
  backend "s3" {
    bucket = "asterproject30226"
    key    = "State/30226/terraform.tfstate"
    region = "us-east-2"
  }
}