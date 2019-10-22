variable "location" {
    type = string
    default = "West Europe"
    description = "Location where to create resources"
}

variable "resource_group" {
    type = string
    description = "Name of resource group"
}

variable "serviceplan_sku_tier" {
    type = string
    description = "Service Plan Sku Tier"
}

variable "serviceplan_sku_size" {
    type = string
    description = "Service Plan Sku Size"
}


variable "tags" {
  type        = map
  description = "Default tags for all resources"

  default = {
    Created_Modified_By = "terraform",
    Environment = "production",
    Version = "0.0.1"
  }
}

variable "webapp_url_site" {
    type = string
    description = "Url of new web app"
}

variable "webapp_enablehttps" {
    type = bool
    description = "if web app use only https"
}

variable "url_site" {
    type = string
}

variable "complete_url_site" {
    type = string
}

variable "cert_pfx_password" {
  type = string
}

variable "cert_pfx_base64" {
  type = string 
}

variable "cert_thumbprint" {
   type="string"
}

variable "ssl_state" {
    type = string
    default = "SniEnabled"
}

variable "dns_simple_domain" {
    type = string
}

variable "sql_database_name" {
    type = string
}

variable "sql_server_domain_name" {
  type = string
}

variable "sql_user" {
  type = string
}

variable "sql_password" {
  type = string
}
