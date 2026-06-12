module "ec2_key_pair" {
  source        = "./module/key-pair"
  bucket_name   = module.s3-bucket.id
  key_pair_name = "keypair"
}

module "s3-bucket" {
  source      = "./module/s3"
  bucket_name = "test-bucket"
}

module "my-kms" {
  source       = "./module/kms"
  project_name = var.project_name
}

module "my-vpc" {
  source       = "./module/vpc"
  vpc_cidr     = "10.100.0.0/16"
  enable_nat   = true
  project_name = "test"
}

module "launch-template" {
  source                 = "./module/launch_template"
  ami                    = "ami-03150450e7f236129"
  iam_instance_profile   = "ec2-admin"
  instance_type          = "t3a.small"
  keypair_name           = module.ec2_key_pair.key_pair_name
  kms_key_id             = module.my-kms.id
  security_group_id      = aws_security_group.this.id
  template_name          = "test"
}

# module "Ubuntu-controll" {
#   source            = "./module/ec2"
#   ami               = "ami-0388e3ada3d9812da"
#   instance_profile  = "ec2-admin"
#   key_pair_name     = module.ec2_key_pair.key_pair_name
#   kms_key_id        = module.my-kms.arn
#   instance_type     = "t3a.medium"
#   root_volumn_size  = 30
#   subnet_id         = module.my-vpc.public_subnets_ids[1]
#   security_group_id = aws_security_group.this.id
#   elastic_ip        = true

#   tags = {
#     "Name" = "Ubuntu-Controll",
#     "Ansible-Automation" = "Yes"
#   }
# }



module "ubuntu" {
  source            = "./module/ec2"
  ami               = "ami-07a00cf47dbbc844c"
  instance_profile  = "ec2-admin"
  key_pair_name     = module.ec2_key_pair.key_pair_name
  kms_key_id        = module.my-kms.arn
  instance_type     = "t3a.medium"
  root_volumn_size  = 30
  subnet_id         = module.my-vpc.public_subnets_ids[1]
  security_group_id = aws_security_group.this.id
  elastic_ip        = true

  tags = {
    "Name"               = "ubuntu-26",
    "Ansible-Automation" = "Yes"
  }
}


resource "aws_security_group" "this" {
  name   = "Ec2-SG"
  vpc_id = module.my-vpc.vpc-id

  # lifecycle {
  #   create_before_destroy = true
  # }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # For All Traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

module "asg" {
  source             = "./module/autoscaling_group"
  launch_template_id = module.launch-template.id
  min_size           = 1
  desired_capacity   = 2
  max_size           = 2
  name               = "test"
  subnet_ids         = module.my-vpc.private_subnets_ids
  target_group_arn = module.tg.arn

}

module "tg" {
  source = "./module/target_group"
  tg_name = "asg-tg"
  tg_port = 80
  tg_protocol = "HTTPS"
  vpc_id = module.my-vpc.vpc-id

}


# module "lb_access_log" {
#   source      = "./module/s3"
#   bucket_name = "lb-access-logs"
# }

# module "ALBlb" {
#   source                  = "./module/load-balancer"
#   lb_access_log_bucket_id = module.lb_access_log.id
#   lb_type                 = "application"
#   lb_name                 = "test-ALB"
#   lb_security_group_id    = aws_security_group.this.id
#   lb_subnet_ids           = module.my-vpc.public_subnets_ids

# }


# # module "nlb" {
# #   source                  = "./module/load-balancer"
# #   lb_access_log_bucket_id = module.lb_access_log.id
# #   lb_type                 = "network"
# #   lb_name                 = "test-NLB"
# #   lb_security_group_id    = aws_security_group.this.id
# #   lb_subnet_ids           = module.my-vpc.public_subnets_ids
# # }

# module "efs" {
#   source            = "./module/efs"
#   name              = "test"
#   kms_key_id        = module.my-kms.arn
#   target_subnets    = module.my-vpc.private_subnets_ids
#   security_group_id = aws_security_group.this.id
# }

