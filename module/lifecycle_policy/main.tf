resource "aws_dlm_lifecycle_policy" "ami_policy" {
  description        = "EBS-backed AMI policy"
  execution_role_arn = aws_iam_role.dlm_ami_role.arn
  state              = "ENABLED"
  tags               = var.tags

  depends_on = [
    aws_iam_role_policy_attachment.dlm_ami_policy_attachment
  ]

  policy_details {
    policy_type     = "IMAGE_MANAGEMENT"
    resource_types  = ["INSTANCE"]
    policy_language = "STANDARD"

    target_tags = var.target_tags

    parameters {
      exclude_boot_volume = false
      no_reboot           = true
    }

    schedule {
      name = "Schedule 1"
      create_rule {
        cron_expression = "cron(0 0 ? * FRI *)"
      }

      retain_rule {
        interval      = 7
        interval_unit = "DAYS"
      }

      variable_tags = {
        instance-id = "$(instance-id)"
      }

    }
  }




}

resource "aws_dlm_lifecycle_policy" "snapshot_policy" {
  description        = "EBS snapshot policy"
  execution_role_arn = aws_iam_role.dlm_snapshot_role.arn
  state              = "ENABLED"

  tags = var.tags

  depends_on = [
    aws_iam_role_policy_attachment.dlm_snapshot_policy_attachment
  ]

  policy_details {
    policy_type     = "EBS_SNAPSHOT_MANAGEMENT"
    resource_types  = ["INSTANCE"]
    policy_language = "STANDARD"

    target_tags = var.target_tags

    parameters {
      exclude_boot_volume = false
    }

    schedule {
      name = "Schedule 1"

      create_rule {
        cron_expression = "cron(0 0 * * ? *)"
      }

      retain_rule {
        interval      = 7
        interval_unit = "DAYS"
      }

      variable_tags = {
        instance-id = "$(instance-id)",
        timestamp   = "$(timestamp)"
      }
    }

  }
}


data "aws_iam_policy_document" "dlm_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["dlm.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole"
    ]

  }
}


resource "aws_iam_role" "dlm_snapshot_role" {
  name               = "dlm-snapshot-role"
  assume_role_policy = data.aws_iam_policy_document.dlm_assume_role.json
}



resource "aws_iam_policy" "dlm_snapshot_policy" {
  name        = "dlm-snapshot-policy"
  description = "IAM policy for AWS DLM EBS snapshot lifecycle management"

  policy = data.aws_iam_policy_document.dlm_snapshot_policy.json
}

resource "aws_iam_role_policy_attachment" "dlm_snapshot_policy_attachment" {
  role       = aws_iam_role.dlm_snapshot_role.name
  policy_arn = aws_iam_policy.dlm_snapshot_policy.arn
}

data "aws_iam_policy_document" "dlm_snapshot_policy" {

  statement {
    effect = "Allow"

    actions = [
      "ec2:CreateSnapshot",
      "ec2:CreateSnapshots",
      "ec2:DeleteSnapshot",
      "ec2:DescribeInstances",
      "ec2:DescribeVolumes",
      "ec2:DescribeSnapshots",
      "ec2:EnableFastSnapshotRestores",
      "ec2:DescribeFastSnapshotRestores",
      "ec2:DisableFastSnapshotRestores",
      "ec2:CopySnapshot",
      "ec2:ModifySnapshotAttribute",
      "ec2:DescribeSnapshotAttribute",
      "ec2:DescribeSnapshotTierStatus",
      "ec2:ModifySnapshotTier"
    ]

    resources = ["*"]

  }

  statement {
    effect = "Allow"


    actions = [
      "ec2:CreateTags"
    ]

    resources = [
      "arn:aws:ec2:*::snapshot/*"
    ]


  }

  statement {
    effect = "Allow"


    actions = [
      "events:PutRule",
      "events:DeleteRule",
      "events:DescribeRule",
      "events:EnableRule",
      "events:DisableRule",
      "events:ListTargetsByRule",
      "events:PutTargets",
      "events:RemoveTargets"
    ]

    resources = [
      "arn:aws:events:*:*:rule/AwsDataLifecycleRule.managed-cwe.*"
    ]

  }
}

resource "aws_iam_role" "dlm_ami_role" {
  name               = "dlm-ami-role"
  assume_role_policy = data.aws_iam_policy_document.dlm_assume_role.json
}

resource "aws_iam_role_policy_attachment" "dlm_ami_policy_attachment" {
  role       = aws_iam_role.dlm_ami_role.name
  policy_arn = aws_iam_policy.dlm_ami_policy.arn
}

resource "aws_iam_policy" "dlm_ami_policy" {
  name        = "dlm-ami-policy"
  description = "IAM policy for AWS DLM AMI lifecycle management"

  policy = data.aws_iam_policy_document.dlm_ami_policy.json
}

data "aws_iam_policy_document" "dlm_ami_policy" {

  statement {
    effect = "Allow"

    actions = [
      "ec2:CreateTags"
    ]

    resources = [
      "arn:aws:ec2:*::snapshot/*",
      "arn:aws:ec2:*::image/*"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "ec2:DescribeImages",
      "ec2:DescribeImageAttribute",
      "ec2:DescribeInstances",
      "ec2:DescribeVolumes",
      "ec2:DescribeSnapshots"
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "ec2:DeleteSnapshot"
    ]

    resources = [
      "arn:aws:ec2:*::snapshot/*"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "ec2:ResetImageAttribute",
      "ec2:DeregisterImage",
      "ec2:CreateImage",
      "ec2:CopyImage",
      "ec2:ModifyImageAttribute"
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "ec2:EnableImageDeprecation",
      "ec2:DisableImageDeprecation"
    ]

    resources = [
      "arn:aws:ec2:*::image/*"
    ]
  }
}