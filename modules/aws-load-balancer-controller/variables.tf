variable "project_name" {
  type        = string
  description = "The name of the project"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the resources"
}

variable "oidc" {
  type        = string
  description = "The OIDC provider URL for the EKS cluster"
}

variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where the EKS cluster is deployed"
}

variable "kubernetes_ingress_v1_id" {
  type        = string
  description = "The ID of the Kubernetes Ingress resource"
}

variable "kubernetes_deployment_id" {
  type        = string
  description = "The ID of the Kubernetes Deployment resource"
}

variable "kubernetes_service_id" {
  type        = string
  description = "The ID of the Kubernetes Service resource"
}
