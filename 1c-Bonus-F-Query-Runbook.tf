#Requirements: Set the time range to Last 15 minutes (or match incident window).
#A) WAF Queries (CloudWatch Logs Insights)

#A1) “What’s happening right now?” (Top actions: ALLOW/BLOCK)
resource "aws_cloudwatch_query_definition" "A1-Whats-happening-right-now" {
  name = "A1-Whats-happening-right-now"

  log_group_names = [
    "aws-waf-logs-armageddon-7-0-lab-webacl01",
    "/aws/ec2/armageddon-7.0-lab/ec2-to-rds-logs"
  ]

  query_string = <<EOF
fields @timestamp, action
  | stats count() as hits by action
  | sort hits desc
EOF
}

###

#A2) Top client IPs (who is hitting us the most?)
resource "aws_cloudwatch_query_definition" "A2-Top-requested-URIs" {
  name = "A2-Top-requested-URIs"

  log_group_names = [
    "aws-waf-logs-armageddon-7-0-lab-webacl01",
    "/aws/ec2/armageddon-7.0-lab/ec2-to-rds-logs"
  ]

  query_string = <<EOF
fields @timestamp, httpRequest.clientIp as clientIp
| stats count() as hits by clientIp
| sort hits desc
| limit 25
EOF
}

###

#A3) Top requested URIs (what are they trying to reach?)
resource "aws_cloudwatch_query_definition" "A3-Top-requested-URIs" {
  name = "A3-Top-requested-URIs"

  log_group_names = [
    "aws-waf-logs-armageddon-7-0-lab-webacl01",
    "/aws/ec2/armageddon-7.0-lab/ec2-to-rds-logs"
  ]

  query_string = <<EOF
fields @timestamp, httpRequest.uri as uri
| stats count() as hits by uri
| sort hits desc
| limit 25
EOF
}

####

#A4) Blocked requests only (who/what is being blocked?)
resource "aws_cloudwatch_query_definition" "A4-Blocked-requests-only" {
  name = "A4-Blocked-requests-only"

  log_group_names = [
    "aws-waf-logs-armageddon-7-0-lab-webacl01",
    "/aws/ec2/armageddon-7.0-lab/ec2-to-rds-logs"
  ]

  query_string = <<EOF
fields @timestamp, action, httpRequest.clientIp as clientIp, httpRequest.uri as uri
| filter action = "BLOCK"
| stats count() as blocks by clientIp, uri
| sort blocks desc
| limit 25
EOF
}

####

#A5) Which WAF rule is doing the blocking?
resource "aws_cloudwatch_query_definition" "A5-Which-WAF-rule-is-doing-the-blocking" {
  name = "A5-Which-WAF-rule-is-doing-the-blocking"

  log_group_names = [
    "aws-waf-logs-armageddon-7-0-lab-webacl01",
    "/aws/ec2/armageddon-7.0-lab/ec2-to-rds-logs"
  ]

  query_string = <<EOF
fields @timestamp, action, terminatingRuleId, terminatingRuleType
| filter action = "BLOCK"
| stats count() as blocks by terminatingRuleId, terminatingRuleType
| sort blocks desc
| limit 25
EOF
}

####

#A6) Rate of blocks over time (did it spike?)
resource "aws_cloudwatch_query_definition" "A6-Rate-of-blocks-over-time" {
  name = "A6-Rate-of-blocks-over-time"

  log_group_names = [
    "aws-waf-logs-armageddon-7-0-lab-webacl01",
    "/aws/ec2/armageddon-7.0-lab/ec2-to-rds-logs"
  ]

  query_string = <<EOF
fields @timestamp, httpRequest.clientIp as clientIp, httpRequest.uri as uri
| filter uri like /wp-login|xmlrpc|\.env|admin|phpmyadmin|\.git|\/login/i
| stats count() as hits by clientIp, uri
| sort hits desc
| limit 50
EOF
}

####

#A7) Suspicious scanners (common patterns: admin paths, wp-login, etc.)
resource "aws_cloudwatch_query_definition" "A7-Suspicious-scanners" {
  name = "A7-Suspicious-scanners"

  log_group_names = [
    "aws-waf-logs-armageddon-7-0-lab-webacl01",
    "/aws/ec2/armageddon-7.0-lab/ec2-to-rds-logs"
  ]

  query_string = <<EOF
fields @timestamp, httpRequest.clientIp as clientIp, httpRequest.uri as uri
| filter uri like /wp-login|xmlrpc|\.env|admin|phpmyadmin|\.git|\/login/i
| stats count() as hits by clientIp, uri
| sort hits desc
| limit 50
EOF
}

