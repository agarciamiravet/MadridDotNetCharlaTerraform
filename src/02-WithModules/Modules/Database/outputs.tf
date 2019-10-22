output "sql_database_name" {
    value = azurerm_sql_database.DatabaseInstancePasionPorLosBits.name
}

output "sql_server_domain_name" {
  value = azurerm_sql_server.DatabaseServerPasionPorLosBits.fully_qualified_domain_name
}

output "sql_user" {
  value = azurerm_sql_server.DatabaseServerPasionPorLosBits.administrator_login
}

output "sql_password" {
  value = azurerm_sql_server.DatabaseServerPasionPorLosBits.administrator_login_password
}
