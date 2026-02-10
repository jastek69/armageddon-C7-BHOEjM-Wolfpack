############################################
# EC2 Instance (App Host)
############################################

# Explanation: This is your “Han Solo box”—it talks to RDS and complains loudly when the DB is down.
resource "aws_instance" "lab1c_ec2" {
  ami                    = var.ec2_ami_id
  instance_type          = var.ec2_instance_type
  subnet_id              = aws_subnet.lab1c_public_subnets[0].id
  vpc_security_group_ids = [aws_security_group.lab1c_ec2_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.lab1c_instance_profile01.name

  # TODO: student supplies user_data to install app + CW agent + configure log shipping
  user_data = file("./user_data_1.sh")

  tags = {
    Name = "${local.name_prefix}-ec2"
  }
}

