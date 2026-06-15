
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



# module "ubuntu" {
#   source            = "./module/ec2"
#   ami               = "ami-07a00cf47dbbc844c"
#   instance_profile  = "ec2-admin"
#   key_pair_name     = module.ec2_key_pair.key_pair_name
#   kms_key_id        = module.my-kms.arn
#   instance_type     = "t3a.medium"
#   root_volumn_size  = 30
#   subnet_id         = module.my-vpc.public_subnets_ids[1]
#   security_group_id = aws_security_group.this.id
#   elastic_ip        = true

#   tags = {
#     "Name"               = "ubuntu-26",
#     "Ansible-Automation" = "Yes"
#   }
# }





# module "efs" {
#   source            = "./module/efs"
#   name              = "test"
#   kms_key_id        = module.my-kms.arn
#   target_subnets    = module.my-vpc.private_subnets_ids
#   security_group_id = aws_security_group.this.id
# }

