resource "aws_ecs_cluster" "this" {
  name = "testcluster"
  setting {
    name  = "containerInsights"
    value = "disabled"
  }
  configuration {

    managed_storage_configuration {
      fargate_ephemeral_storage_kms_key_id = module.my-project-kms.arn
      kms_key_id                           = module.my-project-kms.arn
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "this" {
  cluster_name       = resource.aws_ecs_cluster.this.name
  capacity_providers = ["FARGATE", "FARGATE_SPOT",aws_ecs_capacity_provider.this.name]
}

resource "aws_ecs_capacity_provider" "this" {
  name = "test-cluster"
  auto_scaling_group_provider {
    auto_scaling_group_arn = module.my-project-asg.arn
    managed_termination_protection = "ENABLED"
    managed_scaling {
      status = "ENABLED"
    }
  }
  
}