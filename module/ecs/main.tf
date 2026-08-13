resource "aws_ecs_cluster" "this" {
  name = var.cluster_name
  setting {
    name  = "containerInsights"
    value = "disabled"
  }
  configuration {

    managed_storage_configuration {
      fargate_ephemeral_storage_kms_key_id = var.kms_key_arn
      kms_key_id                           = var.kms_key_arn
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "this" {
  cluster_name       = resource.aws_ecs_cluster.this.name
  capacity_providers = toset(concat(["FARGATE", "FARGATE_SPOT"], var.enable_asg_provider ? [aws_ecs_capacity_provider.this[0].name] : []))
  lifecycle {
    replace_triggered_by = [aws_ecs_capacity_provider.this]
  }
}

resource "aws_ecs_capacity_provider" "this" {
  count = var.enable_asg_provider ? 1 : 0
  name  = "${var.cluster_name}-asg"
  auto_scaling_group_provider {
    auto_scaling_group_arn         = var.auto_scaling_group_arn
    managed_termination_protection = "ENABLED"
    managed_scaling {
      status = "ENABLED"
    }
  }

}