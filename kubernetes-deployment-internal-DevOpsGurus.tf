resource "kubernetes_deployment" "si-deployment" {
  metadata {
    name = "events-internal"
    labels = {
      App = "events-internal"
    }
    namespace = kubernetes_namespace.n.metadata[0].name
  }

  spec {
    replicas                  = 1
    selector {
      match_labels = {
        App = "events-internal"
      }
    }
    template {
      metadata {
        labels = {
          App = "events-internal"
        }
      }
      spec {
        container {
          image = "gcr.io/positive-tempo-309316/internal-image:latest"
          name  = "internal-image"

          port {
            container_port = 8082
          }
        }
      }
    }
  }
}