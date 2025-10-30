# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.0"
#     }
#     kubernetes = {
#       source  = "hashicorp/kubernetes"
#       version = "~> 2.0"
#     }
#     helm = {
#       source  = "hashicorp/helm"
#       version = "~> 2.0"
#     }
#   }
#   backend "s3" {
#     bucket = "nome-do-bucket-12345"
#     key    = "dev/terraform.tfstate"
#     region = "us-east-1"
#   }
# }
#
# provider "aws" {
#   region  = var.region
#   profile = "renato_admin"
# }
#
# provider "kubernetes" {
#   host                   = module.eks_cluster.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks_cluster.certicate_authority)
#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     command     = "aws"
#     args        = ["eks", "get-token", "--cluster-name", module.eks_cluster.cluster_name]
#   }
# }
#
# provider "helm" {
#   kubernetes {
#     host                   = module.eks_cluster.cluster_endpoint
#     cluster_ca_certificate = base64decode(module.eks_cluster.certicate_authority)
#     exec {
#       api_version = "client.authentication.k8s.io/v1beta1"
#       command     = "aws"
#       args        = ["eks", "get-token", "--cluster-name", module.eks_cluster.cluster_name]
#     }
#   }
# }
