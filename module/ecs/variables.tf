variable "cluster_name" {
  type        = string
  description = "The name of the ECS cluster"
  default     = "my-ecs-cluster"
}

variable "kms_key_arn" {
  type        = string
  description = "The ARN of the KMS key for ECS cluster storage encryption"
}

variable "enable_asg_provider" {
  type        = bool
  description = "Toggle to true to deploy and attach the EC2 Auto Scaling Group capacity provider"
  default     = false
}

variable "auto_scaling_group_arn" {
  type        = string
  description = "The ARN of the existing Auto Scaling Group to attach to the capacity provider"
}