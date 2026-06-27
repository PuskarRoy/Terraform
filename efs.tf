module "my-project-efs" {
  source            = "./module/efs"
  name              = "My-Project-EFS"
  kms_key_id        = module.my-project-kms.arn
  target_subnets    = module.my-project-vpc.private_subnets_ids
  security_group_id = aws_security_group.my-project-efs-sg.id
}


resource "aws_security_group" "my-project-efs-sg" {
  name   = "My-Project-EFS-SG"
  vpc_id = module.my-project-vpc.vpc-id

  # lifecycle {
  #   create_before_destroy = true
  # }

  ingress {
    from_port       = 2049
    to_port         = 2049
    protocol        = "TCP"
    security_groups = [aws_security_group.my-project-app-sg.id]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}