terraform {
  backend "remote" {
    organization = "recetasdevops"

    workspaces {
      name = "charlamadriddotnet-staging-webapp"
    }
  }
}

provider "azurerm" {
  version = "=1.35.0"
}

provider "dnsimple" {
  version = "=0.2.0"
}


module "webapp" {
  source = "github.com/recetasdevops/CharlaMDWebAppModule.git?ref=v0.5"

  cert_pfx_password = data.azurerm_key_vault_secret.web_certificate_password.value
  cert_pfx_base64 = data.azurerm_key_vault_secret.web_certificate_base64.value
  dns_simple_domain = var.dns_simple_domain
  location  = var.location
  resource_group = data.azurerm_key_vault_secret.resource_group_secret.value
  tags = var.tags
  webapp_url_site = var.webapp_url_site
  complete_url_site = var.complete_url_site
  url_site = var.url_site
  serviceplan_sku_size = var.serviceplan_sku_size
  serviceplan_sku_tier = var.serviceplan_sku_tier
  webapp_enablehttps = var.webapp_enablehttps
  cert_thumbprint = data.azurerm_key_vault_secret.web_certificate_thumbprint.value
  
  connection_string = data.azurerm_key_vault_secret.database_connstring_secret.value

}