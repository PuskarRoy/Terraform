module "nat_key_pair" {
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
  source                = "./module/vpc"
  enable_ipv6           = false
  vpc_cidr              = "10.100.0.0/16"
  enable_nat            = true
  project_name          = "test"
  nat_ebs_kms           = module.my-kms.arn
  nat_ebs_volumn        = 10
  nat_instance_key_pair = module.nat_key_pair.key_pair_name
  nat_instance_type     = "t3.micro"
  nat_type              = "gateway"
  nat_instance_ami      = "ami-0f559c3642608c138"
  nat_instance_profile  = "ec2-admin"
}


module "ec2_key_pair" {
  source        = "./module/key-pair"
  bucket_name   = module.s3-bucket.bucket_name
  key_pair_name = "private-ec2-keypair"
}



module "private-ec2" {
  source                = "./module/ec2"
  ami                   = "ami-0f559c3642608c138"
  instance_profile      = "ec2-admin"
  key_pair_name         = module.ec2_key_pair.key_pair_name
  kms_key_id            = module.my-kms.arn
  instance_type         = "t3.micro"
  root_volumn_size      = 12
  subnet_id             = module.my-vpc.private_subnets_ids[1]
  vpc_security_group_id = aws_security_group.this.id

}


resource "aws_security_group" "this" {
  name   = "Private-Ec2-SG"
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
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}









