data "azurerm_subscription" "id" {}

data "azuread_client_config" "current" {}


data "external" "vm_available" {
  program = ["bash", "./bin/getVMsAvailable.sh"]
  query = {
    location = var.location
  }
}