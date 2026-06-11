resource "aws_launch_template" "name" {
  name = var.template_name
  description = var.description
  iam_instance_profile {
    name = var.iam_instance_profile
  }
  image_id = var.ami
  instance_type = var.instance_type
  key_name = var.keypair_name
  vpc_security_group_ids = [var.security_group_id]
  update_default_version = var.update_default_version
  user_data = var.user_data

  block_device_mappings {
  device_name = "/dev/xvda"

  ebs {
    delete_on_termination = true
    encrypted = true
    kms_key_id = var.kms_key_id
  }
}
}