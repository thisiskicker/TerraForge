terraform {
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}

#TODO change config to get credentials from azure
provider "helm" {
  kubernetes {
    config_content = terraform.workspace.var.kconfig
  }
}