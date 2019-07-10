variable "environment" {
  description = "Name of the environment"
}

variable "location" {
  description = "Azure location to use"
}

variable "kubernetes_version" {
  description = "Kubernetes version to use"
}

variable "ssh_public_key_file" {
  description = "The SSH public key file to use with AKS"
}
