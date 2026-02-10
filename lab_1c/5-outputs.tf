# Explanation: Outputs are your mission report—what got built and where to find it.
output "lab1c_vpc_id" {
  value = aws_vpc.lab1c_vpc.id
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
  value = aws_db_instance.lab1c_rds.address
}

output "lab1c_sns_topic_arn" {
  value = aws_sns_topic.lab1c_sns_topic.arn
}

output "lab1c_log_group_name" {
  value = aws_cloudwatch_log_group.lab1c_log_group.name
}


output "application_urls" {
  description = "URLs to test the deployed application"
  value       = <<EOT
Home:           http://${aws_instance.lab1c_ec2.public_ip}/
Initialize DB:  http://${aws_instance.lab1c_ec2.public_ip}/init
1st note (GET): http://${aws_instance.lab1c_ec2.public_ip}/add?note=first_note
2nd note (GET)  http://${aws_instance.lab1c_ec2.public_ip}/add?note=blue_book_gentlemen
3rd note (GET)  http://${aws_instance.lab1c_ec2.public_ip}/add?note=brazil_colombia_capeverde
4th note (GET)  http://${aws_instance.lab1c_ec2.public_ip}/add?note=this_is_200k_work
5th note (GET)  http://${aws_instance.lab1c_ec2.public_ip}/add?note=lab_1c_is_a_success
List notes:     http://${aws_instance.lab1c_ec2.public_ip}/list
EOT
}