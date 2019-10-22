data "azurerm_key_vault" "keyvault" {
  name                = "terraformMadridDotNet"
  resource_group_name = "keyvault"
}