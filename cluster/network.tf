# Create Virtual Network
resource "azurerm_virtual_network" "aksvnet" {
  name                = "aks-network"
  location            = var.location #azurerm_resource_group.rg.location
  resource_group_name = var.resource_group_name #azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/8"]
}

# Create a Subnet for AKS
resource "azurerm_subnet" "aks-default" {
  name                 = "aks-default-subnet"
  virtual_network_name = azurerm_virtual_network.aksvnet.name
  resource_group_name  = var.resource_group_name #azurerm_resource_group.rg.name
  address_prefixes     = ["10.240.0.0/16"]
}