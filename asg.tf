
module "launch-template" {
  source                 = "./module/launch_template"
  ami                    = "ami-07fdaf2f06ed27385"
  iam_instance_profile   = "ec2-admin"
  instance_type          = "t3a.medium"
  keypair_name           = module.ec2_key_pair.key_pair_name
  kms_key_id             = module.my-kms.id
  security_group_id      = aws_security_group.this.id
  template_name          = "test1"
  volume_size = 40
}

module "asg" {
  source             = "./module/autoscaling_group"
  launch_template_id = module.launch-template.id
  min_size           = 1
  desired_capacity   = 1
  max_size           = 1
  name               = "test"
  subnet_ids         = module.my-vpc.private_subnets_ids
  target_group_arn = module.tg.arn
  template_version = module.launch-template.version
}