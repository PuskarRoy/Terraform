output "id" {
  description = "Id of launch Template"
  value       = aws_launch_template.this.id
}

output "version" {
  description = "version of launch template"
  value = aws_launch_template.this.latest_version
}