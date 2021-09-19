module "tf-ref-aks-module" {
  source             = "../../"
  environment        = "${var.environment}"
  kubernetes_version = "${var.kubernetes_version}"
  ssh_public_key     = "${file(var.ssh_public_key_file)}"
}
