module "tf-ref-aks-module" {
  source                       = "../../"
  environment                  = "${var.environment}"
  location                     = "${var.location}"
  kubernetes_version           = "${var.kubernetes_version}"
  ssh_public_key               = "${var.ssh_public_key}"
}
