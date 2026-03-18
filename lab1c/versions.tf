terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}
resource "tls_private_key" "lab1c_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "lab1c_keypair" {
  key_name   = "${local.name_prefix}-ec2-key01"
  public_key = tls_private_key.lab1c_key.public_key_openssh
}

resource "local_file" "lab1c_private_key" {
  content  = tls_private_key.lab1c_key.private_key_pem
  filename = "${path.module}/lab1c-ec2-key01.pem"
  file_permission = "0600"
}