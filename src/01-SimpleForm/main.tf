terraform {
  backend "remote" {
    organization = "recetasdevops"

    workspaces {
      name = "charlamadriddotnet-web"
    }
  }
}

provider "azurerm" {

  version = "=1.35.0"
}

locals {
  location             = "West Europe"
  environment          = "production"
  database_server_tags = var.tags
  externalIp           = split(",", azurerm_app_service.pasionporlosbits_webapp.outbound_ip_addresses)
}

resource "azurerm_resource_group" "CharlaResourceGroup" {
  name     = "madriddotnet-rg"
  location = local.location
}

#Database

resource "azurerm_sql_server" "DatabaseServerPasionPorLosBits" {
  name                         = "pasionporlosbitsdbserver"
  resource_group_name          = azurerm_resource_group.CharlaResourceGroup.name
  location                     = local.location
  version                      = "12.0"
  administrator_login          = "mradministrator"
  administrator_login_password = "thisIsDog11"

  tags = local.database_server_tags
}

resource "azurerm_sql_database" "DatabaseInstancePasionPorLosBits" {
  name                = "pasionporlosbitsdatabase"
  resource_group_name = azurerm_resource_group.CharlaResourceGroup.name
  location            = local.location
  server_name         = azurerm_sql_server.DatabaseServerPasionPorLosBits.name
  edition             = var.sqlserver_edition

  tags = local.database_server_tags
}

#Web App

resource "azurerm_app_service_plan" "pasionporlosbits_serviceplan" {
  name                = "pasionporlosbits_sp"
  location            = local.location
  resource_group_name = azurerm_resource_group.CharlaResourceGroup.name

  sku {
    tier = var.serviceplan_sku_tier
    size = var.serviceplan_sku_size
  }

  tags = local.database_server_tags
}

resource "azurerm_app_service" "pasionporlosbits_webapp" {
  name                = var.webapp_url_site
  location            = local.location
  resource_group_name = azurerm_resource_group.CharlaResourceGroup.name
  app_service_plan_id = azurerm_app_service_plan.pasionporlosbits_serviceplan.id
  https_only          = var.webapp_enablehttps

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
    default_documents        = ["hostingstart.html"]
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=tcp:${azurerm_sql_server.DatabaseServerPasionPorLosBits.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_sql_database.DatabaseInstancePasionPorLosBits.name};Persist Security Info=False;User ID=${azurerm_sql_server.DatabaseServerPasionPorLosBits.administrator_login};Password=${azurerm_sql_server.DatabaseServerPasionPorLosBits.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  }

  tags = local.database_server_tags
}

#dns config

resource "dnsimple_record" "simpledns_pasionporlosbits_record" {
  domain = var.dns_simple_domain
  name   = ""
  value  = element(local.externalIp, 0)
  type   = "A"
  ttl    = 3600
}



resource "dnsimple_record" "simpledns_pasionporlosbits_record_cname" {
  domain = var.dns_simple_domain
  name   = "www"
  value  = "pasionporlosbits.azurewebsites.net"
  type   = "CNAME"
  ttl    = 60
}


resource "azurerm_app_service_custom_hostname_binding" "pasionporlosbits_binding_dns" {
  hostname            = var.url_site
  app_service_name    = azurerm_app_service.pasionporlosbits_webapp.name
  resource_group_name = azurerm_resource_group.CharlaResourceGroup.name
  ssl_state           = "SniEnabled"
  thumbprint          = var.cert_thumbprint

  depends_on = ["dnsimple_record.simpledns_pasionporlosbits_record","dnsimple_record.simpledns_pasionporlosbits_record_cname"]
}

#certificate

resource "azurerm_app_service_certificate" "pasionporlosbits_certificate" {
  name                = "pasionporlosbits-certificate"
  resource_group_name = azurerm_resource_group.CharlaResourceGroup.name
  location            = local.location
  pfx_blob            = var.cert_pfx_base64
  password            = var.cert_pfx_password

  depends_on = ["azurerm_app_service.pasionporlosbits_webapp"]
}

