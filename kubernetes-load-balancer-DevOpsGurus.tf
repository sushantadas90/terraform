resource "kubernetes_service" "se-service" {
  metadata {
    name      = "events-external"
    namespace = kubernetes_namespace.n.metadata[0].name
  }
  spec {
    selector = {
      App = kubernetes_deployment.se-deployment.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}


output "lb_status_se" {
  value = kubernetes_service.se-service.status
}
