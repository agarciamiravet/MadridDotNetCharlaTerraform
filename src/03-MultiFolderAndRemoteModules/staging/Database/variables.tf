variable "azure_key_vault_name" {
    type = string
}

variable "azure_key_vault_resource_group" {
    type = string
}

variable "azure_key_vault_sqlserver_user_secret" {
    type = string
}

variable "azure_key_vault_sqlserver_password_secret" {
    type = string
}

variable "database_name" {
    type = string
    description = "database name"
}

variable "database_server_name" {
    type = string
    description = "database server name"
}

variable "location" {
    type = string
    default = "West Europe"
    description = "Location where to create resources"
}

variable "sqlserver_edition"{
    type = string
    default = "Basic"
}

variable "tags" {
  type        = map
  description = "Default tags for all resources"

  default = {
    Created_Modified_By = "terraform",
    Environment = "Staging",
    Version = "0.0.1"
  }
}