terraform {
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  # skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
  # use_msi = true
}

data "azurerm_kubernetes_cluster" "cluster" {
  name                = "terraforge-cluster"
  resource_group_name = "terraforge-jake"
}

provider "helm" {
  # kubernetes {
  #   host        = data.azurerm_kubernetes_cluster.cluster.kube_config.0.host
  #   token       = data.azurerm_kubernetes_cluster.cluster.kube_config.0.client_key[0].client_key
  #   cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate)
  # }
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.cluster.kube_config.0.host
    username               = data.azurerm_kubernetes_cluster.cluster.kube_config.0.username
    password               = data.azurerm_kubernetes_cluster.cluster.kube_config.0.password
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate)
  }
}

provider "kubectl" {
  host        = data.azurerm_kubernetes_cluster.cluster.kube_config.0.host
  token       = data.azurerm_kubernetes_cluster.cluster.kube_config.0.client_key
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate)
}