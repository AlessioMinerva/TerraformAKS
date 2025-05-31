data "azurerm_kubernetes_service_versions" "current" {
  location        = var.location
  include_preview = false
}