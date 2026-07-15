# module "my_project_kms" {
#   source       = "./module/kms"
#   project_name = "My Project"
# }

# module "ec2_key_pair" {
#   source        = "./module/key-pair"
#   key_pair_name = "my-keypair"
#   bucket_name   = module.my_project_bucket.id
# }

# module "ubuntu_control" {
#   source            = "./module/ec2"
#   ami               = "ami-006f82a1d5a27da54"
#   instance_profile  = "ec2-admin"
#   key_pair_name     = module.ec2_key_pair.key_pair_name
#   kms_key_id        = module.my_project_kms.arn
#   instance_type     = "t3a.large"
#   root_volumn_size  = 30
#   subnet_id         = module.my_project_vpc.public_subnets_ids[1]
#   security_group_id = aws_security_group.this.id
#   elastic_ip        = true

#   tags = {
#     Name                 = "Ubuntu-Control"
#   }
# }

# module "ubuntu" {
#   source            = "./module/ec2"
#   ami               = "ami-006f82a1d5a27da54"
#   instance_profile  = "ec2-admin"
#   key_pair_name     = module.ec2_key_pair.key_pair_name
#   kms_key_id        = module.my_project_kms.arn
#   instance_type     = "t3a.large"
#   root_volumn_size  = 30
#   subnet_id         = module.my_project_vpc.public_subnets_ids[1]
#   security_group_id = aws_security_group.this.id
#   elastic_ip        = true

#   tags = {
#     Name                 = "ubuntu",
#     Ansible-Automation   = "Yes"
#   }
# }

# module "amazon" {
#   source            = "./module/ec2"
#   ami               = "ami-0d351f1b760a30161"
#   instance_profile  = "ec2-admin"
#   key_pair_name     = module.ec2_key_pair.key_pair_name
#   kms_key_id        = module.my_project_kms.arn
#   instance_type     = "t3a.large"
#   root_volumn_size  = 30
#   subnet_id         = module.my_project_vpc.public_subnets_ids[1]
#   security_group_id = aws_security_group.this.id
#   elastic_ip        = true

#   tags = {
#     Name                 = "amazon",
#     Ansible-Automation   = "Yes"
#   }
# }


# module "redhat" {
#   source            = "./module/ec2"
#   ami               = "ami-0af7e19d7f4a36103"
#   instance_profile  = "ec2-admin"
#   key_pair_name     = module.ec2_key_pair.key_pair_name
#   kms_key_id        = module.my_project_kms.arn
#   instance_type     = "t3a.large"
#   root_volumn_size  = 30
#   subnet_id         = module.my_project_vpc.public_subnets_ids[1]
#   security_group_id = aws_security_group.this.id
#   elastic_ip        = true
#   user_data = file("./assets/user-data/redhat-ssm-agent.sh")

#   tags = {
#     Name                 = "redhat",
#     Ansible-Automation   = "Yes"
#   }
# }




# module "my_project_vpc" {
#   source       = "./module/vpc"
#   vpc_cidr     = "10.20.0.0/16"
#   enable_nat   = false
#   project_name = "My Project"
# }

# module "my_project_bucket" {
#   source      = "./module/s3"
#   bucket_name = "my-project-bucket"
# }

# resource "aws_security_group" "this" {
#   name   = "test"
#   vpc_id = module.my_project_vpc.vpc-id

#   # lifecycle {
#   #   create_before_destroy = true
#   # }

#   ingress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }


#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

# }