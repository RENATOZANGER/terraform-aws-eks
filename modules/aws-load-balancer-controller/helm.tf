resource "helm_release" "eks_helm_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"
  #version = "1.4.4"

  set {
    name  = "vpcId"
    value = var.vpc_id
  }

  set {
    name  = "clusterName"
    value = var.cluster_name
  }
  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }
  set {
    name  = "defaultTags.Environment"
    value = "dev"
  }

  set {
    name  = "defaultTags.Team"
    value = "backend"
  }
}
