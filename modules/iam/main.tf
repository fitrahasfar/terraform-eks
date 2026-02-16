data "aws_iam_policy_document" "irsa_trust_policy" {
  statement {

    # Allows pod to assume IAM role via OIDC.
    actions = ["sts:AssumeRoleWithWebIdentity"]

    # Trusts the EKS OIDC provider.
    principals {
      type = "Federated"
      identifiers = [var.oidc_provider_arn]
    }

    # Only service account "s3-reader" in default namespace can assume this role.
    condition {
      test = "StringEquals"
      variable = "${var.oidc_provider_url}"
      values = ["system:serviceaccount:default:s3-reader"]
    }
  }
}

# Creates IAM Role that can be assumed by specific service account and this role is not for EC2, but for pods
resource "aws_iam_role" "irsa_s3_role" {
  name = "irsa-s3-read-role"
  assume_role_policy = data.aws_iam_policy_document.irsa_trust_policy.json
}

# Grants read-only access to S3 (no delete or write).
resource "aws_iam_policy" "s3_read_policy" {
  name = "irsa-s3-read-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject"]
        Resource = "*"
      }
    ]
  })
}

# Attaches the policy to IAM Role.
resource "aws_iam_role_policy_attachment" "attach_policy" {
  role = aws_iam_role.irsa_s3_role.name
  policy_arn = aws_iam_policy.s3_read_policy.arn
}