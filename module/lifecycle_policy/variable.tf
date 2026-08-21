variable "target_tags" {
  description = "Tags used by AWS DLM to select EC2 instances"
  type        = map(string)

  default = {
    Backup = "true"
  }
}


variable "tags" {
  description = "Tags to apply to the DLM lifecycle policies"
  type        = map(string)

  default = {}
}
