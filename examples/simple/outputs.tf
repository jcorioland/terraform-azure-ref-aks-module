output "resource_group_name" {
  value = "${module.tf-ref-aks-module.resource_group_name}"
}

output "aks_service_principal_client_id" {
  value = "${module.tf-ref-aks-module.aks_service_principal_client_id}"
}

output "aks_service_principal_client_secret" {
  value = "${module.tf-ref-aks-module.aks_service_principal_client_secret}"
}

output "aks_client_key" {
  value = "${module.tf-ref-aks-module.aks_client_key}"
}

output "aks_client_certificate" {
  value = "${module.tf-ref-aks-module.aks_client_certificate}"
}

output "aks_cluster_ca_certificate" {
  value = "${module.tf-ref-aks-module.aks_cluster_ca_certificate}"
}

output "aks_cluster_username" {
  value = "${module.tf-ref-aks-module.aks_cluster_username}"
}

output "aks_cluster_password" {
  value = "${module.tf-ref-aks-module.aks_cluster_password}"
}

output "aks_kube_config" {
  value = "${module.tf-ref-aks-module.aks_kube_config}"
}

output "aks_host" {
  value = "${module.tf-ref-aks-module.aks_host}"
}
