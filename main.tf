module "data-s3-bucket-1" {
  source            = "./module/s3"
  bucket_versioning = false
  bucket_name       = "data-bucket-2"
  encryption-type   = "aws:kms"
  kms_key_id        = module.my-kms.arn
}

# module "data-s3-bucket-2" {
#   source = "./module/s3"
#   bucket_versioning = true
#   bucket_name = "data-bucket-2"


# }

module "key_pair" {
  source        = "./module/key-pair"
  bucket_name   = module.data-s3-bucket-1.bucket_name
  key_pair_name = "my-keypair"
}


module "my-kms" {
  source          = "./module/kms"
  project_name    = var.project_name
  kms-policy-path = "./assets/policies/kms-key-policy.json"
}

# module "cloudtrail" {
#   source       = "./module/cloudtrail"
#   project_name = "my-project"
# }

module "my-vpc" {
  source                = "./module/vpc"
  enable_ipv6           = true
  vpc_cidr              = "10.100.0.0/16"
  enable_nat            = true
  project_name          = "test"
  nat_ebs_kms           = module.my-kms.arn
  nat_ebs_volumn        = 10
  nat_instance_key_pair = module.key_pair.key_pair_name
  nat_instance_type     = "t3.micro"
  nat_type              = "instance"
  nat_instance_ami      = "ami-0f559c3642608c138"
}



# data "aws_ami" "this" {
#   most_recent      = true
#   owners = ["amazon"]

#   filter {
#     name   = "name"
#     values = ["al2023-ami-*-x86_64"] 
#   }

#   filter {
#     name   = "root-device-type"
#     values = ["ebs"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }


# filter {
#     name   = "architecture"
#     values = ["x86_64"]
#   }

#   include_deprecated = false

# }





