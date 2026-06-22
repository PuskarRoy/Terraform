# module "tg" {
#   source = "./module/target_group"
#   tg_name = "asg-tg"
#   tg_port = 80
#   tg_protocol = "HTTP"
#   vpc_id = module.my-vpc.vpc-id

# }

# module "lb_access_log" {
#   source      = "./module/s3"
#   bucket_name = "lb-access-logs"
# }

# module "ALBlb" {
#   source                  = "./module/load-balancer"
#   lb_access_log_bucket_id = module.lb_access_log.id
#   lb_type                 = "application"
#   lb_name                 = "test-ALB"
#   lb_security_group_id    = aws_security_group.this.id
#   lb_subnet_ids           = module.my-vpc.public_subnets_ids

# }


# resource "aws_lb_listener" "this" {
#   load_balancer_arn = module.ALBlb.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = module.tg.arn
#   }
# }


# # module "nlb" {
# #   source                  = "./module/load-balancer"
# #   lb_access_log_bucket_id = module.lb_access_log.id
# #   lb_type                 = "network"
# #   lb_name                 = "test-NLB"
# #   lb_security_group_id    = aws_security_group.this.id
# #   lb_subnet_ids           = module.my-vpc.public_subnets_ids
# # }