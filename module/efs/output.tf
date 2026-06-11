output "dns_name" {
  description = "DNS name of the EFS file system"
  value       = aws_efs_file_system.this.dns_name
}

output "arn" {
  description = "ARN of the EFS file system"
  value       = aws_efs_file_system.this.arn
}

output "id" {
  description = "ID of the EFS file system"
  value       = aws_efs_file_system.this.id
}