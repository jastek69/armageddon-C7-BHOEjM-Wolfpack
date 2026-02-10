############################################
# IAM Role + Instance Profile for EC2
############################################

# Explanation: lab1c(lol) refuses to carry static keys—this role lets EC2 assume permissions safely.
resource "aws_iam_role" "lab1c_ec2_role" {
  name = "${local.name_prefix}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

# Explanation: These policies are your Wookiee toolbelt—tighten them (least privilege) as a stretch goal.
resource "aws_iam_role_policy_attachment" "lab1c_ec2_ssm_attach" {
  role       = aws_iam_role.lab1c_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Explanation: EC2 must read secrets/params during recovery—give it access (students should scope it down).
resource "aws_iam_role_policy_attachment" "lab1c_ec2_secrets_attach" {
  role       = aws_iam_role.lab1c_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite" # TODO: student replaces w/ least privilege
}

# Explanation: CloudWatch logs are the “ship’s black box”—you need them when things explode.
resource "aws_iam_role_policy_attachment" "lab1c_ec2_cw_attach" {
  role       = aws_iam_role.lab1c_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# Explanation: Instance profile is the harness that straps the role onto the EC2 like bandolier ammo.
resource "aws_iam_instance_profile" "lab1c_instance_profile01" {
  name = "${local.name_prefix}-instance-profile"
  role = aws_iam_role.lab1c_ec2_role.name
}
