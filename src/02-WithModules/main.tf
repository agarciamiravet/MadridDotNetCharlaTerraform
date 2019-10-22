terraform {
  backend "remote" {
    organization = "recetasdevops"

    workspaces {
      name = "charlamadriddotnet-module"
    }
  }
}

provider "azurerm" {

  version = "=1.35.0"
}

provider "dnsimple" {
  version = "=0.2.0"
}

resource "azurerm_resource_group" "CharlaResourceGroup" {
  name     = "madriddotnet-rg"
  location = "West Europe"
}

module "database" {
  source = "./Modules/Database"

  database_name        = var.database_name
  database_server_name = var.database_server_name
  location             = var.location
  resource_group       = azurerm_resource_group.CharlaResourceGroup.name
  sqlserver_edition    = var.sqlserver_edition
  sqlserver_user       = var.sqlserver_user
  sqlserver_pass       = var.sqlserver_pass
  tags                 = var.tags
}

module "webapp" {
  source = "./Modules/WebApp"

  cert_pfx_password      = var.cert_pfx_password
  cert_pfx_base64        = var.cert_pfx_base64
  dns_simple_domain      = var.dns_simple_domain
  location               = var.location
  resource_group         = azurerm_resource_group.CharlaResourceGroup.name
  tags                   = var.tags
  webapp_url_site        = var.webapp_url_site
  complete_url_site      = var.complete_url_site
  url_site               = var.url_site
  serviceplan_sku_size   = var.serviceplan_sku_size
  serviceplan_sku_tier   = var.serviceplan_sku_tier
  webapp_enablehttps     = var.webapp_enablehttps
  sql_database_name      = module.database.sql_database_name
  sql_server_domain_name = module.database.sql_server_domain_name
  sql_user               = module.database.sql_user
  sql_password           = module.database.sql_password
  cert_thumbprint        = var.cert_thumbprint
}