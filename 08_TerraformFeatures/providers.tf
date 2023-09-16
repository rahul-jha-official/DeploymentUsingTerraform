provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "=3.72.0"
    }
    random = {
        source = "hashicorp/random"
        version = "=3.5.1"
    }
  }
}