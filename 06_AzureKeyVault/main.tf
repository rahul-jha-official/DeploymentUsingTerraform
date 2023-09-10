
resource "azurerm_resource_group" "rg" {
  name = var.resource_group_name
  location = var.resource_group_location
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "akv" {
  name = var.keyvault_name
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = false
  tenant_id = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 7
  purge_protection_enabled = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
        "Get"
    ]

    secret_permissions = [
        "Get", "List", "Set", "Delete"
    ]

    storage_permissions = [
        "Get"
    ]
  }
}

resource "azurerm_key_vault_secret" "db-pwd" {
  name = var.keyvault_secret_key
  value = var.keyvault_secret_value
  key_vault_id = azurerm_key_vault.akv.id
}
