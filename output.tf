# output "eks_vpc_config" {
#   value = module.eks_cluster.eks_vpc_config
# }
#
# output "oidc" {
#   value = module.eks_cluster.oidc
# }
#
output "certicate_authority" {
  value = module.eks_cluster.certicate_authority
}

output "cluster_endpoint" {
  value = module.eks_cluster.cluster_endpoint
}

output "cluster_name" {
  value = module.eks_cluster.cluster_name
}

# output "dns_load_balancer_hostname" {
#   value = module.k8s_app.alb_dns_name
# }
