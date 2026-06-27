module "my-project-app-tg" {
  source      = "./module/target_group"
  tg_name     = "My-Project-APP-TG"
  tg_port     = 80
  tg_protocol = "HTTP"
  vpc_id      = module.my-project-vpc.vpc-id

}

module "my-project-alb-access-log-bucket" {
  source      = "./module/s3"
  bucket_name = "my-project-lb-access-logs-bucket"
}

module "my-project-alb" {
  source                  = "./module/load-balancer"
  lb_access_log_bucket_id = module.my-project-alb-access-log-bucket.id
  lb_type                 = "application"
  lb_name                 = "My-Project-ALB"
  lb_security_group_id    = aws_security_group.my-project-alb-sg.id
  lb_subnet_ids           = module.my-project-vpc.public_subnets_ids

}


resource "aws_lb_listener" "this" {
  load_balancer_arn = module.my-project-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = module.my-project-app-tg.arn
  }
}


# module "nlb" {
#   source                  = "./module/load-balancer"
#   lb_access_log_bucket_id = module.lb_access_log.id
#   lb_type                 = "network"
#   lb_name                 = "test-NLB"
#   lb_security_group_id    = aws_security_group.this.id
#   lb_subnet_ids           = module.my-vpc.public_subnets_ids
# }

resource "aws_security_group" "my-project-alb-sg" {
  name   = "My-project-ALB-SG"
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