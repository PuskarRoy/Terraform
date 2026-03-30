resource "aws_instance" "ec2" {
  ami                         = var.ami
  associate_public_ip_address = false
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  disable_api_termination     = true
  enable_primary_ipv6         = var.enable_instance_ipv6
  iam_instance_profile        = var.instance_profile
  force_destroy               = true
  key_name                    = var.key_pair_name
  vpc_security_group_ids      = [var.vpc_security_group_id]
  user_data                   = var.user_data_file_path

  root_block_device {
    delete_on_termination = false
    encrypted             = true
    volume_size           = var.root_volumn_size
    volume_type           = "gp3"
    kms_key_id            = var.kms_key_id
  }

  tags = var.tags

}



# resource "aws_security_group" "this" {
#   name   = "EC2-SG"
#   vpc_id = aws_vpc.main-vpc.id

#   # lifecycle {
#   #   create_before_destroy = true
#   # }

#   ingress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1" # For All Traffic
#     cidr_blocks = [aws_vpc.main-vpc.cidr_block]
#   }

#   egress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     ipv6_cidr_blocks = ["::/0"]
#   }

# }