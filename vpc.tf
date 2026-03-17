# module "myvpc" {
#   source       = "./module/vpc"
#   aws_region   = var.aws_region
#   project_name = var.project_name
#   vpc_cidr     = var.vpc_cidr
#   enable_ipv6  = var.enable_ipv6
#   enable_nat   = var.enable_nat
# }