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
