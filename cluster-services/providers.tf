terraform {
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}

resource "local_sensitive_file" "kconfig_file" {
    content = var.kconfig
    filename = "${path.module}/kconfig"
}

provider "helm" {
  kubernetes {
    config_path = "${path.module}/kconfig"
  }
  depends_on = local_sensitive_file.kconfig_file
}

provider "kubectl" {
  config_path = "${path.module}/kconfig"
  # config_context = var.kcontext
    depends_on = local_sensitive_file.kconfig_file
}