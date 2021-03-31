resource "kubernetes_service" "si-service" {
  metadata {
    name      = "events-internal"
    namespace = kubernetes_namespace.n.metadata[0].name
  }
  spec {
    selector = {
      App = kubernetes_deployment.si-deployment.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 8082
      target_port = 8082
    }

    type = "ClusterIP"
  }
}


output "lb_status" {
  value = kubernetes_service.si-service.status
}
