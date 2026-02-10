output "ip_address-1" {
  value = aws_instance.web_server-ec2-to-rds.public_ip
}

output "website_url-1" {
  value = "http://${aws_instance.web_server-ec2-to-rds.public_dns}"
}

output "ip_address-1-init" {
  value = "http://${aws_instance.web_server-ec2-to-rds.public_ip}/init"
}

output "ip_address-1-add-note" {
  value = "http://${aws_instance.web_server-ec2-to-rds.public_ip}/add?note=first_note"
}

output "ip_address-1-list" {
  value = "http://${aws_instance.web_server-ec2-to-rds.public_ip}/list"
}

output "compute_zones-virginia" {
  description = "Comma-separated compute zones"
  # convert set into string delimited by commas (CSV) before output
  value = join(", ", data.aws_availability_zones.available.names)
}