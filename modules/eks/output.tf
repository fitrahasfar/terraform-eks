output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluter_security_groud_id" {
  value = module.eks.cluster_security_group_id
}