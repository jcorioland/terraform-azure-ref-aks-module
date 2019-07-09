variable "environment" {
  description = "Name of the environment"
}

variable "location" {
  description = "Azure location to use"
}

variable "kubernetes_version" {
  description = "Kubernetes version to use"
}

variable "ssh_public_key" {
  description = "The SSH public key for AKS"
}

variable "service_principal_client_id" {
  description = "The client id of the service principal to be used by AKS"
}

variable "service_principal_client_secret" {
  description = "The client secret of the service principal to be used by AKS"
}

