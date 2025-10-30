module "eks_network" {
  source       = "./modules/network"
  cidr_block   = var.cidr_block
  project_name = var.project_name
  tags         = var.tags
}

module "eks_cluster" {
  source           = "./modules/cluster"
  project_name     = var.project_name
  public_subnet_1a = module.eks_network.subnet_public_1a_id
  public_subnet_1b = module.eks_network.subnet_public_1b_id
  tags             = var.tags
}

module "eks_managed_node_group" {
  source            = "./modules/managed-node-group"
  project_name      = var.project_name
  cluster_name      = module.eks_cluster.cluster_name
  subnet_private_1a = module.eks_network.subnet_private_1a_id
  subnet_private_1b = module.eks_network.subnet_private_1b_id
  tags              = var.tags
}

module "eks_load_balancer_controller" {
  source                   = "./modules/aws-load-balancer-controller"
  project_name             = var.project_name
  oidc                     = module.eks_cluster.oidc
  cluster_name             = module.eks_cluster.cluster_name
  vpc_id                   = module.eks_network.vpc_id
  tags                     = var.tags
}

module "k8s_app" {
  source = "./modules/k8s-app"
}


provider "kubernetes" {
  host                   = module.eks_cluster.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks_cluster.certicate_authority)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", module.eks_cluster.cluster_name]
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks_cluster.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks_cluster.certicate_authority)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", module.eks_cluster.cluster_name]
    }
  }
}
