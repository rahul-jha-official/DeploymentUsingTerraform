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
  name = var.test_resource_group_name
  location = var.test_resource_group_location
}