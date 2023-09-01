terraform {
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = "${path.module}/kconfig"
  }
}

provider "kubectl" {
  config_path = "${path.module}/kconfig"
  # config_context = var.kcontext
}