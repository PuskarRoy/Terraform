resource "aws_lb" "this" {
  name                             = var.lb_name
  internal                         = var.private
  load_balancer_type               = var.lb_type
  enable_cross_zone_load_balancing = true
  ip_address_type                  = var.enable_ipv6 == false ? "ipv4" : "dualstack"
  security_groups                  = [var.lb_security_group_id]
  subnets                          = toset(var.lb_subnet_ids)

  access_logs {
    bucket  = aws_s3_bucket.this.id
    enabled = true
    prefix  = var.lb_name
  }

  tags = var.tags
}


resource "random_id" "s3_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "this" {
  bucket        = "${replace(lower(var.project_name), " ", "-")}-alb-access-logs-${lower(random_id.s3_suffix.hex)}"
  force_destroy = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = true
  }

}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.this.json
}


data "aws_iam_policy_document" "this" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["logdelivery.elasticloadbalancing.amazonaws.com"]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.this.arn}/*"
    ]
  }
}
