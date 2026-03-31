module "ec2_key_pair" {
  source        = "./module/key-pair"
  bucket_name   = module.s3-bucket.bucket_name
  key_pair_name = "nat-keypair"
}

module "s3-bucket" {
  source            = "./module/s3"
  bucket_name       = "test-bucket"
  bucket_versioning = false
}

module "my-kms" {
  source          = "./module/kms"
  project_name    = var.project_name
  kms-policy-path = "./assets/policies/kms-key-policy.json"
}

module "my-vpc" {
  source       = "./module/vpc"
  vpc_cidr     = "10.100.0.0/16"
  enable_nat   = true
  project_name = "test"
}



module "server1-amzn" {
  source                = "./module/ec2"
  ami                   = "ami-0931307dcdc2a28c9"
  instance_profile      = "ec2-admin"
  key_pair_name         = module.ec2_key_pair.key_pair_name
  kms_key_id            = module.my-kms.arn
  instance_type         = "t3.small"
  root_volumn_size      = 12
  subnet_id             = module.my-vpc.private_subnets_ids[1]
  vpc_security_group_id = aws_security_group.this.id

  tags = {
    "Name"                = "server1-amazon",
    "Ansible-Automation" = "Yes"
  }

}

module "server2-ubuntu" {
  source                = "./module/ec2"
  ami                   = "ami-05d2d839d4f73aafb"
  instance_profile      = "ec2-admin"
  key_pair_name         = module.ec2_key_pair.key_pair_name
  kms_key_id            = module.my-kms.arn
  instance_type         = "t3.small"
  root_volumn_size      = 12
  subnet_id             = module.my-vpc.private_subnets_ids[1]
  vpc_security_group_id = aws_security_group.this.id

  tags = {
    "Name"                = "server2-ubuntu-controll",
    "Ansible-Automation" = "Yes"
  }

}

module "server3-redhat" {
  source                = "./module/ec2"
  ami                   = "ami-03793655b06c6e29a"
  instance_profile      = "ec2-admin"
  key_pair_name         = module.ec2_key_pair.key_pair_name
  kms_key_id            = module.my-kms.arn
  instance_type         = "t3.small"
  root_volumn_size      = 12
  user_data             = file("./assets/user-data/redhat-ssm-agent.sh")
  subnet_id             = module.my-vpc.private_subnets_ids[1]
  vpc_security_group_id = aws_security_group.this.id

  tags = {
    "Name"                = "server3-redhat",
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









