output "arn" {
  description = "ARN of the SNS topic"
  value       = aws_sns_topic.this.arn
}

output "id"{
  description = "ARN of the SNS topic"
  value       = aws_sns_topic.this.id
}