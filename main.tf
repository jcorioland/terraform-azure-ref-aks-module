provider "azuread" {
  version = "~> 0.7.0"
}

provider "azurerm" {
  version = "~> 1.39.0"
}

data "azurerm_resource_group" "rg" {
  name = "tf-ref-${var.environment}-rg"
}

data "azurerm_subnet" "aks" {
  name                 = "aks-subnet"
  virtual_network_name = "aks-vnet"
  resource_group_name  = data.azurerm_resource_group.rg.name
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "tf-ref-${var.environment}-aks"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  dns_prefix          = "tf-ref-${var.environment}-aks"
  kubernetes_version  = var.kubernetes_version

  linux_profile {
    admin_username = "azureuser"
    ssh_key {
      key_data = var.ssh_public_key
    }
  }

  default_node_pool {
    name            = "agentpool1"
    node_count      = "2"
    vm_size         = "Standard_DS2_v2"
    os_disk_size_gb = 30

    vnet_subnet_id = data.azurerm_subnet.aks.id
  }

  service_principal {
    client_id     = var.service_principal_client_id
    client_secret = var.service_principal_client_secret
  }

  network_profile {
    network_plugin = "kubenet"
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    Environment = var.environment
  }
}

data "azuread_service_principal" "aks" {
  application_id = var.service_principal_client_id
}

resource "azurerm_role_assignment" "netcontribrole" {
  scope                = data.azurerm_subnet.aks.id
  role_definition_name = "Network Contributor"
  principal_id         = data.azuread_service_principal.aks.object_id
}

