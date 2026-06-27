module "my-project-app-keypair" {
  source        = "./module/key-pair"
  key_pair_name = "my-project-app-keypair"
  bucket_name   = module.my-project-bucket.id
}


module "my-project-launch-template" {
  source               = "./module/launch_template"
  ami                  = "ami-0ccbe2ab4a94e65bd"
  iam_instance_profile = "ec2-admin"
  instance_type        = "t3a.medium"
  keypair_name         = module.my-project-app-keypair.key_pair_name
  kms_key_id           = module.my-project-kms.arn
  security_group_id    = aws_security_group.my-project-app-sg.id
  template_name        = "My-Project-APP-Template"
  volume_size          = 30

}

module "my-project-asg" {
  source             = "./module/autoscaling_group"
  launch_template_id = module.my-project-launch-template.id
  min_size           = 1
  desired_capacity   = 3
  max_size           = 3
  name               = "My-project-ASG"
  subnet_ids         = module.my-project-vpc.private_subnets_ids
  target_group_arn   = module.my-project-app-tg.arn
  template_version   = module.my-project-launch-template.version
}

resource "aws_security_group" "my-project-app-sg" {
  name   = "My-project-app-sg"
  vpc_id = module.my-project-vpc.vpc-id

  # lifecycle {
  #   create_before_destroy = true
  # }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "TCP"
    security_groups = [aws_security_group.my-project-alb-sg.id]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}