# ☁️ Class 7 Armageddon - Brotherhood of Evil jerMutants - Wolfpack


![AWS](https://img.shields.io/badge/AWS-Cloud-orange?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-%E2%89%A51.9-844FBA?style=for-the-badge&logo=terraform&logoColor=white)
![CloudFront](https://img.shields.io/badge/CloudFront-Edge_Security-yellow?style=for-the-badge&logo=amazon-aws)
![WAFv2](https://img.shields.io/badge/AWS_WAFv2-Real_Time_Logging-red?style=for-the-badge&logo=amazonaws)
![Bedrock](https://img.shields.io/badge/Amazon_Bedrock-Auto_IR-black?style=for-the-badge&logo=amazon-aws)
![Multi_Region](https://img.shields.io/badge/Multi_Region-Transit_Gateway-blue?style=for-the-badge)
![Compliance](https://img.shields.io/badge/Compliance-HIPAA_Inspired-purple?style=for-the-badge)
![Observability](https://img.shields.io/badge/Observability-CloudWatch_&_Bedrock-green?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Production_Grade-success?style=for-the-badge)



This repository contains links to repos of group members for multiple **Labs for Class 7 Armageddon (1a, 1b, 1c, 1d, 1e, 1f, 1g, 1h, 1I, 2a, 2b, 3a, 3b, and 4)**.
Each LAB is tracked in its own branch with unique deliverables and tasks.

---

## GROUP MEMBER DELIVERABLES/REPOs
**Group Co-Leader: T.I.Q.S**
- **Labs 1A - LAB 3:** [tiqsclass6 - Overview](https://github.com/tiqsclass6)
#
**Group Co-Leader: John Sweeney**

- Lab1A-B: [LAB1 DELIVERABLES](https://github.com/jastek69/armageddon-C7-LAB1C-H/tree/main/LAB1-DELIVERABLES)
- Lab1C-H: [LAB1C-H DELIVERABLES](https://github.com/jastek69/armageddon-C7-LAB1C-H/tree/main/LAB1-DELIVERABLES)
- Labb2A-B: [LAB2 - DELIVERABLES](https://github.com/jastek69/Armageddon-C7-SEIR_Foundations/tree/LAB2/LAB2-DELIVERABLES)
- Lab2A-B: Code: [LAB2 - Code](https://github.com/jastek69/Armageddon-C7-SEIR_Foundations)
- LAB3 - Deliverables: [LAB3 - DELIVERABLES](https://github.com/jastek69/Armageddon-C7-Lab3-SEIR_Foundations/tree/main)
- LAB3 - Code: [LAB3 - Code](https://github.com/jastek69/Armageddon-C7-Lab3-SEIR_Foundations/tree/main)

#
**Member: Ernest Morris**
- Labs 1A-B: [Deliverables](https://github.com/jastek69/armageddon-C7-BHOEjM-Wolfpack.git)

#
___

# [🌐 LAB1]
## LAB1A-B

#### Deliverables
- [tiqsclass6 - Overview](https://github.com/tiqsclass6)
- [John Sweeney - Deliverable](https://github.com/jastek69/Armageddon-C7-SEIR_Foundations/tree/LAB2/LAB1-DELIVERABLES)
- [Ernest Morris - Deliverables](https://github.com/jastek69/armageddon-C7-BHOEjM-Wolfpack.git)

### [Lab1a Explanation](https://github.com/BalericaAI/armageddon/blob/main/SEIR_Foundations/LAB1/1a_explanation.md?plain=1)
Project Overview (What You Are Building)
In this lab, you will build a classic cloud application architecture:
A compute layer running on an Amazon EC2 instance
A managed relational database hosted on Amazon RDS
Secure connectivity between the two using VPC networking and security groups
Credential management using AWS Secrets Manager
A simple application that writes and reads data from the database

### [Lab1b - explanation](https://github.com/BalericaAI/armageddon/blob/main/SEIR_Foundations/LAB1/1b_Incident_response.md?plain=1)
Lab 1b — Incident Response Scenario
Prerequisite: Lab 1a + Lab 1b infrastructure completed

PART I — Incident Scenario (What Messed Up)
Incident Title
Database Connectivity Failure — Production Application Unavailable
Symptoms Reported
    Application intermittently returns errors
    /list endpoint fails or hangs
    No recent code changes
    EC2 instance is still running

Constraints
  You may NOT:
      Recreate EC2
      Recreate RDS
      Hardcode credentials

You MUST:
    Use logs
    Use alarms
    Use stored configuration values

PART II — Incident Injection (Group Leader / Auto-Grader)
Choose one of the following to trigger the incident:
  Option A — Secret Drift (Recommended)
    Change DB password in Secrets Manager
    Do not update the actual RDS password

  Option B — Network Isolation
    Remove EC2 security group from RDS inbound rule (TCP 3306)

  Option C — DB Interruption
    Stop RDS instance temporarily

Students are not told which failure was injected.

PART III — Monitoring & Alerting (SNS + PagerDuty Simulation)
  1. SNS Alert Channel
    SNS Topic
    Name: lab-db-incidents
    aws sns create-topic --name lab-db-incidents
    Email Subscription (PagerDuty Simulation)

          aws sns subscribe \
            --topic-arn <TOPIC_ARN> \
            --protocol email \
            --notification-endpoint your-email@example.com

    This simulates PagerDuty / OpsGenie paging an engineer.

2. CloudWatch Alarm → SNS
Alarm Concept
Trigger when:
  DB connection errors ≥ 3 in 5 minutes
Alarm Creation (example)

        aws cloudwatch put-metric-alarm \
          --alarm-name lab-db-connection-failure \
          --metric-name DBConnectionErrors \
          --namespace Lab/RDSApp \
          --statistic Sum \
          --period 300 \
          --threshold 3 \
          --comparison-operator GreaterThanOrEqualToThreshold \
          --evaluation-periods 1 \
          --alarm-actions <SNS_TOPIC_ARN>

Expected Behavior
  Alarm transitions to ALARM
  SNS notification sent
  Student receives alert email

PART IV — Mandatory Incident Runbook
Students must follow this order. Deviations lose points.

RUNBOOK SECTION 1 — Acknowledge
1.1 Confirm Alert
  aws cloudwatch describe-alarms \
  --alarm-name lab-db-connection-failure \
  --query "MetricAlarms[].StateValue"

Expected:
  ALARM


RUNBOOK SECTION 2 — Observe
2.1 Check Application Logs

      aws logs filter-log-events \
      --log-group-name /aws/ec2/lab-rds-app \
      --filter-pattern "ERROR"

Expected:
  Clear DB connection failure messages

2.2 Identify Failure Type
Students must classify:
  Credential failure?
  Network failure?
  Database availability failure?
This classification is graded.

RUNBOOK SECTION 3 — Validate Configuration Sources
3.1 Retrieve Parameter Store Values
    
      aws ssm get-parameters \
        --names /lab/db/endpoint /lab/db/port /lab/db/name \
        --with-decryption

Expected:
  Endpoint + port returned

3.2 Retrieve Secrets Manager Values

      aws secretsmanager get-secret-value \
      --secret-id lab/rds/mysql

Expected:
  Username/password visible
  Compare against known-good state

RUNBOOK SECTION 4 — Containment
4.1 Prevent Further Damage
  Do not restart EC2 blindly
  Do not rotate secrets again
  Do not redeploy infrastructure

Students must explicitly state:
  “System state preserved for recovery.”


RUNBOOK SECTION 5 — Recovery
Recovery Paths (Depends on Root Cause)
    If Credential Drift
        Update RDS password to match Secrets Manager
        OR
        Update Secrets Manager to known-good value

    If Network Block
        Restore EC2 security group access to RDS on 3306

    If DB Stopped
        Start RDS and wait for available

Verify Recovery
    curl http://<EC2_PUBLIC_IP>/list

Expected:
    Application returns data
    No errors

RUNBOOK SECTION 6 — Post-Incident Validation
6.1 Confirm Alarm Clears

    aws cloudwatch describe-alarms \
      --alarm-name lab-db-connection-failure \
      --query "MetricAlarms[].StateValue"

Expected:
    OK

6.2 Confirm Logs Normalize

    aws logs filter-log-events \
      --log-group-name /aws/ec2/lab-rds-app \
      --filter-pattern "ERROR"

Expected:
    No new errors


PART V — Grading Rubric (100 Points)
| Category                       | Points |
| ------------------------------ | ------ |
| Alarm acknowledged via CLI     | 10     |
| Correct failure classification | 20     |
| Logs used correctly            | 15     |
| Parameter Store validated      | 10     |
| Secrets Manager validated      | 10     |
| Correct recovery action        | 20     |
| No redeploy / no guesswork     | 10     |
| Clear incident summary         | 5      |

PART VI — Required Incident Report (Short)
Students must submit:
    Incident Summary
    What failed?
    How was it detected?
    Root cause
    Time to recovery

Preventive Action
    One improvement to reduce MTTR
    One improvement to prevent recurrence

PART VII — What This Actually Teaches
By completing this lab, students demonstrate:
    On-call discipline
    Root cause analysis
    Cloud-native recovery
    Proper secret handling
    Operational maturity

This is exactly what separates:
    “I passed an AWS cert”
    from
    “I can be trusted with production.”


## Lab 1C — Terraform: EC2 → RDS + Secrets/Params + Observability + Incident Alerts
### LAB1C-H
#### Deliverables
- [tiqsclass6 - Overview](https://github.com/tiqsclass6)
* [John Sweeney - Deliverables 1C-I](https://github.com/jastek69/armageddon-C7-LAB1C-H/tree/main/LAB1C-H-DELIVERABLES)


### Purpose
Modern companies do not build AWS by clicking around in the console.
They use Infrastructure as Code (IaC) so environments are repeatable, reviewable, auditable, and recoverable.

This repo is intentionally incomplete:
- It declares required resources
- Students must configure the details (rules, policies, user_data, app logging, etc.)

### Requirements (must exist in Terraform)
- VPC, public/private subnets, IGW, NAT, routing
- EC2 app host + IAM role/profile
- RDS (private) + subnet group + SG with inbound from EC2 SG
- Parameter Store values (/lab/db/*)
- Secrets Manager secret (db creds)
- CloudWatch log group
- CloudWatch alarm (DBConnectionErrors >= 3 per 5 min)
- SNS topic + subscription

### Student Deliverables
- `terraform plan` output
- `terraform apply` evidence (outputs)
- CLI verification commands (from Lab 1b)
- Incident runbook execution notes (alarm fired + recovered)

## LAB1: 1c_bonus-C
Below is the Route53 add-on for Bonus-B (Hosted Zone + ACM DNS validation records + app.chewbacca-growl.com ALIAS → ALB).
It’s written as a Terraform skeleton with Chewbacca comment style.

Add this as bonus_b_route53.tf.

Add to variables.tf (append)
variable "manage_route53_in_terraform" {
  description = "If true, create/manage Route53 hosted zone + records in Terraform."
  type        = bool
  default     = true
}

variable "route53_hosted_zone_id" {
  description = "If manage_route53_in_terraform=false, provide existing Hosted Zone ID for domain."
  type        = string
  default     = ""
}

Add file: bonus_b_route53.tf

Important note about the HTTPS listener
In your earlier bonus_b.tf, your HTTPS listener referenced:

certificate_arn = aws_acm_certificate_validation.chewbacca_acm_validation01.certificate_arn

Now you have two possible validation resources (email/manual vs DNS). For the skeleton, do this pattern:
    Keep your original aws_acm_certificate_validation (email/manual) if you want
    OR switch the listener certificate ARN to the certificate itself and rely on validation dependency
Best skeleton approach (simple + works):
Update HTTPS listener to use:
  certificate_arn = aws_acm_certificate.chewbacca_acm_cert01.arn

…and keep depends_on pointing at the DNS validation resource when DNS mode is used.
I’ll give you a clean patch below.

### Explanation: HTTPS listener is the real hangar bay — TLS terminates here, then traffic goes to private targets.
resource "aws_lb_listener" "chewbacca_https_listener01" {
  load_balancer_arn = aws_lb.chewbacca_alb01.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = aws_acm_certificate.chewbacca_acm_cert01.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.chewbacca_tg01.arn
  }

### TODO: If DNS validation is enabled, ensure validation completes before listener creation.
  depends_on = [
    aws_acm_certificate_validation.chewbacca_acm_validation01_dns_bonus
  ]
}


If you choose EMAIL validation instead, 
you can comment out the depends_on or set certificate_validation_method="EMAIL" 
and keep the listener creation after manual validation. (This is a skeleton; you’ll get some “learning friction” here.)

Continue bonus_b_route53.tf — ALIAS record app → ALB

############################################
### ALIAS record: app.chewbacca-growl.com -> ALB
############################################

### Explanation: This is the holographic sign outside the cantina—app.chewbacca-growl.com points to your ALB.
resource "aws_route53_record" "chewbacca_app_alias01" {
  zone_id = local.chewbacca_zone_id
  name    = local.chewbacca_app_fqdn
  type    = "A"

  alias {
    name                   = aws_lb.chewbacca_alb01.dns_name
    zone_id                = aws_lb.chewbacca_alb01.zone_id
    evaluate_target_health = true
  }
}

Add outputs (append to outputs.tf)
### Explanation: Outputs are the nav computer readout—Chewbacca needs coordinates that humans can paste into browsers.
output "chewbacca_route53_zone_id" {
  value = local.chewbacca_zone_id
}

output "chewbacca_app_url_https" {
  value = "https://${var.app_subdomain}.${var.domain_name}"
}

Student verification (CLI)
1) Confirm hosted zone exists (if managed)
  aws route53 list-hosted-zones-by-name \
    --dns-name chewbacca-growl.com \
    --query "HostedZones[].Id"

2) Confirm app record exists
  aws route53 list-resource-record-sets \
  --hosted-zone-id <ZONE_ID> \
  --query "ResourceRecordSets[?Name=='app.chewbacca-growl.com.']"

3) Confirm certificate issued
  aws acm describe-certificate \
  --certificate-arn <CERT_ARN> \
  --query "Certificate.Status"

Expected: ISSUED

4) Confirm HTTPS works
  curl -I https://app.chewbacca-growl.com

Expected: HTTP/1.1 200 (or 301 then 200 depending on your app)

What YOU must understand (career point)
This is exactly how companies do it:
  DNS points to ingress
  TLS via ACM
  ALB handles secure public entry
  private compute does the work
  WAF + alarms defend and alert

When students can Terraform this, they’re doing real cloud engineering.


## LAB1C-Bonus-D - Route53 Apex and Logging
#### Deliverables
- [tiqsclass6 - Overview](https://github.com/tiqsclass6)
* [John Sweeney - Deliverables](https://github.com/jastek69/armageddon-C7-LAB1C-H/tree/main/LAB1C-H-DELIVERABLES)


Ready to Suffer? —here’s the next realism bump for Lab 1C-Bonus-D:
  1) Zone apex (chewbacca-growl.com) ALIAS → ALB
  2) ALB access logs → S3 bucket (with the required bucket policy)
  3) A couple of verification commands students can run to prove it’s working

Add this as bonus_b_logging_route53_apex.tf (or append to your existing Route53/logging file).

Add variables (append to variables.tf)
variable "enable_alb_access_logs" {
  description = "Enable ALB access logging to S3."
  type        = bool
  default     = true
}

variable "alb_access_logs_prefix" {
  description = "S3 prefix for ALB access logs."
  type        = string
  default     = "alb-access-logs"
}

Add file: bonus_b_logging_route53_apex.tf (go to Folder)

Patch reminder (students must modify the existing ALB resource)
Terraform can’t “append” nested blocks, so they must edit:
In bonus_b.tf, inside resource "aws_lb" "chewbacca_alb01" { ... } add:

  # Explanation: Chewbacca keeps flight logs—ALB access logs go to S3 for audits and incident response.
  access_logs {
    bucket  = aws_s3_bucket.chewbacca_alb_logs_bucket01[0].bucket
    prefix  = var.alb_access_logs_prefix
    enabled = var.enable_alb_access_logs
  }

Outputs (append to outputs.tf)

# Explanation: The apex URL is the front gate—humans type this when they forget subdomains.
output "chewbacca_apex_url_https" {
  value = "https://${var.domain_name}"
}

# Explanation: Log bucket name is where the footprints live—useful when hunting 5xx or WAF blocks.
output "chewbacca_alb_logs_bucket_name" {
  value = var.enable_alb_access_logs ? aws_s3_bucket.chewbacca_alb_logs_bucket01[0].bucket : null
}

Student verification (CLI) — DNS + Logs
1) Verify apex record exists
  aws route53 list-resource-record-sets \
    --hosted-zone-id <ZONE_ID> \
    --query "ResourceRecordSets[?Name=='chewbacca-growl.com.']"

2) Verify ALB logging is enabled
  aws elbv2 describe-load-balancers \
    --names chewbacca-alb01 \
    --query "LoadBalancers[0].LoadBalancerArn"

Then:
  aws elbv2 describe-load-balancer-attributes \
  --load-balancer-arn <ALB_ARN>

  Expected attributes include:
  access_logs.s3.enabled = true
  access_logs.s3.bucket = your bucket
  access_logs.s3.prefix = your prefix

3) Generate some traffic
  curl -I https://chewbacca-growl.com
  curl -I https://app.chewbacca-growl.com

4) Verify logs arrived in S3 (may take a few minutes)
  aws s3 ls s3://<BUCKET_NAME>/<PREFIX>/AWSLogs/<ACCOUNT_ID>/elasticloadbalancing/ --recursive | head


Why this matters to YOU (career-critical point)
This is incident response fuel:
  Access logs tell you:
    client IPs
    paths
    response codes
    target behavior
    latency

Combined with WAF logs/metrics and ALB 5xx alarms, you can do real triage:
  “Is it attackers, misroutes, or downstream failure?”




## LAB1C-Bonus-E - WAF
#### Deliverables
- [tiqsclass6 - Overview](https://github.com/tiqsclass6)
* [John Sweeney - Deliverables](https://github.com/jastek69/armageddon-C7-LAB1C-H/tree/main/LAB1C-H-DELIVERABLES)

Key update since “the old days”: AWS WAF logging can go directly to CloudWatch Logs, S3, or Kinesis Data Firehose, 
and you can associate one destination per Web ACL. Also, the destination name must start with aws-waf-logs-. 


Terraform supports this with aws_wafv2_web_acl_logging_configuration. 
Terraform Registry

Below is Lab 1C-Bonus-E (continued): WAF logging in Terraform (with toggles), plus verification commands.

1) Add variables (append to variables.tf)
variable "waf_log_destination" {
  description = "Choose ONE destination per WebACL: cloudwatch | s3 | firehose"
  type        = string
  default     = "cloudwatch"
}

variable "waf_log_retention_days" {
  description = "Retention for WAF CloudWatch log group."
  type        = number
  default     = 14
}

variable "enable_waf_sampled_requests_only" {
  description = "If true, students can optionally filter/redact fields later. (Placeholder toggle.)"
  type        = bool
  default     = false
}


2) Add file: bonus_b_waf_logging.tf (Look in Folder)

This provides three skeleton options (CloudWatch / S3 / Firehose). Students choose one via var.waf_log_destination.


3) Outputs (append to outputs.tf)
# Explanation: Coordinates for the WAF log destination—Chewbacca wants to know where the footprints landed.
output "chewbacca_waf_log_destination" {
  value = var.waf_log_destination
}

output "chewbacca_waf_cw_log_group_name" {
  value = var.waf_log_destination == "cloudwatch" ? aws_cloudwatch_log_group.chewbacca_waf_log_group01[0].name : null
}

output "chewbacca_waf_logs_s3_bucket" {
  value = var.waf_log_destination == "s3" ? aws_s3_bucket.chewbacca_waf_logs_bucket01[0].bucket : null
}

output "chewbacca_waf_firehose_name" {
  value = var.waf_log_destination == "firehose" ? aws_kinesis_firehose_delivery_stream.chewbacca_waf_firehose01[0].name : null
}


4) Student verification (CLI)
A) Confirm WAF logging is enabled (authoritative)
  aws wafv2 get-logging-configuration \
    --resource-arn <WEB_ACL_ARN>

Expected: LogDestinationConfigs contains exactly one destination.

B) Generate traffic (hits + blocks)
  curl -I https://chewbacca-growl.com/
  curl -I https://app.chewbacca-growl.com/

C1) If CloudWatch Logs destination
  aws logs describe-log-streams \
  --log-group-name aws-waf-logs-<project>-webacl01 \
  --order-by LastEventTime --descending

Then pull recent events:
  aws logs filter-log-events \
  --log-group-name aws-waf-logs-<project>-webacl01 \
  --max-items 20

C2) If S3 destination
  aws s3 ls s3://aws-waf-logs-<project>-<account_id>/ --recursive | head

C3) If Firehose destination
  aws firehose describe-delivery-stream \
  --delivery-stream-name aws-waf-logs-<project>-firehose01 \
  --query "DeliveryStreamDescription.DeliveryStreamStatus"

And confirm objects land:
  aws s3 ls s3://<firehose_dest_bucket>/waf-logs/ --recursive | head

5) Why this makes incident response “real”
Now you can answer questions like:
  “Are 5xx caused by attackers or backend failure?”
  “Do we see WAF blocks spike before ALB 5xx?”
  “What paths / IPs are hammering the app?”
  “Is it one client, one ASN, one country, or broad?”
  “Did WAF mitigate, or are we failing downstream?”

This is precisely why WAF logging destinations include CloudWatch Logs (fast search) and S3/Firehose (archive/SIEM pipeline)










## LAB1C-Bonus-F Cloudwatch
#### Deliverables
- [tiqsclass6 - Overview](https://github.com/tiqsclass6)
* [John Sweeney - Deliverables](https://github.com/jastek69/armageddon-C7-LAB1C-H/tree/main/LAB1C-H-DELIVERABLES)

Here’s a CloudWatch Logs Insights query pack you can drop straight into the Lab 1C-Bonus-B incident runbook.

Two important notes up front:
  CloudWatch Logs Insights works only on logs that are in CloudWatch Logs.
  So this pack covers:
    WAF logs (when you chose waf_log_destination="cloudwatch")
    App logs (your /aws/ec2/<prefix>-rds-app group)

  ALB access logs are in S3, not CloudWatch Logs (unless you also ship them to CW via another pipeline).
    For ALB, you’ll correlate via:
      CloudWatch metrics (5xx alarm + metrics)
      and optionally Athena later (if you want the full CBRE-style “log lake” workflow)


Lab 1C-Bonus-F: Logs Insights Query Pack
Variables students fill in (for the runbook)
  WAF log group: aws-waf-logs-<project>-webacl01
  App log group: /aws/ec2/<project>-rds-app

Requirements: Set the time range to Last 15 minutes (or match incident window).

A) WAF Queries (CloudWatch Logs Insights)
A1) “What’s happening right now?” (Top actions: ALLOW/BLOCK)
  fields @timestamp, action
  | stats count() as hits by action
  | sort hits desc

A2) Top client IPs (who is hitting us the most?)
  fields @timestamp, httpRequest.clientIp as clientIp
| stats count() as hits by clientIp
| sort hits desc
| limit 25

A3) Top requested URIs (what are they trying to reach?)
  fields @timestamp, httpRequest.uri as uri
| stats count() as hits by uri
| sort hits desc
| limit 25

A4) Blocked requests only (who/what is being blocked?)
  fields @timestamp, action, httpRequest.clientIp as clientIp, httpRequest.uri as uri
| filter action = "BLOCK"
| stats count() as blocks by clientIp, uri
| sort blocks desc
| limit 25

A5) Which WAF rule is doing the blocking?
  fields @timestamp, action, terminatingRuleId, terminatingRuleType
| filter action = "BLOCK"
| stats count() as blocks by terminatingRuleId, terminatingRuleType
| sort blocks desc
| limit 25

A6) Rate of blocks over time (did it spike?)
  fields @timestamp, httpRequest.clientIp as clientIp, httpRequest.uri as uri
| filter uri like /wp-login|xmlrpc|\.env|admin|phpmyadmin|\.git|\/login/i
| stats count() as hits by clientIp, uri
| sort hits desc
| limit 50

#edit
fields @timestamp, httpRequest.clientIp as clientIp, httpRequest.uri as uri | filter uri =~ /wp-login|xmlrpc|\.env|admin|phpmyadmin|\.git|login/ | stats count() as hits by clientIp, uri | sort hits desc | limit 50

A7) Suspicious scanners (common patterns: admin paths, wp-login, etc.)
  fields @timestamp, httpRequest.clientIp as clientIp, httpRequest.uri as uri
| filter uri like /wp-login|xmlrpc|\.env|admin|phpmyadmin|\.git|\/login/i
| stats count() as hits by clientIp, uri
| sort hits desc
| limit 50

A8) Country/geo (if present in your WAF logs)
Some WAF log formats include httpRequest.country. If yours does:
  fields @timestamp, httpRequest.country as country
| stats count() as hits by country
| sort hits desc
| limit 25

B) App Queries (EC2 app log group)
These assume your app logs include meaningful strings like ERROR, DBConnectionErrors, timeout, etc
(You should enforce this.)

B1) Count errors over time (this should line up with the alarm window)
  fields @timestamp, @message
| filter @message like /ERROR|Exception|Traceback|DB|timeout|refused/i
| stats count() as errors by bin(1m)
| sort bin(1m) asc

B2) Show the most recent DB failures (triage view)
  fields @timestamp, @message
| filter @message like /DB|mysql|timeout|refused|Access denied|could not connect/i
| sort @timestamp desc
| limit 50

B3) “Is it creds or network?” classifier hints
  Credentials drift often shows: Access denied, authentication failures
  Network/SecurityGroup often shows: timeout, refused, “no route”, hang
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


B4) Extract structured fields (Requires log JSON)
If you log JSON like: {"level":"ERROR","event":"db_connect_fail","reason":"timeout"}:
  fields @timestamp, level, event, reason
| filter level="ERROR"
| stats count() as n by event, reason
| sort n desc

(Thou Shalt need to emit JSON logs for this one.)

C) Correlation “Enterprise-style” mini-workflow (Runbook Section)
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
  curl https://app.chewbacca-growl.com/list works








## LAB1C-Bonus-G Cloudwatch + Bedrock
#### Deliverables
- [tiqsclass6 - Overview](https://github.com/tiqsclass6)
* [John Sweeney - Deliverables](https://github.com/jastek69/armageddon-C7-LAB1C-H/tree/main/LAB1C-H-DELIVERABLES)


Bedrock-powered “auto-IR” pipeline for advanced students who can actually build and demo.

The pattern below is what real orgs do: alarm → evidence collection → LLM summarization → report artifact → notify.
This will be given to you

1) Incident report template (structured, consistent, gradeable)
2) Integration framework (AWS architecture + flow)
3) Terraform skeleton resources (Chewbacca naming)
4) Lambda handler skeleton (Python) that:
    pulls alarm context
    runs CloudWatch Logs Insights queries (WAF + app)
    pulls known-good values from SSM + Secrets
    calls Bedrock Runtime InvokeModel 
    writes report to S3
    notifies via SNS
Prompt pack (so reports are high signal, not vibes)

1) Auto-generated Incident Report Template (Markdown)
You must output exact headings (easy to implement).
--> 1c_bonus-G_Bedrock.template.md


2) Integration Framework (Bedrock “Auto-IR”)
Event-driven flow
    1) CloudWatch Alarm goes to ALARM
    2) Alarm triggers SNS topic (you already have this)
    3) SNS triggers a Lambda “IncidentReporter”
    4) Lambda:
        Pulls alarm metadata from event payload
        Runs Logs Insights queries via StartQuery/GetQueryResults 
        Fetches config from SSM and Secrets Manager
        Calls Bedrock Runtime to generate the report 
        Writes Markdown + JSON evidence bundle to S3
        Publishes a “Report Ready” message to SNS (link to S3 object)

Two modes (advanced students can implement both)
    Mode A: “Fast report” (15-min window, small evidence)
    Mode B: “Deep report” (60-min window + WAF correlation + top URIs + error clustering)

Optional extra-credit: use Bedrock Agents + Knowledge Base to ingest your runbook and “recommend steps.”
# https://aws.amazon.com/blogs/machine-learning/automate-it-operations-with-amazon-bedrock-agents/?utm_source=chatgpt.com

3) Terraform Skeleton Add-on (Chewbacca naming)
Add file: bonus_G_bedrock_autoreport.tf (Folder)

4) Lambda “IncidentReporter” skeleton (Python)
Create handler.py and zip it for Terraform. (Folder)

This uses:
CloudWatch Logs Insights StartQuery/GetQueryResults 
Bedrock invoke_model via bedrock-runtime client

Note: Bedrock request body differs by model family; the framework is correct but students must adapt to the chosen model’s request schema. AWS documents InvokeModel and the runtime client.
Documentation: https://docs.aws.amazon.com/bedrock/latest/userguide/inference-invoke.html?utm_source=chatgpt.com

5) Bedrock Prompt Pack (so reports don’t hallucinate)
Include these rules in the prompt (non-negotiable):
    “Use ONLY evidence”
    “If unknown, say Unknown”
    “Include confidence levels”
    “Recommend next evidence to pull”

And add a “grading” rubric line:
    “Report must cite which query/field supports each key claim”

6) Advanced grading criteria (for your top students)
They pass “advanced” if:
    They produce both JSON evidence + Markdown report
    Report has no invented claims
    Report includes root cause classification that matches injected failure
    They redact secrets (password never appears)
    They add a second pass: “preventive actions” tied to evidence (e.g., rotation automation, SG drift detection)

Optional upgrade: Bedrock Agents + Knowledge Base (very real)
You need to store:
    runbooks (Markdown)
    common incident patterns
        in a Knowledge Base, then an Agent can recommend steps. AWS has a reference blog for automating IT ops with Agents.
Documenation: https://aws.amazon.com/blogs/machine-learning/automate-it-operations-with-amazon-bedrock-agents/?utm_source=chatgpt.com





## LAB1C-Bonus-H Bedrock Auto-Generated Incident Reports
#### Deliverables
- [tiqsclass6 - Overview](https://github.com/tiqsclass6)
* [John Sweeney - Deliverables](https://github.com/jastek69/armageddon-C7-LAB1C-H/tree/main/LAB1C-H-DELIVERABLES)


What you’re building:

When an alarm fires, you will automatically:
  1) collect evidence (alarm metadata + Logs Insights + param/secret reads)
  2) generate a structured incident report using Amazon Bedrock Runtime InvokeModel 
  3) store report + evidence bundle to S3
  4) notify the on-call engineer (SNS)

Why it matters
This is how mature companies reduce MTTR:
  A) evidence collection is automated (less guesswork)
  B) postmortems are consistent (better prevention)
  C) alerts include context (fewer “what’s happening?” pages)

1) The “Integration Contract” (what Lambda must output)
You must write two objects to S3:

A) Evidence bundle (JSON)
s3://<bucket>/reports/<incident_id>.json

Must contain:
  1) incident_id
  2) time_window_utc (start/end)
  3) alarm (name, metric, threshold, state)
  4) queries: results for WAF + app Logs Insights
  5) ssm_params (endpoint/port/name)
  6) secret_meta (host/port/dbname/username only — no password)

B) Human report (Markdown)
s3://<bucket>/reports/<incident_id>.md

Must follow your template headings exactly.

2) The Logs Insights Query Pack (Minimum required)
Your Lambda must run at least these via Logs Insights:
  App: error rate over time (bin 1m)
  App: latest 50 DB-related error lines
  WAF: allow vs block
  WAF: top blocked IP/URI pairs

This is built on StartQuery + GetQueryResults.

3) Bedrock invocation: two supported paths (You need to pick one)

Critical reality: Bedrock request bodies differ per model provider/family. 
AWS explicitly warns that models differ in what they accept/return. 
Documentation: https://docs.aws.amazon.com/bedrock/latest/userguide/inference-invoke.html?utm_source=chatgpt.com


Option 1: Anthropic Claude via Bedrock “messages” style payload
Use AWS’s own examples as the canonical reference. 
AWS Documentation: https://docs.aws.amazon.com/bedrock/latest/userguide/bedrock-runtime_example_bedrock-runtime_InvokeModel_AnthropicClaude_section.html?utm_source=chatgpt.com


Python snippet (framework): claude.py (folder)

Option 2: “Generic” InvokeModel (students adapt)
This exists to teach them to read provider-specific schemas and not cargo-cult. Start here, then adapt based on the model chosen

4) Lambda packaging: the clean “class-safe” way
Directory

lambda_ir_reporter/
  handler.py
  requirements.txt   (optional)
  build.sh
  lambda_ir_reporter.zip


build.sh (students run locally)


#!/usr/bin/env bash
set -euo pipefail

rm -rf build lambda_ir_reporter.zip
mkdir -p build

cp handler.py build/

# If you add external deps (usually you don't need any for boto3):
# pip install -r requirements.txt -t build/

cd build
zip -r ../lambda_ir_reporter.zip .
cd ..


Then in Terraform:
  filename = "lambda_ir_reporter.zip"

5) “Fake alarm event” test harness (no waiting for real alarms)
SNS → Lambda payloads can vary, so students should make Lambda accept:
  direct SNS event (Records[0].Sns.Message)
  or direct test JSON

Local test event (paste into Lambda console “Test”)

{
  "Records": [
    {
      "Sns": {
        "Subject": "ALARM: chewbacca-alb-5xx-alarm01",
        "Message": "{\"AlarmName\":\"chewbacca-alb-5xx-alarm01\",\"NewStateValue\":\"ALARM\",\"NewStateReason\":\"Threshold crossed\",\"StateChangeTime\":\"2025-12-27T16:00:00Z\"}"
      }
    }
  ]
}

Lambda parsing pattern (required) 

def parse_alarm_event(event):
    # SNS wrapped?
    if "Records" in event and event["Records"] and "Sns" in event["Records"][0]:
        msg = event["Records"][0]["Sns"]["Message"]
        try:
            return json.loads(msg)
        except json.JSONDecodeError:
            return {"raw_message": msg}
    return event

6) How students validate success (objective)
A) Confirm Lambda invoked
  aws logs tail /aws/lambda/<function-name> --since 10m

B) Confirm report objects exist
  aws s3 ls s3://<REPORT_BUCKET>/reports/ --recursive | tail

C) Open the report
  aws s3 cp s3://<REPORT_BUCKET>/reports/<incident_id>.md -

D) Confirm the evidence bundle does NOT include secrets
  aws s3 cp s3://<REPORT_BUCKET>/reports/<incident_id>.json - | grep -i password && echo "FAIL"


7) “No hallucinations” enforcement (advanced requirement)
Inside the prompt you give Bedrock, include:
  “Use only evidence”
  “If unknown, say Unknown”
  “Cite the evidence key used for each claim”

This matches the Bedrock guidance that you pass model-specific inference parameters in the request body—students must shape the prompt accordingly.

8) Add the missing Terraform glue (SNS publish + report-ready)
You already have SNS and Lambda wired. Add a second SNS message (optional but fun):
  Subject: IR Report Ready
  Message: S3 path + incident_id

This is just sns.publish(...) (you already used it).

9) Upgrade path (extra credit, very “enterprise”)
A) Attach the report to the incident thread
  send the S3 path in SNS email
  or publish to Slack via webhook (optional)

B) Add a “Deep report” mode
  Run 60-minute window queries
  Add top URIs, top IPs, block rate bins
  Add ALB metrics query (GetMetricData)

C) Add WAF redaction / filtering
AWS WAF supports redacted fields and filtering when enabling logging.
Documentation: https://docs.aws.amazon.com/waf/latest/developerguide/logging-destinations.html?utm_source=chatgpt.com




## LAB1C-Bonus-I Auto-IR Runbook
#### Deliverables

* [John Sweeney - Deliverables](https://github.com/jastek69/armageddon-C7-LAB1C-H/tree/main/LAB1C-H-DELIVERABLES)


Human + Amazon Bedrock Incident Response

Purpose
This runbook defines how a human on-call engineer uses the Bedrock-generated incident report safely, verifies it against raw evidence, and produces a final, auditable incident artifact.

Core rule:
Bedrock accelerates analysis. Humans own correctness.






---

## [🌐 LAB2]
#### Deliverables
- [tiqsclass6 - Overview](https://github.com/tiqsclass6)
- [John Sweeney LAB2 - DELIVERABLES](https://github.com/jastek69/Armageddon-C7-SEIR_Foundations/tree/LAB2/LAB2-DELIVERABLES)
- [John Sweeney LAB2 - Code](https://github.com/jastek69/Armageddon-C7-SEIR_Foundations)


### Repurpose

* Build on **Be A Man 1.1**
* Connect to the **running EC2 instance** via SSH
* Use **Vim** to edit `/var/www/html/index.html`
* Add additional deliverables (wife, yacht, motivation)

### Tasker 2

### HW - Be A Man Challenge 1.2 (10 pts)

* Must be in a GitHub repo link

* Modify the currently running web server from 1.1 to add:

  ```plaintext
  "I found my wife on a party yacht in <insert location here>! 
  Her name is <insert name here>!"
  ```

* Include a picture of the **woman you will have 5 sons by after making your cloud money**

---

## [🌐 LAB 3] AWS - Transit Gateway
- [tiqsclass6 - Overview](https://github.com/tiqsclass6)
- [John Sweeney LAB3 - Deliverables](https://github.com/jastek69/Armageddon-C7-Lab3-SEIR_Foundations/tree/main/LAB3-DELIVERABLES)
- [John Sweeney LAB3 - Code](https://github.com/jastek69/Armageddon-C7-Lab3-SEIR_Foundations/tree/main)


## 📝 Summary

Lab 3 — Japan Medical
Cross-Region Architecture with Legal Data Residency (APPI Compliance)
Scenario Overview
  A Japanese medical organization operates:
  A primary medical data system in Tokyo
  A satellite medical office in São Paulo
  A single global application URL: chewbacca-growls.com
  Global access via CloudFront
  Strict legal requirement:
    All Japanese patient medical data (PHI) must remain physically stored in Japan

This is not a theoretical exercise.
This is how regulated global healthcare systems are actually built.

Why This Lab Exists (Read This Carefully)
Japan’s privacy law — 個人情報保護法 (APPI) — requires that personally identifiable medical information for Japanese citizens must not be stored outside Japan, unless extremely specific legal mechanisms are in place.

For healthcare:
  The safe, standard interpretation is:
    Store PHI only inside Japan

Even if:
    The patient is traveling
    The doctor is overseas
    The application is globally accessible

📌 Access is allowed. Storage is not.
That single sentence is the key mental shift.

Legal Reality → Architectural Consequence

Because of APPI:
| Component             | Allowed Location                           |
| --------------------- | ------------------------------------------ |
| RDS (Medical Records) | **Tokyo only** (`ap-northeast-1`)          |
| Backups / snapshots   | **Tokyo only**                             |
| Read replicas         | ❌ Not allowed outside Japan                |
| App access            | ✅ Allowed globally                         |
| CloudFront            | ✅ Allowed (edge cache, no PHI persistence) |
| EC2 in São Paulo      | ✅ Allowed (stateless compute only)         |

This forces a hub-and-spoke architecture:
  Tokyo is the data authority
  Other regions are compute-only extensions

Regional Architecture Breakdown
🇯🇵 Tokyo — Primary Region (ap-northeast-1)
Tokyo hosts everything that touches patient data at rest:
    RDS (MySQL / PostgreSQL)
    Primary VPC
    Application tier (EC2 / ASG)
    Transit Gateway attachment
    Parameter Store & Secrets Manager (authoritative)
    Logging, auditing, backups

Tokyo is the single source of truth.
If Tokyo goes down:
    The system degrades
    But data residency is never violated

This is intentional.

🇧🇷 São Paulo — Satellite Region (sa-east-1)
São Paulo exists only to improve access latency for doctors and staff physically located there.
São Paulo contains:
    VPC
    EC2 + Auto Scaling Group
    No databases
    No local persistence of PHI
    No backups
    No replicas

Every read/write:
    Traverses the AWS backbone
    Goes directly to Tokyo RDS
    Is encrypted in transit
    Is logged and auditable
São Paulo is stateless compute.

Why Transit Gateway Is Used (Not VPC Peering)
At this scale and sensitivity:
    VPC peering becomes brittle
    Routing rules multiply
    Auditing cross-region flows becomes harder
Transit Gateway provides:
    Centralized routing
    Explicit control of allowed paths
    Clear inspection points
    Enterprise-grade segmentation
In regulated environments:
    Transit Gateway is preferred because it creates a visible, controllable data corridor.

That matters for audits.

CloudFront’s Role (Single URL, Multiple Regions)
  There is only one public URL: https://chewbacca-growls.com

CloudFront:
    Terminates TLS
    Applies WAF
    Routes users to the nearest healthy region
    Never stores PHI
    Only caches:
        Static assets
        Non-sensitive responses
        Content explicitly marked cacheable

  CloudFront is legally safe because:
    It is not a data stor
    It does not persist medical records
    It respects cache control rules

Data Flow (End-to-End)

Let’s walk a real example.

Example: Japanese patient visiting São Paulo
    1. Patient visits clinic in São Paulo
    2. Doctor opens chewbacca-growls.com
    3. CloudFront routes request to São Paulo EC2
    4. São Paulo EC2:
        Authenticates request
        Does not store PHI locally
        Opens encrypted connection to Tokyo RDS via Transit Gateway
    5. Data is read/written only in Tokyo
    6. Response is returned to São Paulo doctor

At no point:
    Is PHI stored outside Japan
    Is data replicated
    Is a local database created

This satisfies APPI compliance.

Why This Is the Correct Tradeoff
What Japan cares about
    Data sovereignty
    Auditability
    Legal certainty

What the business cares about
    Doctors can work where patients are
    Latency is reasonable
    Single global app
    No duplicated systems

This architecture:
    Accepts slightly higher latency
    In exchange for legal compliance and operational simplicity

That is the correct trade in healthcare.

What Would Be Illegal (And Why)

❌ RDS Read Replica in São Paulo
→ Data at rest outside Japan

❌ Aurora Global Database
→ Storage replication outside Japan

❌ Local cache of patient records on EC2 disk
→ Persistent PHI outside Japan

❌ CloudFront caching PHI
→ Edge persistence outside Japan

These are not “bad practices.”
They are compliance violations.

Why This Lab Matters for Your Career
  Most engineers:
    Learn “multi-region for availability”
    Learn “replicate everything everywhere”

Regulated reality is different.
This lab teaches you to:
    Translate law into architecture
    Design global systems with asymmetric constraints
    Explain why a slower design is the correct one
    Speak confidently to:
      Security
      Legal
      Compliance
      Auditors

If you can explain this architecture clearly, you are senior-level.

How to Talk About This in an Interview

    “I designed a multi-region medical application where all PHI remained in Japan to comply with APPI.
    CloudFront provided global access, São Paulo ran stateless compute only, and all reads/writes traversed a Transit Gateway to Tokyo RDS.
    The design intentionally traded some latency for legal certainty and auditability.”

That answer will stop the room.

One Sentence to Remember
  ---> Global access does not require global storage.

That sentence is the heart of modern regulated cloud architecture.


---

## [🌐 LAB 4] Japan Medical - AWS GCP Integration
- tiqsclass6 - WIP
- John Sweeney LAB3 - WIP



Multi-Cloud Reality in Regulated Healthcare

⚖️ Why This Lab Exists
Many engineers fail in real life because:
    They optimize locally
    They assume uniform platforms
    They treat compliance as “someone else’s problem”

This lab teaches:
    Cross-cloud thinking
    Legal translation into architecture
    Responsibility beyond your own stack
    Professional restraint

🎯 What This Lab Is About

In this lab, you are not solving a technical problem first.
You are solving a human, legal, and organizational problem.

A Japanese medical center operates globally.
    Tokyo is the data authority
    Compliance is non-negotiable
    And now:
      The New York branch refuses to use AWS.

Instead, they deploy on Google Cloud Platform (GCP).
No negotiations. No exceptions.
Your job is not to convince them otherwise.
Your job is to make the system work — legally and responsibly.

🧠 The First Reality: Technology Is Not the Decision
Many engineers assume:
    “If we pick the right platform, the problem goes away.”

In real organizations:
    Technology choices are political
    Vendor preferences exist
    Contracts predate architecture
    Teams have autonomy
    Mergers create fragmentation

You will encounter:
    AWS in one region
    GCP in another
    Azure somewhere else
    Oracle, IBM, OpenShift, or on-prem in legacy branches

📌 Compliance does not change just because technology does.


🏥 Legal Constraint Still Applies (This Does Not Change)
Even in a multi-cloud world:
    --> Japanese patient medical data (PHI) must be stored only in Japan.

This rule does not bend for:
    GCP
    Azure
    “Better latency”
    “Local autonomy”
    “It’s inconvenient”

There is:
    No exemption
    No workaround
    No “temporary” exception


🌎 What the New York Branch Is Allowed to Do
The New York branch (on GCP) may:
    Deploy compute only (VMs, autoscaling groups)
    Serve doctors locally
    Authenticate users
    Process requests in memory
    Call APIs across providers
    Read and write data remotely

The New York branch may not:
    Store patient data at rest
    Deploy databases
    Cache medical records
    Replicate data
    Snapshot, export, or log PHI

This is exactly the same rule as São Paulo — the platform changed, the law did not.

🔗 Connectivity Must Respect Compliance
You are now operating across:
    Cloud providers
    Legal jurisdictions
    Organizational boundaries

The system must ensure:
    Secure connectivity from GCP → Japan
    Clear network paths
    Encryption in transit
    Strong identity and access controls
    Complete auditability

And critically:
    --> No accidental data persistence outside Japan

This includes:
    Disk
    Logs
    Queues
    Caches
    Backups
    Temporary files

🧑‍⚕️ Focus on the Human Experience
    This lab is not just infrastructure.
    You must consider three people:

👩‍⚕️ Doctor (New York)
Expectations:
    Fast, reliable access to patient records
    No concern about where data lives
    No manual compliance steps
    Trust that the system is legal

Risks:
    Latency
    Connectivity failures
    Partial outages

Your responsibility:
    --> Design systems where doctors never have to think about compliance — because you already did.


🧑‍🦽 Patient (Japanese Citizen)
Expectations:
    Their data is protected
    Their data is not exported
    Their rights are respected
    Their records are accurate

Patients do not care about:
    AWS vs GCP
    Cloud vendors
    Network topology

They care about:
    --> Trust

Your responsibility:
    --> Architect in a way that never betrays that trust.

🧑‍💼 Manager / Executive
Expectations:
    Branch autonomy
    Regulatory safety
    No headlines
    No fines
    No “why didn’t you tell us?”

Managers expect engineers to:
    Anticipate risk
    Explain tradeoffs clearly
    Say “no” when required
    Provide defensible designs

Your responsibility:
    --> Make compliance boring and invisible.

🧠 The Core Lesson of Lab 4
    You do not control the technology landscape.
    You control how responsibly it is connected.

Multi-cloud is not a badge of honor.
It is a constraint.

Good engineers complain.
Great engineers adapt without breaking the law.


🗣️ How You Should Talk About This Lab
  If asked in an interview:
      “We supported a medical branch on GCP while keeping all PHI in Japan.
      The branch ran stateless compute only, and all patient data was accessed remotely under strict controls.
      Compliance dictated the architecture — not cloud preference.”

That answer signals maturity.








## ✍️ Authors & Acknowledgments

* **Author and Group Leaders** T.I.Q.S., John Sweeney
* **Team Member:** 
<<<<<<< HEAD


=======
>>>>>>> 604246675bf89273af0f34410a9b6ce78fe9f35b
