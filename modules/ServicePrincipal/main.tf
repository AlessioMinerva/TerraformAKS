resource "azuread_application" "this" {
  display_name = var.service_principal_name
  owners       = [data.azuread_client_config.current.object_id]
  
  tags     = var.tags_set

}

resource "azuread_service_principal" "this" {
  app_role_assignment_required = true
  client_id = azuread_application.this.client_id
  owners                       = [data.azuread_client_config.current.object_id]
  
  tags     = var.tags_set


}

resource "azuread_service_principal_password" "this" {
  service_principal_id = azuread_service_principal.this.id
}