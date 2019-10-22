terraform {
  backend "remote" {
    organization = "recetasdevops"

    workspaces {
      name = "charlamadriddotnet-staging-resourcegroup"
    }
  }
}

provider "azurerm" {
  version = "=1.35.0"
}

resource "azurerm_resource_group" "charlamadriddotnet" {
  name     = "madriddotnet-rg-staging"
  location =  "West Europe"
  tags= var.tags
}

resource "azurerm_key_vault_secret" "resource_group_secret" {
  name         = "resourcegroup-staging"
  value        = "madriddotnet-rg-staging"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}