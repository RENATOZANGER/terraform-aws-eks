output "alb_dns_name" {
  description = "ALB's public DNS created by Ingress"
  value       = kubernetes_ingress_v1.app_ingress.status[0].load_balancer[0].ingress[0].hostname
}
