provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    storage_account_name = "githubcicdtfstate"
    container_name       = "integration"
    key                  = "terraform.tfstate"
    resource_group_name  = "cdsimplifiedv2"
  }
}

module "vm" {
  source = "../modules/vm"
}

