![AWS](https://img.shields.io/badge/AWS-Cloud-orange?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-%E2%89%A51.9-844FBA?style=for-the-badge&logo=terraform&logoColor=white)
![CloudFront](https://img.shields.io/badge/CloudFront-Edge_Security-yellow?style=for-the-badge&logo=amazon-aws)
![WAFv2](https://img.shields.io/badge/AWS_WAFv2-Real_Time_Logging-red?style=for-the-badge&logo=amazonaws)
![Bedrock](https://img.shields.io/badge/Amazon_Bedrock-Auto_IR-black?style=for-the-badge&logo=amazon-aws)
![Multi_Region](https://img.shields.io/badge/Multi_Region-Transit_Gateway-blue?style=for-the-badge)
![Compliance](https://img.shields.io/badge/Compliance-HIPAA_Inspired-purple?style=for-the-badge)
![Observability](https://img.shields.io/badge/Observability-CloudWatch_&_Bedrock-green?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Production_Grade-success?style=for-the-badge)


#   Lab 3A - 3B Armageddon Class 7.0

***I designed a cross-region medical system where all PHI remained in Japan to comply with APPI.
    Tokyo hosted the database, São Paulo ran stateless compute, and Transit Gateway provided a controlled data corridor.
    CloudFront delivered a single global URL without violating data residency.***

##  Lab 3A — TGW Between Tokyo + São Paulo (RDS in Tokyo Only)
### Transit Gateway is regional.
    1. TGW in Tokyo
    2. TGW in São Paulo
    3. TGW Peering Attachment between them
    4. Each VPC attaches to its local TGW
    5. Routes propagate across the peering

### Lab 3A Deliverables:
**Test network reachability to Tokyo RDS from SSM Sao Paulo EC2 & Confirm routes (AWS CLI) :**

https://github.com/user-attachments/assets/68fbbc05-d80e-4252-99e8-5ec91649ea8d

*NC (Network Connectivity) & Route Tables*

![3A-nc-route-tables](https://github.com/MichaelDale1/Class-7-Armageddon-2026-Dale/raw/Lab-3A-and-3B/Lab-3A-Artifacts/3A-nc-route-tables.png)



*Sao-Paulo-EC2-adds-notes-to-Tokyo-RDS-via-TGW*

![3A-Sao-Paulo-EC2-adds-notes-to-Tokyo-RDS-via-TGW](https://github.com/MichaelDale1/Class-7-Armageddon-2026-Dale/raw/Lab-3A-and-3B/Lab-3A-Artifacts/3A-Sao-Paulo-EC2-adds-notes-to-Tokyo-RDS-via-TGW.png)



#### Python Scripts verifies proper infrastructure

**Video Scripts 1-5:**

https://github.com/user-attachments/assets/cc4f3844-791a-4698-9e76-112aef498a84

*3B Audit Deliverables before Python Scripts*

![3B-1-RDS-Residency-2-Edge-Proof-3-WAF-Proof](https://github.com/MichaelDale1/new-jenkins-s3-test/raw/main/Lab-3B-Artifacts/3B-1-RDS-Residency-2-Edge-Proof-3-WAF-Proof.png)


*Verfication is Duplicated by Python Script 1*

![3b-Data-Residency-Python-Script-1](https://github.com/MichaelDale1/new-jenkins-s3-test/raw/main/Lab-3B-Artifacts/3b-Data-Residency-Python-Script-1.png)

*3B-TGW-Attachment-Python-Script-2 Results*

![3B-TGW-Attachment-Python-Script-1](https://github.com/MichaelDale1/new-jenkins-s3-test/raw/main/Lab-3B-Artifacts/3B-TGW-Attachment-Python-Script-1.png)

*3B-Cloudtrail-Python-Script-3*

![3B-Cloudtrail-Python-Script-3](https://github.com/MichaelDale1/new-jenkins-s3-test/raw/main/Lab-3B-Artifacts/3B-Cloudtrail-Python-Script-3.png)

*3B-WAF-Logs-Python-Script-4*

![3B-WAF-Logs-Python-Script-4](https://github.com/MichaelDale1/new-jenkins-s3-test/raw/main/Lab-3B-Artifacts/3B-WAF-Logs-Python-Script-4.png)

*3B-Cloudfront-Logs-Python-Script-5*

![3B-Cloudfront-Logs-Python-Script-5](https://github.com/MichaelDale1/new-jenkins-s3-test/raw/main/Lab-3B-Artifacts/3B-Cloudfront-Logs-Python-Script-5.png)






#   Lab-2B-Be-A-Man-C Armageddon Class 7.0
#   Lab-2B_Be_A_Man-B Armageddon Class 7.0
#   Lab-2B_Be_A_Man-A Armageddon Class 7.0
#   Lab-2A-with-Health-Check-Logs Armageddon Class 7.0
#   Lab-1C-Bonus-G Armageddon Class 7.0
#   Lab-1C-Bonus-F Armageddon Class 7.0
#   Lab-1C-Bonus-E Armageddon Class 7.0
#   Lab-1C-Bonus-D Armageddon Class 7.0
#   Lab-1C-Bonus-C Armageddon Class 7.0
#   Lab-1C-Bonus-B Armageddon Class 7.0
#   Lab-1C-Bonus-A Armageddon Class 7.0
#   Lab-1C Armageddon Class 7.0
#   Lab-1B Armageddon Class 7.0
#   Lab-1A Armageddon Class 7.0


#
#
#