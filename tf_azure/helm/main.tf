data "terraform_remote_state" "k8s_cluster" {
  backend = "azurerm"
  config {
    storage_account_name = "${var.storage_account_name}"
    container_name       = "${var.container_name}"
    key                  = "${var.key}"
    access_key           = "${var.access_key}"
  }
}

provider "helmcmd" {
  "chart_source_type" = "repository"
  "chart_source" = "https://kubernetes-charts.storage.googleapis.com"
  "debug" = true
  "kube_context" = "${data.terraform_remote_state.k8s_cluster.cluster_name}"
}

provider "kubernetes" {
  host                   = "${data.terraform_remote_state.k8s_cluster.host}"
  client_certificate     = "${base64decode(data.terraform_remote_state.k8s_cluster.client_certificate)}"
  client_key             = "${base64decode(data.terraform_remote_state.k8s_cluster.client_key)}"
  cluster_ca_certificate = "${base64decode(data.terraform_remote_state.k8s_cluster.cluster_ca_certificate)}"
}


resource "kubernetes_persistent_volume" "example" {
  metadata {
    name = "jenkins-pv"
  }
  spec {
    capacity {
      storage = "20Gi"
    }
    storage_class_name = "jenkins-pv"
    persistent_volume_reclaim_policy = "Retain"
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
      host_path {
        path = "/data/jenkins-volume/"
      }
    }
  }
}

resource "helmcmd_release" "jenkins" {
  name = "jenkins"
  chart_name = "jenkins"
  namespace = "jenkins-project"
  chart_version = "0.16.3"
  overrides = "${file("${path.module}/../../helm/jenkins-values.yaml")}"
  depends_on = ["kubernetes_persistent_volume.example"]
}

resource "helmcmd_release" "anchore" {
  name = "anchore"
  chart_name = "anchore-engine"
  namespace = "jenkins-project"
  chart_version = "0.1.7"
  overrides = "${file("${path.module}/../../helm/anchore-engine-values.yaml")}"
  depends_on = ["helmcmd_release.jenkins"]
}