module "ec2_key_pair" {
  source        = "./module/key-pair"
  bucket_name   = module.s3-bucket.bucket_name
  key_pair_name = "nat-keypair"
}

module "s3-bucket" {
  source            = "./module/s3"
  bucket_versioning = false
  bucket_name       = "test-bucket"

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

module "server1-ubuntu" {
  source            = "./module/ec2"
  ami               = "ami-05d2d839d4f73aafb"
  instance_profile  = "ec2-admin"
  key_pair_name     = module.ec2_key_pair.key_pair_name
  kms_key_id        = module.my-kms.arn
  instance_type     = "t3.small"
  root_volumn_size  = 12
  subnet_id         = module.my-vpc.public_subnets_ids[1]
  security_group_id = aws_security_group.this.id
  elastic_ip        = true

  tags = {
    "Name" = "server1-ubuntu-controll",
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


module "tg" {
  source      = "./module/target-group"
  vpc_id      = module.my-vpc.vpc-id
  tg_name     = "test-TG"
  tg_port     = 80
  tg_protocol = "HTTP"
  tg_targets  = [module.server1-ubuntu.id]
}

module "lb" {
  source               = "./module/load-balancer"
  project_name         = "test"
  lb_name              = "test-ALB"
  lb_security_group_id = aws_security_group.this.id
  lb_subnet_ids        = module.my-vpc.public_subnets_ids

}
