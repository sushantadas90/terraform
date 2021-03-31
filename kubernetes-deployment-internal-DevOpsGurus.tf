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
          image = "gcr.io/mar-roidtc511/internal:v1.0"
          name  = "internal-image"

          port {
            container_port = 8082
          }
        }
      }
    }
  }
}