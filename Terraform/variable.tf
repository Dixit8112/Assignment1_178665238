# Define the AWS region where resources will be created
variable "aws_region" {
  default     = "us-east-1"
}

# Define the AMI to use for the EC2 instance
variable "ec2_image_id" {
  type        = string
  default     = "ami-0427090fd1714168b"
}

# Define the EC2 instance size (e.g., t2.micro)
variable "ec2_size" {
  type        = string
  default     = "t2.micro"
}

# Define a variable for the ECR repository name for MySQL
variable "mysql_repo_name" {
  type        = string
  default     = "image-mysql-repo"
}

# Define a variable for the ECR repository name for the application
variable "app_repo_name" {
  type        = string
  default     = "image-app-repo"
}

# Define the VPC ID for resource creation
variable "vpc_id" {
  default     = "vpc-0823ffa321525fe46"
  type        = string
}

# Define the CIDR block for the VPC
variable "vpc_cidr_block" {
  default     = "172.31.16.0/20"
  type        = string
}

# Define the availability zone for resource deployment
variable "availability_zone" {
  default     = "us-east-1a"
  type        = string
}
