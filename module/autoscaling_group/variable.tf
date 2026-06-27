variable "name" {
  description = "Name of the Auto Scaling Group"
  type        = string
}

variable "min_size" {
  description = "Minimum number of instances"
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances"
  type        = number
}

variable "desired_capacity" {
  description = "Desired number of instances"
  type        = number
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ASG"
  type        = list(string)
}

variable "launch_template_id" {
  description = "Launch Template ID"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the ALB/NLB Target Group to attach to the Auto Scaling Group"
  type        = string
}

variable "template_version" {
  description = "Version of Launch Template"
  type        = string
}