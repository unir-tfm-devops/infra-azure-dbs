resource "azurerm_resource_group" "postgres_dbs_rg" {
  name     = "unir-tfm-postgres-dbs-rg"
  location = "East US"
}

resource "azurerm_postgresql_flexible_server" "postgres_test" {
  name                   = "unir-tfm-postgres-test"
  resource_group_name    = azurerm_resource_group.postgres_dbs_rg.name
  location               = azurerm_resource_group.postgres_dbs_rg.location
  version                = "16"
  administrator_login    = "postgres"
  administrator_password = "postgresPassword123!"
  storage_mb             = 32768
  zone                   = "1"

  sku_name = "B_Standard_B1ms"

  authentication {
    password_auth_enabled = true
  }

  public_network_access_enabled = true

  tags = {
    Name = "PostgreSQL Test"
  }
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_all_ips_test" {
  name      = "AllowAllIPs"
  server_id = azurerm_postgresql_flexible_server.postgres_test.id

  start_ip_address = "0.0.0.0"
  end_ip_address   = "255.255.255.255"
}

resource "azurerm_postgresql_flexible_server" "postgres_prod" {
  name                   = "unir-tfm-postgres-prod"
  resource_group_name    = azurerm_resource_group.postgres_dbs_rg.name
  location               = azurerm_resource_group.postgres_dbs_rg.location
  version                = "16"
  administrator_login    = "postgres"
  administrator_password = "postgresPassword123!"
  storage_mb             = 32768
  zone                   = "1"

  sku_name = "B_Standard_B1ms"

  authentication {
    password_auth_enabled = true
  }

  public_network_access_enabled = true

  tags = {
    Name = "PostgreSQL Prod"
  }
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_all_ips_prod" {
  name      = "AllowAllIPs"
  server_id = azurerm_postgresql_flexible_server.postgres_prod.id

  start_ip_address = "0.0.0.0"
  end_ip_address   = "255.255.255.255"
}


resource "time_sleep" "wait_for_db" {
  depends_on = [
    azurerm_postgresql_flexible_server.postgres_test,
    azurerm_postgresql_flexible_server.postgres_prod,
    azurerm_resource_group.postgres_dbs_rg,
    azurerm_postgresql_flexible_server_firewall_rule.allow_all_ips_test,
    azurerm_postgresql_flexible_server_firewall_rule.allow_all_ips_prod
  ]
  create_duration = "30s"
}
