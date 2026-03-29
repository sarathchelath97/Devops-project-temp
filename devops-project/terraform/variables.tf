variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name prefix for all resources"
  type        = string
  default     = "flask-devops"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "production"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "Ubuntu 22.04 LTS AMI (update per region)"
  type        = string
  default     = "ami-0c7217cdde317cfec"  # us-east-1 Ubuntu 22.04
}

variable "key_pair_name" {
  description = "EC2 Key Pair name for SSH access"
  type        = string
}

variable "my_ip" {
  description = "Your public IP for SSH access (e.g. 203.0.113.5/32)"
  type        = string
}

variable "github_repo" {
  description = "GitHub repo (owner/repo) to clone on EC2"
  type        = string
  default     = "your-username/devops-project"
}
