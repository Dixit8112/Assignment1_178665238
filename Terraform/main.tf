terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 1.2"
}

provider "aws" {
  region = var.aws_region  # Use the updated variable for the AWS region
}

# Create a subnet
resource "aws_subnet" "primary_subnet" {
  vpc_id            = var.vpc_id  # Updated variable name
  cidr_block        = var.vpc_cidr_block  # Updated variable name
  availability_zone = var.availability_zone  # Updated variable name
}

# Create the Security Group
resource "aws_security_group" "web_app_sg" {
  name        = "web-app-security-group"
  description = "Security group for allowing inbound traffic to the web application"
  vpc_id      = var.vpc_id  # Use the updated variable name

  # Allow inbound traffic on ports 8081, 8082, and 8083
  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8082
    to_port     = 8082
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8083
    to_port     = 8083
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web Application Security Group"
  }
}

# Create the EC2 instance
resource "aws_instance" "web_app_instance" {
  ami                         = var.ec2_image_id  # Updated variable name
  instance_type               = var.ec2_size  # Updated variable name
  key_name                    = aws_key_pair.keyassign1.key_name
  subnet_id                   = aws_subnet.primary_subnet.id  # Corrected to reference the subnet
  security_groups             = [aws_security_group.web_app_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "Web Application EC2 Instance"
  }
}

# Create the ECR repository for MySQL
resource "aws_ecr_repository" "mysql_repo" {
  name                 = var.mysql_repo_name  # Updated variable name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

# Create the ECR repository for the application
resource "aws_ecr_repository" "app_repo" {
  name                 = var.app_repo_name  # Updated variable name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_key_pair" "keyassign1" {
  key_name   = "WebAppKey"
  public_key = file("keyassign1.pub")
}

# Outputs
output "web_app_public_ip" {
  value       = aws_instance.web_app_instance.public_ip
  description = "Public IP address assigned to the web application EC2 instance."
}

output "mysql_repository_url" {
  value       = aws_ecr_repository.mysql_repo.repository_url
  description = "URL for accessing the MySQL ECR repository."
}

output "app_repository_url" {
  value       = aws_ecr_repository.app_repo.repository_url
  description = "URL for accessing the application ECR repository."
}

output "web_app_sg_id" {
  value       = aws_security_group.web_app_sg.id
  description = "ID of the security group associated with the web application EC2 instance."
}
