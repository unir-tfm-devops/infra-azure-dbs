terraform {
  backend "azurerm" {
    resource_group_name  = "unir-tfm-devops-rg"
    storage_account_name = "unirtfmazurestate"
    container_name       = "tfstate"
    key                  = "postgres-dbs/terraform.tfstate"
  }
}