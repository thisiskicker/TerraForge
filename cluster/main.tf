#create resource group used my AKS cluster
resource "azurerm_resource_group" "rg" {
  name = var.resource_group_name
  location = var.location
  tags = {
    app = "terraforge"
  }
}

#create AKS cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name = var.cluster_name
  kubernetes_version = var.kubernetes_version
  location = var.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix = var.cluster_name
  node_resource_group = var.node_resource_group
  default_node_pool {
    name = "system"
    node_count = var.system_node_count
    vm_size = "standard_B2s"
    type = "VirtualMachineScaleSets"
    #availability_zones = [1, 2, 3]
    enable_auto_scaling = true
    vnet_subnet_id        = azurerm_subnet.aks-default.id
    #needs to be set if changing default node pool
    #only 12 characters: lower case & numbers
    temporary_name_for_rotation = "terratemp"
    tags = {
      app = "terraforge"
    }
  }
  identity {
    type = "SystemAssigned"
  }
  network_profile {
    load_balancer_sku = "standard"
    network_plugin = "azure"
  }
}