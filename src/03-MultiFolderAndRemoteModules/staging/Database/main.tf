terraform {
  backend "remote" {
    organization = "recetasdevops"

    workspaces {
      name = "charlamadriddotnet-staging-database"
    }
  }
}

provider "azurerm" {
  
  version = "=1.35.0"
}

resource "azurerm_key_vault_secret" "sql_connection_string_secret" {
  name         =  "database-connstring-staging"
  value        =  module.database.sql_connectionstring
  key_vault_id =  data.azurerm_key_vault.madriddotnet_keyvault.id
}

module "database" {
  source = "github.com/recetasdevops/CharlaMDDatabaseModule.git?ref=v0.2"

  database_name = var.database_name
  database_server_name = var.database_server_name
  location  = var.location
  resource_group = data.azurerm_key_vault_secret.resource_group_secret.value
  sqlserver_edition = var.sqlserver_edition
  sqlserver_user = data.azurerm_key_vault_secret.sqlserver_user_secret.value
  sqlserver_pass  =  data.azurerm_key_vault_secret.sqlserver_password_secret.value
  tags = var.tags
}