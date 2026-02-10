#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic
resource "aws_sns_topic" "db_incidents-v2" {
  name = "db_incidents-v2"
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription
resource "aws_sns_topic_subscription" "db_incidents-v2" {
  topic_arn = aws_sns_topic.db_incidents-v2.arn
  protocol  = "email"
  endpoint  = "king.konvoy1@gmail.com"
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_event_subscription
resource "aws_db_event_subscription" "db_incidents-v2" {
  name      = "rds-event-sub-v2"
  sns_topic = aws_sns_topic.db_incidents-v2.arn

  source_type = "db-instance"
  source_ids  = [aws_db_instance.lab-mysql.identifier]

  event_categories = [
    "availability",
    "deletion",
    "failover",
    "failure",
    "low storage",
    "maintenance",
    "notification",
    "read replica",
    "recovery",
    "restoration",
  ]
}

# topic_arn = aws_sns_topic.db_incidents.arn