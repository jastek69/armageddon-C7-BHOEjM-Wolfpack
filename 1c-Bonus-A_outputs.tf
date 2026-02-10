#Bonus-A outputs (append to outputs.tf)

# Explanation: These outputs prove endpoint built private hyperspace lanes (endpoints) instead of public chaos.
output "endpoint_vpce_ssm_id" {
  value = aws_vpc_endpoint.endpoint_vpce_ssm01.id
}

output "endpoint_vpce_logs_id" {
  value = aws_vpc_endpoint.endpoint_vpce_logs01.id
}

output "endpoint_vpce_secrets_id" {
  value = aws_vpc_endpoint.endpoint_vpce_secrets01.id
}

output "endpoint_vpce_s3_id" {
  value = aws_vpc_endpoint.endpoint_vpce_s3_gw01.id
}

output "endpoint_private_ec2_instance_id_bonus" {
  value = aws_instance.ec201_private_bonus.id
}


