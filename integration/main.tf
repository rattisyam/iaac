provider "azurerm" {
  features {}
  subscription_id = var.TF_VAR_AZ_SUB
  client_id       = var.TF_VAR_AZ_ID
  client_secret   = var.TF_VAR_AZ_SECRET
  tenant_id       = var.TF_VAR_AZ_TENANT
}

module "vm" {
  source = "../modules/vm"
}

