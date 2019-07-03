output "resource_group_name" {
  value = "${azurerm_resource_group.rg.name}"
}

output "aks_service_principal_client_id" {
  value = "${azuread_service_principal.aks.id}"
}

output "aks_service_principal_client_secret" {
  value = "${random_uuid.aks.result}"
}

output "aks_client_key" {
  value = "${azurerm_kubernetes_cluster.aks.kube_config.0.client_key}"
}

output "aks_client_certificate" {
  value = "${azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate}"
}

output "aks_cluster_ca_certificate" {
  value = "${azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate}"
}

output "aks_cluster_username" {
  value = "${azurerm_kubernetes_cluster.aks.kube_config.0.username}"
}

output "aks_cluster_password" {
  value = "${azurerm_kubernetes_cluster.aks.kube_config.0.password}"
}

output "aks_kube_config" {
  value = "${azurerm_kubernetes_cluster.aks.kube_config_raw}"
}

output "aks_host" {
  value = "${azurerm_kubernetes_cluster.aks.kube_config.0.host}"
}
