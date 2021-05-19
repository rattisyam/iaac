provider "azurerm" {
  features {}
}

module "vm" {
  source = "../modules/vm"
}

