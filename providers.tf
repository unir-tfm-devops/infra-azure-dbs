terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.110.0"
    }
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "~> 1.25.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "postgresql" {
  alias           = "test"
  host            = azurerm_postgresql_flexible_server.postgres_test.fqdn
  port            = 5432
  database        = "postgres"
  username        = azurerm_postgresql_flexible_server.postgres_test.administrator_login
  password        = azurerm_postgresql_flexible_server.postgres_test.administrator_password
  sslmode         = "require"
  connect_timeout = 15
  superuser       = false
}

provider "postgresql" {
  alias           = "prod"
  host            = azurerm_postgresql_flexible_server.postgres_prod.fqdn
  port            = 5432
  database        = "postgres"
  username        = azurerm_postgresql_flexible_server.postgres_prod.administrator_login
  password        = azurerm_postgresql_flexible_server.postgres_prod.administrator_password
  sslmode         = "require"
  connect_timeout = 15
  superuser       = false
}