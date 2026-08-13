# module "ecs" {
#   source       = "./module/ecs"
#   cluster_name = "test-cluster"
#   kms_key_arn  = module.my-project-kms.arn
#   auto_scaling_group_arn = module.my-project-asg.arn
# }