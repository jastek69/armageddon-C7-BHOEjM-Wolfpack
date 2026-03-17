#Bonus-A outputs (append to outputs.tf)

# Explanation: These outputs prove lab1c built private hyperspace lanes (endpoints) instead of public chaos.
output "lab1c_vpce_ssm_id" {
  value = aws_vpc_endpoint.lab1c_vpce_ssm01.id
}

output "lab1c_vpce_logs_id" {
  value = aws_vpc_endpoint.lab1c_vpce_logs01.id
}

output "lab1c_vpce_secrets_id" {
  value = aws_vpc_endpoint.lab1c_vpce_secrets01.id
}

output "lab1c_vpce_s3_id" {
  value = aws_vpc_endpoint.lab1c_vpce_s3_gw01.id
}

output "lab1c_private_ec2_instance_id_bonus" {
  value = aws_instance.lab1c_ec2.id
}

