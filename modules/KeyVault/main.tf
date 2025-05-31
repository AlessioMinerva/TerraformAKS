resource "azurerm_key_vault" "this" {
  name                       = var.keyvault_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  purge_protection_enabled    = false
  sku_name                   = "premium"
  soft_delete_retention_days = 7
  enable_rbac_authorization = true

  tags     = var.tags_map
}

resource "azurerm_role_assignment" "this" {
  principal_id         = data.azuread_client_config.current.object_id
  role_definition_name = "Key Vault Secrets Officer"
  scope                = azurerm_key_vault.this.id
}
