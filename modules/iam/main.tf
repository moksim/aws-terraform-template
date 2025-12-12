data "aws_iam_policy_document" "assume_role_ec2" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "ec2_role" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_ec2.json
  tags               = var.tags
}

data "aws_iam_policy_document" "s3_logs_write" {
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:AbortMultipartUpload",
      "s3:ListBucketMultipartUploads",
      "s3:ListMultipartUploadParts"
    ]
    resources = [
      var.logs_bucket_arn,
      "${var.logs_bucket_arn}/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket"
    ]
    resources = [var.logs_bucket_arn]
  }
}

resource "aws_iam_policy" "ec2_s3_logs_policy" {
  name   = "${var.role_name}-s3-logs"
  policy = data.aws_iam_policy_document.s3_logs_write.json
  tags   = var.tags
}

resource "aws_iam_role_policy_attachment" "attach_logs_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ec2_s3_logs_policy.arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = var.instance_profile_name
  role = aws_iam_role.ec2_role.name
  tags = var.tags
}
