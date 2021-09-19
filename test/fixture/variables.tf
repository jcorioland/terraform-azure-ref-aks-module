variable "environment" {
  description = "Name of the environment"
}


variable "kubernetes_version" {
  description = "Kubernetes version to use"
}

variable "service_principal_client_id" {
  description = "The client id of the service principal to be used by AKS"
}

variable "service_principal_client_secret" {
  description = "The client secret of the service principal to be used by AKS"
}

