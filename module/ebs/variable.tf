variable "availability_zone" {
  type = string
}

variable "ebs_size" {
  type = number
}

variable "kms_key_id" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "ebs_device_name" {
  type    = string
  default = null
}

variable "instance_id" {
  type    = string
  default = null
}