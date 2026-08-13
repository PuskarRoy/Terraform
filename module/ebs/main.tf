resource "aws_ebs_volume" "this" {
  availability_zone = var.availability_zone
  size              = var.ebs_size
  encrypted         = true
  type              = "gp3"
  kms_key_id        = var.kms_key_id

  tags = var.tags
}

resource "aws_volume_attachment" "ebs_att" {
  count       = var.ebs_device_name != null && var.instance_id != null ? 1 : 0
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.this.id
  instance_id = var.instance_id
}