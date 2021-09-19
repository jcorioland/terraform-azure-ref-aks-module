variable "environment" {
  description = "Name of the environment"
}

variable "kubernetes_version" {
  description = "Kubernetes version to use"
}

variable "ssh_public_key_file" {
  description = "The SSH public key file to use with AKS"
}
