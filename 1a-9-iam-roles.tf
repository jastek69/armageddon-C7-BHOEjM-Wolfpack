#https://registry.terraform.io/providers/-/aws/latest/docs/resources/iam_role
resource "aws_iam_role" "ec2-to-secretsmanager-rolev2" {
  name = "ec2-to-secretsmanager-rolev2"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "ec2-to-secretsmanager-rolev2"
  }

  # inline_policy {
  #     name = "lab1a_inline_policy"

  #     policy = jsonencode({
  # 	"Version": "2012-10-17",
  # 	"Statement": [
  # 		{
  # 			"Sid": "ReadSpecificSecret",
  # 			"Effect": "Allow",
  # 			"Action": [
  # 				"secretsmanager:GetSecretValue"
  # 			],
  # 			"Resource": "arn:aws:secretsmanager:us-east-1:314146336018:secret:lab1a-rds-mysql*"
  # 		}
  # 	]
  # })

  #alternative way to specify inline policy using file
  inline_policy {
    name = "lab1a_inline_policy"

    policy = file("1a_inline_policy.json")
  }

}

# Attach a Managed Policy to the Role
#This attaches SecretsManagerReadWrite, an AWS managed policy
resource "aws_iam_role_policy_attachment" "SecretsManagerReadWrite_policy_attachment" {
  role       = aws_iam_role.ec2-to-secretsmanager-rolev2.name
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}