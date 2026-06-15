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