# Explanation: Outputs are your mission report—what got built and where to find it.
output "lab1c_vpc_id" {
  value = aws_vpc.lab1c_vpc1.id
}

output "lab1c_public_subnet_ids" {
  value = aws_subnet.lab1c_public_subnets[*].id
}

output "lab1c_private_subnet_ids" {
  value = aws_subnet.lab1c_private_subnets[*].id
}

output "lab1c_ec2_instance_id" {
  value = aws_instance.lab1c_ec2.id
}

output "lab1c_rds_endpoint" {
  value = aws_db_instance.lab1c_rds1.address
}

output "lab1c_sns_topic_arn" {
  value = aws_sns_topic.lab1c_sns_topic1.arn
}

output "lab1c_log_group_name" {
  value = aws_cloudwatch_log_group.lab1c-log-group1.name
}