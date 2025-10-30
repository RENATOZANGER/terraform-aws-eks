output "kubernetes_ingress_v1_id" {
  value = kubernetes_ingress_v1.app_ingress.id
}

output "kubernetes_deployment_id" {
  value = kubernetes_deployment.app.id
}

output "kubernetes_service_id" {
  value = kubernetes_service.app_service.id
}
