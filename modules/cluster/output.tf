output "eks_vpc_config" {
  value = aws_eks_cluster.eks_cluster.vpc_config
}

# output "oidc" {
#   value = data.tls_certificate.eks_oidc_tls_certificate.certificates[*].sha1_fingerprint
# }

output "oidc" {
  value = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

output "cluster_name" {
  value = aws_eks_cluster.eks_cluster.id
}

output "certicate_authority" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}
