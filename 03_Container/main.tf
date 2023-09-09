provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.72.0"
    }
  }
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_storage_account" "sa" {
  resource_group_name      = azurerm_resource_group.rg.name
  name                     = var.storage_account_name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_container" "sc" {
  name                  = var.storage_container
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}