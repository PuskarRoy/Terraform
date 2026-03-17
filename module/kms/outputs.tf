output "arn" {
  description = "ARN of the KMS"
  value       = aws_kms_key.this.arn
}

output "id" {
  description = "ID of the KMS"
  value       = aws_kms_key.this.id
}
