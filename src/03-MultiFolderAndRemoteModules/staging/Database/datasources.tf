data "azurerm_key_vault" "madriddotnet_keyvault" {
  name                =  var.azure_key_vault_name
  resource_group_name = var.azure_key_vault_resource_group
}

data "azurerm_key_vault_secret" "sqlserver_user_secret" {
  name         =  var.azure_key_vault_sqlserver_user_secret
  key_vault_id = data.azurerm_key_vault.madriddotnet_keyvault.id
}

data "azurerm_key_vault_secret" "sqlserver_password_secret" {
  name         = var.azure_key_vault_sqlserver_password_secret
  key_vault_id = data.azurerm_key_vault.madriddotnet_keyvault.id
}


data "azurerm_key_vault_secret" "resource_group_secret" {
  name         = "resourcegroup-staging"
  key_vault_id = data.azurerm_key_vault.madriddotnet_keyvault.id
}