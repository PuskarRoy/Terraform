variable "project_name" {
  description = "Name of the KMS Key"
  type        = string
}

variable "kms-policy-path" {
  description = "path of KMS Key Policy (Json)"
  type        = string
}

variable "tags" {
  description = "Define tags"
  type        = map(string)
  default     = {}
}