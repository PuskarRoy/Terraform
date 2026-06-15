variable "template_name" {
  description = "Launch template name"
  type        = string
}

variable "description" {
  description = "Launch template description"
  type        = string
  default     = null
}

variable "iam_instance_profile" {
  description = "IAM instance profile name"
  type        = string
}

variable "ami" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "keypair_name" {
  description = "EC2 key pair name"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID"
  type        = string
}

variable "update_default_version" {
  description = "Whether to update the default version of the launch template"
  type        = bool
  default     = false
}

variable "user_data" {
  description = "user data"
  type        = string
  default     = null
}

variable "kms_key_id" {
  description = "KMS Key ARN or ID used to encrypt EBS volumes"
  type        = string
}

variable "resource_tags" {
  description = "Define VPC tags"
  type        = map(string)
  default     = {}
}


variable "tags" {
  description = "Define VPC tags"
  type        = map(string)
  default     = {}
}

variable "volume_size" {
  description = "Volumn size of ebs"
  type = number
}