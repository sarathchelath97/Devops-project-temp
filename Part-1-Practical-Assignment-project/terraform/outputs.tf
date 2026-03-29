output "app_server_public_ip" {
  description = "Public IP of the EC2 app server"
  value       = aws_instance.app_server.public_ip
}

output "app_url" {
  description = "URL to access the Flask app"
  value       = "http://${aws_instance.app_server.public_ip}:5000"
}

output "s3_bucket_name" {
  description = "Name of the S3 assets bucket"
  value       = aws_s3_bucket.app_assets.bucket
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}
