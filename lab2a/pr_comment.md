### SEIR Lab 2 (ALB Origin) Gate Result: **RED** (FAIL)

**Domain:** `aster-project.site`  
**CloudFront:** `E2I43XW8O3TESS` → `d3r078ts9u69ls.cloudfront.net`  
**ALB:** `arn:aws:elasticloadbalancing:us-east-2:571938892172:loadbalancer/app/lab2a-alb01/e431179543458306` (scheme=`internet-facing`)  
**ALB SG:** `sg-0736ea0cc0f7f47ba`  

**Failures (fix in order)**
- FAIL: WAF WebACL not associated with CloudFront.
- FAIL: Route53 A alias target mismatch (expected=d3r078ts9u69ls.cloudfront.net actual=d3r078ts9u69ls.cloudfront.net.).
- FAIL: Route53 AAAA alias target mismatch (expected=d3r078ts9u69ls.cloudfront.net actual=d3r078ts9u69ls.cloudfront.net.).
- FAIL: ALB scheme is not internal (scheme=internet-facing).

**Warnings**
- (none)

> Reminder: If the ALB is public or world-open, CloudFront is decorative, not protective.
