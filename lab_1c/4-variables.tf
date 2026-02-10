variable "aws_region" {
  description = "AWS Region for Infrastructure Deployment"
  type        = string
  default     = "ap-southeast-7"
}

variable "project_name" {
  description = "Name prefix for resources"
  type        = string
  default     = "lab1c"
}

variable "vpc_cidr" {
  description = "VPC CIDR Range"
  type        = string
  default     = "10.249.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs (10.249.0.0/24)."
  type        = list(string)
  default     = ["10.249.1.0/24", "10.249.2.0/24", "10.249.3.0/24"] # TODO: student supplies
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs (use 10.x.x.x/xx)."
  type        = list(string)
  default     = ["10.249.11.0/24", "10.249.12.0/24", "10.249.13.0/24"] # TODO: student supplies
}

variable "azs" {
  description = "Availability Zones list."
  type        = list(string)
  default     = ["ap-southeast-7a", "ap-southeast-7b", "ap-southeast-7c"] # TODO: student supplies
}

variable "ec2_ami_id" {
  description = "AMI ID for the EC2 app host."
  type        = string
  default     = "ami-08f4a7fdb312b3bf7" # TODO
}

variable "ec2_instance_type" {
  description = "EC2 instance size for the app."
  type        = string
  default     = "t3.micro"
}

variable "db_engine" {
  description = "RDS engine"
  type        = string
  default     = "mysql"
}

variable "db_instance_class" {
  description = "RDS instance class."
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Initial database name."
  type        = string
  default     = "lab1c_db" # Students can change
}

variable "db_username" {
  description = "DB master username (students should use Secrets Manager in 1B/1C)."
  type        = string
  default     = "admin" # TODO: student supplies
}

variable "db_password" {
  description = "DB master password (DO NOT hardcode in real life; for lab only)."
  type        = string
  sensitive   = true
  default     = "armageddon-blows-6-7" # TODO: student supplies
}

variable "sns_email_endpoint" {
  description = "Email for SNS subscription (PagerDuty simulation)."
  type        = string
  default     = "snailstampede@gmail.com" # TODO: student supplies
}