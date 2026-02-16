output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluter_security_groud_id" {
  value = module.eks.cluster_security_group_id
}

output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn          # Exposes OIDC ARN to be used in IAM trust policy.
}

output "cluster_oidc_issuer_url" {
  value = module.eks.cluster_oidc_issuer_url    # Exposes OIDC issuer URL for service account validation.
}