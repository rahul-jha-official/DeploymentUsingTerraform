resource "azurerm_resource_group" "demo" {
  for_each = {
    "dev" = "eastus"
    "qa" = "westus"
    "stage" = "westus2"
    "prod" = "westeurope"
  }

  name = "rg-${each.key}"
  location = each.value
  tags = local.common_tags
}

resource "azurerm_resource_group" "demo2" {
  count = 4
  name = "rg-${count.index}"
  location = "eastus"
}

resource "azurerm_resource_group" "demo3" {
  count = length(var.name_list)
  name = var.name_list[count.index]
  location = var.location_list[count.index] == "" ? var.location_list[count.index] : var.default_location
}

variable "name_list" {
  default = ["rg-res-1","rg-res-2"]
  type = list(string)
  validation {
    condition = length(var.name_list) == 2
    error_message = "Size not match"
  }
}

variable "location_list" {
  default = ["westus"]
  type = list(string)
  validation {
    condition = length(var.location_list) == 2
    error_message = "Size not match"
  }
}

variable "default_location" {
  default = "eastus"
  type = string
}

resource "random_string" "random_password" {
  length = 20
  special = true
  override_special = "!@#)(*&^%$)<>"
  min_special = 2
  min_lower = 5
  min_upper = 2
  min_numeric = 2
}

output "demo-random_password" {
  value = random_string.random_password
}

resource "random_integer" "random_integer" {
    min = 1
    max = 100
}

output "demo-random_integer" {
  value = random_integer.random_integer
}

resource "random_uuid" "random_uuid" {}