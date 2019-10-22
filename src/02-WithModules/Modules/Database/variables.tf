variable "database_name" {
    type = string
    description = "database name"
}

variable  "database_server_name" {
    type = string
    description = "Database Server name"
}

variable "location" {
    type = string
    default = "West Europe"
    description = "Location where to create resources"
}

variable "resource_group" {
    type = string
    description = "Name of resource group"
}

variable "sqlserver_edition"{
    type = string
    default = "Basic"
}

variable "sqlserver_pass"{
    type = string
    description = "Password of user from database server"
}

variable "sqlserver_user"{
    type = string
    description = "Sa user from database server"
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