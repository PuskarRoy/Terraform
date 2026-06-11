resource "aws_lb_target_group" "this" {
  name                              = var.tg_name
  vpc_id                            = var.vpc_id
  # load_balancing_cross_zone_enabled = false
  port                              = var.tg_port
  protocol                          = var.tg_protocol
  
  dynamic "stickiness" {
    for_each = var.enable_stickiness == true ? [1] : []
    content {
      enabled = true
      type    = "lb_cookie"
    }
  }

  target_type = var.tg_target_type

  tags = var.tags

}


resource "aws_lb_target_group_attachment" "this" {

  count = length(var.tg_targets)

  target_group_arn = aws_lb_target_group.this.arn
  target_id        = var.tg_targets[count.index]

}
