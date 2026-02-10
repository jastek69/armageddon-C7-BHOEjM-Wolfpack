#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm.html
#https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/rds-metrics.html#rds-metrics-usage


locals {
  project_name = "armageddon-7-0-lab"
  region       = "us-east-1"

  tags_1b = {
    #Project     = local.project_name
    Environment = "Armageddon"
    Owner       = "Maximus"
    Class       = "7.0"
  }
}
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group
resource "aws_cloudwatch_log_group" "lab-1b-ec2-to-rds-logs" {
  name              = "/aws/ec2/${local.project_name}/ec2-to-rds-logs"
  retention_in_days = 1
  tags              = local.tags_1b
}

#Watchtower creates the log streams
# #I need a log stream that the agent can push to.
# #https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_stream
# resource "aws_cloudwatch_log_stream" "rdsapp-instance" {
#   name           = "lab-1b-ec2-to-rds-log-stream"
#   log_group_name = aws_cloudwatch_log_group.lab-1b-ec2-to-rds-logs.name
#   }

#https://registry.terraform.io/providers/-/aws/latest/docs/resources/cloudwatch_log_metric_filter
resource "aws_cloudwatch_log_metric_filter" "db_connection-errors" {
  name = "${local.project_name}-db-connection-errors"

  log_group_name = aws_cloudwatch_log_group.lab-1b-ec2-to-rds-logs.name

  pattern = " ?\"pymysql.err.OperationalError\" ?\"Can't connect\" ?\"ERROR\" ?\"failed\" "

  metric_transformation {
    name          = "DBConnectionErrors"
    namespace     = "Armageddon/Lab1B/RDS"
    value         = "1"
    default_value = "0"
  }

}


resource "aws_cloudwatch_metric_alarm" "db_connection-failure-alarm" {
  alarm_name          = "${local.project_name}-db-connection-failure"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "DBConnectionErrors"
  namespace           = "Armageddon/Lab1B/RDS"
  period              = 300
  statistic           = "Sum"
  threshold           = 3
  treat_missing_data  = "notBreaching"

  alarm_actions = [aws_sns_topic.db_incidents-v2.arn]

  tags = merge(
    local.tags_1b,

    { Name = "${local.project_name}-alarm-db-fail" }
  )

  depends_on = [
    aws_cloudwatch_log_metric_filter.db_connection-errors,
    aws_sns_topic.db_incidents-v2
  ]
}


