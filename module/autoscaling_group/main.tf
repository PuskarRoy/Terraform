resource "aws_autoscaling_group" "this" {
  name = var.name

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity
  availability_zone_distribution {
    capacity_distribution_strategy = "balanced-best-effort"
  }
  default_cooldown          = 300
  default_instance_warmup   = 300
  health_check_type         = "ELB" # EC2 / ELB
  health_check_grace_period = 300

  vpc_zone_identifier = toset(var.subnet_ids)

  launch_template {
    id      = var.launch_template_id
    version = var.template_version
  }

  instance_maintenance_policy {
    min_healthy_percentage = 50
    max_healthy_percentage = 100
  }

  instance_refresh {
    strategy = "Rolling"
    # triggers = ["launch_template"]
  }

  dynamic "tag" {
    for_each = var.asg_tags

    content {
      key                 = tag.value.key
      value               = tag.value.value
      propagate_at_launch = tag.value.propagate_at_launch
    }
  }


}

resource "aws_autoscaling_attachment" "example" {
  count                  = var.target_group_arn != null ? 1 : 0
  autoscaling_group_name = aws_autoscaling_group.this.id
  lb_target_group_arn    = var.target_group_arn
}