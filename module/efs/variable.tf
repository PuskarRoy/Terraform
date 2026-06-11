variable "name" {
  description = "Name tag of  EFS"
  type        = string
}

variable "kms_key_id" {
  description = "KMS Key ID"
  type        = string
}

variable "target_subnets" {
  description = "Mount Target for AZs "
  type        = list(string)
}

variable "enable_ipv6" {
  description = "Enable IPv6 for the VPC"
  type        = bool
  default     = false
}

variable "security_group_id" {
  description = "Security group id of Ec2"
  type        = string
}


variable "tags" {
  description = "tags of ec2"
  type        = map(string)
  default     = {}
}