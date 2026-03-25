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

variable "nat_type" {
  description = "Type of NAT to use"
  type        = string
  default     = "gateway"
  validation {
    condition     = contains(["gateway", "instance"], var.nat_type)
    error_message = "Invalid NAT type. Please choose either 'gateway' or 'instance'."
  }
}

variable "nat_ebs_kms" {
  description = "KMS Id for Nat Volumn"
  type = string
  
}

variable "nat_ebs_volumn" {
  description = "Volumn sixe of Nat instance"
  type = string
}

variable "nat_instance_key_pair" {
  description = "KMS Id for Nat Volumn"
  type = string
}

variable "nat_instance_type" {
  description = "Instance Type of nat Instance"
  type = string
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
