terraform {
  backend "azurerm" {
    resource_group_name = "rgstatefile"
    storage_account_name = "sastatefile"
    container_name = "scstatefile"
    key = "terraform.tfstate"
  }
}