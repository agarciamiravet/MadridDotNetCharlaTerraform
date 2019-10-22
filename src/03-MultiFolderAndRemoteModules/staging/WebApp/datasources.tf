data "azurerm_key_vault" "madriddotnet_keyvault" {
  name                =  var.azure_key_vault_name
  resource_group_name = var.azure_key_vault_resource_group
}

data "azurerm_key_vault_secret" "resource_group_secret" {
  name         = "resourcegroup-staging"
  key_vault_id = data.azurerm_key_vault.madriddotnet_keyvault.id
}

data "azurerm_key_vault_secret" "web_certificate_password" {
  name         =  var.azure_key_vault_web_certificate_password
  key_vault_id = data.azurerm_key_vault.madriddotnet_keyvault.id
}

data "azurerm_key_vault_secret" "web_certificate_base64" {
  name         = var.azure_key_vault_web_certificate_base64
  key_vault_id = data.azurerm_key_vault.madriddotnet_keyvault.id
}

data "azurerm_key_vault_secret" "web_certificate_thumbprint" {
  name         = "certificate-staging-thumbprint"
  key_vault_id = data.azurerm_key_vault.madriddotnet_keyvault.id
}

data "azurerm_key_vault_secret" "database_connstring_secret" {
  name         = "database-connstring-staging"
  key_vault_id = data.azurerm_key_vault.madriddotnet_keyvault.id
}