
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

  enable_rbac_authorization = true

  sku_name = "standard"
}

resource "azurerm_role_assignment" "akv-role-ass" {
  role_definition_name = "AKV Officer"
  principal_id = data.azurerm_client_config.current.object_id
  scope = azurerm_key_vault.akv.id
}

resource "azurerm_key_vault_secret" "db-pwd" {
  name = var.keyvault_secret_key
  value = var.keyvault_secret_value
  key_vault_id = azurerm_key_vault.akv.id

  depends_on = [ azurerm_role_assignment.akv-role-ass ]
}

resource "azurerm_role_assignment" "secret-user" {
  role_definition_name =  "AKV User"
  principal_id = data.azurerm_client_config.current.object_id
  scope = "${azurerm_key_vault.akv.id}/secret/${azurerm_key_vault_secret.db-pwd.name}"
}
