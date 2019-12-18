provider "azurerm" {
  version = "~> 1.39.0"
}

resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = "tf-ref-${var.environment}-rg"
}

resource "azurerm_virtual_network" "aks" {
  name                = "aks-vnet"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "aks" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.aks.name
  address_prefix       = "10.1.0.0/24"
}

