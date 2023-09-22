resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_redis_cache" "redis" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  name                = var.redis_cache_name
  capacity            = var.redis_cache_capcity
  family              = var.redis_cache_family
  sku_name            = var.redis_cache_sku
}