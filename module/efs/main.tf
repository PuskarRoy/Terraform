resource "aws_efs_file_system" "this" {
  encrypted       = true
  kms_key_id      = var.kms_key_id
  throughput_mode = "bursting"
  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }

  lifecycle_policy {
    transition_to_primary_storage_class = "AFTER_1_ACCESS"
  }

  # lifecycle_policy {
  #   transition_to_archive = "AFTER_90_DAYS"
  # }

  tags = merge({
    Name = "${replace(lower(var.name), " ", "-")}-EFS"
  }, var.tags)
}


resource "aws_efs_mount_target" "this" {
  count           = length(var.target_subnets)
  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = var.target_subnets[count.index]
  ip_address_type = var.enable_ipv6 ? "DUAL_STACK" : "IPV4_ONLY"
  security_groups = [var.security_group_id]
}