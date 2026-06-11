resource "aws_autoscaling_group" "this" {
  name = "${replace(lower(var.name), " ", "-")}-asg"

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity

  desired_capacity_type          = "units"
  availability_zone_distribution {
    capacity_distribution_strategy = "balanced-best-effort"
  }
  default_cooldown         = 300
  default_instance_warmup  = 300
  health_check_type        = "ELB"
  health_check_grace_period = 300

  vpc_zone_identifier = var.subnet_ids

  launch_template {
    id      = var.launch_template_id
    version = "$Default"
  }

  instance_maintenance_policy {
    min_healthy_percentage = 50
    max_healthy_percentage = 100
  }

  instance_refresh {
    strategy = "Rolling"
    triggers = [launch_template]
  }

  
}

resource "aws_autoscaling_attachment" "example" {
  autoscaling_group_name = aws_autoscaling_group.this.id
  lb_target_group_arn                    = var.target_group_arn
}