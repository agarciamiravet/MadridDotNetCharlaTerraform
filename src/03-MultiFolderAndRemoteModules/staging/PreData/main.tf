terraform {
  backend "remote" {
    organization = "recetasdevops"

    workspaces {
      name = "charlamadriddotnet-staging-predata"
    }
  }
}

provider "azurerm" {
  version = "=1.35.0"
}

data "azurerm_key_vault" "keyvault" {
  name                = "terraformMadridDotNet"
  resource_group_name = "keyvault"
}

resource "azurerm_key_vault_secret" "resource_group_secret" {
  name         = "resourcegroup-staging"
  value        = "madriddotnet-rg-staging"
  key_vault_id = data.azurerm_key_vault.keyvault.id

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}


resource "azurerm_key_vault_secret" "sql_connection_string_secret" {
  name         =  "database-connstring-staging"
  value        =  "fake_connection_string"
  key_vault_id =  data.azurerm_key_vault.keyvault.id

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}