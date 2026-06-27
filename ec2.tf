module "my-project-uat-app-keypair" {
  source        = "./module/key-pair"
  key_pair_name = "my-project-uat-app-keypair"
  bucket_name   = module.my-project-bucket.id
}


module "my-project-uat-app-1a" {
  source            = "./module/ec2"
  ami               = "ami-006f82a1d5a27da54"
  instance_profile  = "ec2-admin"
  key_pair_name     = module.my-project-uat-app-keypair.key_pair_name
  kms_key_id        = module.my-project-kms.arn
  instance_type     = "t3a.medium"
  root_volumn_size  = 30
  subnet_id         = module.my-project-vpc.public_subnets_ids[0]
  security_group_id = aws_security_group.my-project-uat-app-sg.id
  elastic_ip        = true

  tags = {
    "Name" = "my-project-UAT-APP-1a"
  }
}



resource "aws_security_group" "my-project-uat-app-sg" {
  name   = "My-project-UAT-app-sg"
  vpc_id = module.my-project-vpc.vpc-id

  # lifecycle {
  #   create_before_destroy = true
  # }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}