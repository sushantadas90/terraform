resource "kubernetes_deployment" "se-deployment" {
  metadata {
    name = "events-external"
    labels = {
      App = "events-external"
    }
    namespace = kubernetes_namespace.n.metadata[0].name
  }

  spec {
    replicas                  = 1
    selector {
      match_labels = {
        App = "events-external"
      }
    }
    template {
      metadata {
        labels = {
          App = "events-external"
        }
      }
      spec {
        container {
          image = "gcr.io/positive-tempo-309316/external-image:latest"
          name  = "external-image"

          port {
            container_port = 8080
          }

          env {
            name = "SERVER"
            value = "http://events-internal:8082"
          }
        }
      }
    }
  }
}