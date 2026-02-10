resource "aws_instance" "web_server-ec2-to-rds" {
  ami                         = "ami-0532be01f26a3de55"
  associate_public_ip_address = true
  instance_type               = "t3.micro"

  #include my own key pair/ for ssh
  key_name = "pleaseLord-1-7-26"

  vpc_security_group_ids = [aws_security_group.web_tier_ec2_sg01.id, aws_security_group.ping.id]
  subnet_id              = aws_subnet.public-us-east-1b.id
  #attach IAM role to EC2
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  #   user_data = filebase64("lab-1a.sh")
  # user_data = file("lab-1a.sh")
  user_data = file("lab-1b-with-cloudwatch-agent.sh")
  tags = {
    Name = "web_server-ec2-to-rds"
  }
}


#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile
#https://stackoverflow.com/questions/74620445/add-attach-aws-iam-role-to-ec2-instance-via-terraform

# resource "aws_iam_instance_profile" "ec2-access-to-rds-via-secrets-manager" {
#   name = "ec2-access-to-rds-via-secrets-managerv2"
#   role = aws_iam_role.ec2-to-secretsmanager-rolev2.name
# }

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile
#https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2_instance-profiles.html

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${local.project_name}-ec2-profile"
  role = aws_iam_role.ec2-to-secretsmanager-rolev2.name
}



