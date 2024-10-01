# Output the public IP of the EC2 instance
output "public_ip_of_webapp" {
  value       = aws_instance.web_app_instance.public_ip
  description = "Public IP address assigned to the web application EC2 instance."
}

# Output the ECR repository URL for MySQL
output "url_mysql_repository" {
  value       = aws_ecr_repository.mysql_repo.repository_url
  description = "URL for accessing the MySQL ECR repository."
}

# Output the ECR repository URL for the application
output "url_app_repository" {
  value       = aws_ecr_repository.app_repo.repository_url
  description = "URL for accessing the application ECR repository."
}

# Output the security group ID
output "sg_id_web_app" {
  value       = aws_security_group.web_app_sg.id
  description = "ID of the security group associated with the web application EC2 instance."
}
