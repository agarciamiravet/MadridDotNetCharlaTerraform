variable "azure_key_vault_name" {
    type = string
}

variable "azure_key_vault_resource_group" {
    type = string
}

variable "azure_key_vault_web_certificate_password" {
    type = string
}

variable "azure_key_vault_web_certificate_base64" {
    type = string
}

variable "complete_url_site" {
    type = string
}

variable "dns_simple_domain" {
    type = string
}

variable "location" {
  type = string
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
    Environment = "staging",
    Version = "0.0.1"
  }
}

variable "webapp_enablehttps" {
    type = bool
    description = "if web app use only https"
}

variable "webapp_url_site" {
    type = string
    description = "Url of new web app"
}


variable "url_site" {
    type = string
}