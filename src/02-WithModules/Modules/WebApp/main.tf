locals {
  externalIp = split(",",azurerm_app_service.pasionporlosbits_webapp.outbound_ip_addresses)
}

resource "azurerm_app_service_plan" "pasionporlosbits_serviceplan" {
  name                = "pasionporlosbits"
  location            = var.location
  resource_group_name = var.resource_group

  sku {
    tier = var.serviceplan_sku_tier
    size = var.serviceplan_sku_size
  }

   tags = var.tags
}

resource "azurerm_app_service" "pasionporlosbits_webapp" {
  name                = var.webapp_url_site
  location            = var.location
  resource_group_name = var.resource_group
  app_service_plan_id = azurerm_app_service_plan.pasionporlosbits_serviceplan.id
  https_only = var.webapp_enablehttps

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
    default_documents = ["hostingstart.html"]
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=tcp:${var.sql_database_name},1433;Initial Catalog=${var.sql_server_domain_name};Persist Security Info=False;User ID=${var.sql_user};Password=${var.sql_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  }

   tags = var.tags
}


resource "azurerm_app_service_custom_hostname_binding" "pasionporlosbits_binding_dns" {
  hostname            = var.complete_url_site
  app_service_name    = azurerm_app_service.pasionporlosbits_webapp.name
  ssl_state           = var.ssl_state
  thumbprint          = var.cert_thumbprint
  resource_group_name = var.resource_group
  
  depends_on = ["dnsimple_record.simpledns_pasionporlosbits_record","dnsimple_record.simpledns_pasionporlosbits_record_cname"]
}

#certificate
resource "azurerm_app_service_certificate" "pasionporlosbits_certificate" {
  name                = "pasionporlosbits-certificate"
  resource_group_name = var.resource_group
  location            = var.location
  pfx_blob            =  var.cert_pfx_base64
  password            =  var.cert_pfx_password

     depends_on = ["azurerm_app_service.pasionporlosbits_webapp"]
}

#dns 

resource "dnsimple_record" "simpledns_pasionporlosbits_record_cname" {
  domain = var.dns_simple_domain
  name   = "www"
  value  = var.url_site
  type   = "CNAME"
  ttl    = 60
}

resource "dnsimple_record" "simpledns_pasionporlosbits_record" {
  domain = var.dns_simple_domain
  name   = ""
  value  = element(local.externalIp,0)
  type   = "A"
  ttl    = 3600
}