####

resource "aws_cloudwatch_query_definition" "A8-Country-geo" {
  name = "A8-Country-geo"

  log_group_names = [
    "aws-waf-logs-armageddon-7-0-lab-webacl01",
    "/aws/ec2/armageddon-7.0-lab/ec2-to-rds-logs"
  ]

  query_string = <<EOF
fields @timestamp, httpRequest.country as country
| stats count() as hits by country
| sort hits desc
| limit 25
EOF
}

####

#B) App Queries (EC2 app log group)
#These assume your app logs include meaningful strings like ERROR, DBConnectionErrors, timeout, etc
#(You should enforce this.)

#B1) Count errors over time (this should line up with the alarm window)
resource "aws_cloudwatch_query_definition" "B1-Count-errors-over-time" {
  name = "B1-Count-errors-over-time"

  log_group_names = [
    "aws-waf-logs-armageddon-7-0-lab-webacl01",
    "/aws/ec2/armageddon-7.0-lab/ec2-to-rds-logs"
  ]

  query_string = <<EOF
fields @timestamp, @message
| filter @message like /ERROR|Exception|Traceback|DB|timeout|refused/i
| stats count() as errors by bin(1m)
| sort bin(1m) asc
EOF
}

###

#B2) Show the most recent DB failures (triage view)
resource "aws_cloudwatch_query_definition" "B2-Show-the-most-recent-DB-failures" {
  name = "B2-Show-the-most-recent-DB-failures"

  log_group_names = [
    "aws-waf-logs-armageddon-7-0-lab-webacl01",
    "/aws/ec2/armageddon-7.0-lab/ec2-to-rds-logs"
  ]

  query_string = <<EOF
fields @timestamp, @message
| filter @message like /DB|mysql|timeout|refused|Access denied|could not connect/i
| sort @timestamp desc
| limit 50
EOF
}

###

# B3) “Is it creds or network?” classifier hints
#   Credentials drift often shows: Access denied, authentication failures
#   Network/SecurityGroup often shows: timeout, refused, “no route”, hang
resource "aws_cloudwatch_query_definition" "B3-Is-it-creds-or-network" {
  name = "B3-Is-it-creds-or-network"

  log_group_names = [
    "aws-waf-logs-armageddon-7-0-lab-webacl01",
    "/aws/ec2/armageddon-7.0-lab/ec2-to-rds-logs"
  ]

  query_string = <<EOF
fields @timestamp, @message
| filter @message like /Access denied|authentication failed|timeout|refused|no route|could not connect/i
| stats count() as hits by
  case(
    @message like /Access denied|authentication failed/i, "Creds/Auth",
    @message like /timeout|no route/i, "Network/Route",
    @message like /refused/i, "Port/SG/ServiceRefused",
    "Other"
  )
| sort hits desc
EOF
}

###

# B4) Extract structured fields (Requires log JSON)
# If you log JSON like: {"level":"ERROR","event":"db_connect_fail","reason":"timeout"}:
resource "aws_cloudwatch_query_definition" "B4-Extract-structured-fields" {
  name = "B4-Extract-structured-fields"

  log_group_names = [
    "aws-waf-logs-armageddon-7-0-lab-webacl01",
    "/aws/ec2/armageddon-7.0-lab/ec2-to-rds-logs"
  ]

  query_string = <<EOF
fields @timestamp, level, event, reason
| filter level="ERROR"
| stats count() as n by event, reason
| sort n desc
EOF
}

###

/*C) Correlation “Enterprise-style” mini-workflow (Runbook Section)
Add this to the incident runbook:

Step 1 — Confirm signal timing
  CloudWatch alarm time window: last 5–15 minutes
  Run App B1 to see error spike time bins

Step 2 — Decide: Attack vs Backend Failure
  Run WAF A1 + A6:
    If BLOCK spikes align with incident time → likely external pressure/scanning
    If WAF is quiet but app errors spike → likely backend (RDS/SG/creds)

Step 3 — If backend failure suspected
  Run App B2 and classify:
    Access denied → secrets drift / wrong password
    timeout → SG/routing/RDS down
  Then retrieve known-good values:
    Parameter Store /lab/db/*
    Secrets Manager /<prefix>/rds/mysql

Step 4 — Verify recovery
  App errors return to baseline (B1)
  WAF blocks stabilize (A6)
  Alarm returns to OK
  curl https://app.chewbacca-growl.com/list works*/