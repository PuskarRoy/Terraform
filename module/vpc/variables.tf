variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "project_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string

}

variable "enable_nat" {
  description = "Enable Nat for VPC"
  type        = bool
}

variable "enable_ipv6" {
  description = "Enable IPv6 for the VPC"
  type        = bool
}

variable "flow-log-bucket-retention-days" {
  description = "Numbers of days to keep flow log"
  type        = number
  default     = 15
}

variable "tags" {
  description = "Define VPC tags"
  type        = map(string)
  default     = {}
}