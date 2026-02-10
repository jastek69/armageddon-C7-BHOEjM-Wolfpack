terraform {
  backend "s3" {
    bucket = "arch-12-3-24"
    key    = "armageddon/state/jan2025/lab1c/terraform.tfstate"
    region = "us-east-1"
  }
}