variable "database_name" {
  type        = string
  description = "database name"
}

variable "database_server_name" {
  type        = string
  description = "database server name"
}


variable "location" {
  type        = string
  default     = "West Europe"
  description = "Location where to create resources"
}

variable "sqlserver_edition" {
  type    = string
  default = "Basic"
}

variable "sqlserver_pass" {
  type        = string
  description = "Password of user from database server"
}

variable "sqlserver_user" {
  type        = string
  description = "Sa user from database server"
}

variable "tags" {
  type        = map
  description = "Default tags for all resources"

  default = {
    Created_Modified_By = "terraform",
    Environment         = "production",
    Version             = "0.0.1"
  }
}

variable "serviceplan_sku_tier" {
  type        = string
  description = "Service Plan Sku Tier"
}

variable "serviceplan_sku_size" {
  type        = string
  description = "Service Plan Sku Size"
}

variable "webapp_url_site" {
  type        = string
  description = "Url of new web app"
}

variable "webapp_enablehttps" {
  type        = bool
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

variable "cert_thumbprint" {
  type = string
}


variable "cert_pfx_base64" {
  type = string
}

variable "dns_simple_domain" {
  type = string
}