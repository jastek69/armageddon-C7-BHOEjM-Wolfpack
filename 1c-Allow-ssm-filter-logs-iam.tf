#filter log events from ssm because ssh is not allowed
#https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_FilterLogEvents.html

# resource "aws_iam_role_policy_attachment" "CloudWatchLogsReadOnlyAccess_policy_attachment" {
#   role       = aws_iam_role.ec2-to-secretsmanager-rolev2.name
#   policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsReadOnlyAccess"
# }

#Least Privilege: Only need FilterLogEvents permission for ssm agent to filter logs
