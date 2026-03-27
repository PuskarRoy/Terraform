# resource "aws_instance" "ec2" {
#   ami = var.ami
#   associate_public_ip_address = false
#   instance_type = var.instance_type
#   subnet_id = var.subnet_id
#   disable_api_termination = true
#   enable_primary_ipv6 = var.instance_ipv6
#   iam_instance_profile = var.instance_profile
#   force_destroy = true
#   key_name = var.key_pair_name
#   vpc_security_group_ids = [var.vpc_security_group_id]
#   user_data = var.user_data

#   root_block_device {
#     delete_on_termination = false
#     encrypted =  true
#     volume_size = var.root_volumn_size
#     volume_type = "gp3"
#     kms_key_id = var.kms_key_id

#   }

#   tags = var.tags

# }