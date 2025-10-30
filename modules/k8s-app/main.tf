resource "kubernetes_deployment" "app" {
  metadata {
    name      = "meu-app"
    namespace = "default"
    labels = {
      app = "meu-app"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "meu-app"
      }
    }
    template {
      metadata {
        labels = {
          app = "meu-app"
        }
      }
      spec {
        container {
          name  = "meu-app"
          image = "nginx:latest"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "app_service" {
  metadata {
    name = "meu-app-service"
  }
  spec {
    selector = {
      app = kubernetes_deployment.app.metadata[0].labels.app
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "NodePort"
  }
}

resource "kubernetes_ingress_v1" "app_ingress" {
  metadata {
    name = "meu-app-ingress"
    annotations = {
      "kubernetes.io/ingress.class" : "alb"
      "alb.ingress.kubernetes.io/scheme" : "internet-facing"
    }
  }
  spec {
    rule {
      http {
        path {
          path = "/*"
          backend {
            service {
              name = kubernetes_service.app_service.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}
