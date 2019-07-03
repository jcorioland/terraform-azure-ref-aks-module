provider "azuread" {
  version = "~> 0.4"
}

provider "azurerm" {
  version = "~> 1.30"
}

provider "random" {
  version = "~> 2.1"
}

terraform {
  backend "azurerm" {}
}

data "azurerm_subnet" "aks" {
  name                 = "aks-subnet"
  virtual_network_name = "aks-vnet"
  resource_group_name  = "TF-REF-${var.environment}-RG"
}

resource "azurerm_resource_group" "rg" {
  name     = "TF-REF-${var.environment}-RG"
  location = "${var.location}"
}

resource "azuread_application" "aks" {
  name = "tf-ref-${var.environment}-aks-aad-application"
}

resource "azuread_service_principal" "aks" {
  application_id = "${azuread_application.aks.application_id}"
}

resource "random_uuid" "aks" {}

resource "azuread_service_principal_password" "aks" {
  service_principal_id = "${azuread_service_principal.aks.id}"
  value                = "${random_uuid.aks.result}"
  end_date             = "${timeadd(timestamp(), "8760h")}"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "tf-ref-${var.environment}-aks"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  dns_prefix          = "tf-ref-${var.environment}-aks"
  kubernetes_version  = "${var.kubernetes_version}"

  linux_profile {
    admin_username = "azureuser"

    ssh_key {
      key_data = "${var.ssh_public_key}"
    }
  }

  agent_pool_profile {
    name            = "agentpool1"
    count           = "2"
    vm_size         = "Standard_DS2_v2"
    os_type         = "Linux"
    os_disk_size_gb = 30

    vnet_subnet_id = "${data.azurerm_subnet.aks.id}"
  }

  service_principal {
    client_id     = "${azuread_service_principal.aks.application_id}"
    client_secret = "${random_uuid.aks.result}"
  }

  network_profile {
    network_plugin = "kubenet"
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    Environment = "${var.environment}"
  }
}

resource "azurerm_role_assignment" "netcontribrole" {
  scope                = "${data.azurerm_subnet.aks.id}"
  role_definition_name = "Network Contributor"
  principal_id         = "${azuread_service_principal.aks.object_id}"
}
