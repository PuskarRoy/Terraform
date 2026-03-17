locals {
  kms-name = replace(lower(var.project_name), " ", "-")
}

resource "aws_kms_key" "this" {
  description = "${var.project_name} KMS Key"
  policy      = file(var.kms-policy-path)
  tags        = var.tags
}

resource "aws_kms_alias" "this" {
  name          = "alias/${local.kms-name}-KMS-Key"
  target_key_id = aws_kms_key.this.id
}