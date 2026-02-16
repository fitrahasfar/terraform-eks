output "irsa_s3_role_arn" {
  value = aws_iam_role.irsa_s3_role.arn
}

output "irsa_s3_role_name" {
  value = aws_iam_role.irsa_s3_role.name
}

output "irsa_s3_policy_arn" {
  value = aws_iam_policy.s3_read_policy.arn
}