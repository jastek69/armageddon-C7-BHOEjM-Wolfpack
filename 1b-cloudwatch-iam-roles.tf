#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy
# resource "aws_iam_role_policy" "cloudwatch-ec2-policy" {
#   name = "cloudwatch-ec2-policy"
#   role = aws_iam_role.ec2-to-secretsmanager-rolev2.id

#   policy = jsonencode({
#     "Version" : "2012-10-17",
#     "Statement" : [
#       {
#         "Effect" : "Allow",
#         "Action" : [
#           "logs:CreateLogGroup",
#           "logs:CreateLogStream",
#           "logs:PutLogEvents",
#           "logs:DescribeLogStreams"
#         ],
#         "Resource" : [
#           "arn:aws:logs:${local.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/ec2/${local.project_name}/ec2-to-rds-logs:*"
#         ]
#       }
#     ]
#   })
# }


#From TIQS seems to be pulling data of the linux ami but why?
# EC2
# I use th arm version of the ami

# data "aws_ssm_parameter" "al2023_ami" {
#   name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernal-default-x86_64"
# }


# resource "aws_iam_role_policy_attachment" "CloudWatchAgentServerPolicy_policy_attachment" {
#   role       = aws_iam_role.ec2-to-secretsmanager-rolev2.name
#   policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
# }
#This is replaced by the least privilege policy in 1c-bonus_a.tf
#resource "aws_iam_policy" "policy_leastpriv_cwlogs01"


resource "aws_iam_policy" "Alternate_policy_WatchTower_CWLogs" {
  name        = "Alternate_policy_WatchTower_CWLogs"
  description = "Least-privilege WatchTower CW Agent CW Logs write for the app log group"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "CWACloudWatchServerPermissions",
            "Effect": "Allow",
            "Action": [
                "cloudwatch:PutMetricData",
                "ec2:DescribeVolumes",
                "ec2:DescribeTags",
                "logs:PutLogEvents",
                "logs:PutRetentionPolicy",
                "logs:DescribeLogStreams",
                "logs:DescribeLogGroups",
                "logs:CreateLogStream",
                "xray:PutTraceSegments",
                "xray:PutTelemetryRecords",
                "xray:GetSamplingRules",
                "xray:GetSamplingTargets",
                "xray:GetSamplingStatisticSummaries"
            ],
            "Resource": "*"
        },
        {
            "Sid": "CWASSMServerPermissions",
            "Effect": "Allow",
            "Action": [
                "ssm:GetParameter"
            ],
            "Resource": "arn:aws:ssm:*:*:parameter/AmazonCloudWatch-*"
        }
    ]
})
#"logs:CreateLogGroup",, #Remove WatchTower ability to create log groups...getting duplicate log group

}

resource "aws_iam_role_policy_attachment" "policy_attach_Alternate_policy_WatchTower_CWLogs" {
  role       = aws_iam_role.ec2-to-secretsmanager-rolev2.name
  policy_arn = aws_iam_policy.Alternate_policy_WatchTower_CWLogs.arn
}