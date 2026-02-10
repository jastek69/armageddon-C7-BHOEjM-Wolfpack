#3) Outputs (append to outputs.tf)
# Explanation: Coordinates for the WAF log destination—maximus wants to know where the footprints landed.
output "maximus_waf_log_destination" {
  value = var.waf_log_destination
}

output "maximus_waf_cw_log_group_name" {
  value = var.waf_log_destination == "cloudwatch" ? aws_cloudwatch_log_group.maximus_waf_log_group01[0].name : null
}

# output "maximus_waf_logs_s3_bucket" {
#   value = var.waf_log_destination == "s3" ? aws_s3_bucket.maximus_waf_logs_bucket01[0].bucket : null
# }

# output "maximus_waf_firehose_name" {
#   value = var.waf_log_destination == "firehose" ? aws_kinesis_firehose_delivery_stream.maximus_waf_firehose01[0].name : null
# }