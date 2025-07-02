output "postgres_db_test_endpoint" {
  value = azurerm_postgresql_flexible_server.postgres_test.fqdn
}

output "postgres_db_prod_endpoint" {
  value = azurerm_postgresql_flexible_server.postgres_prod.fqdn
}
