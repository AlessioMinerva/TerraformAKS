terraform {
  backend "azurerm" {
    resource_group_name  = "dev-TerraformAKS"
    storage_account_name = "devtfbackendterraformaks"
    container_name      = "tfstate"
    key                 = "dev.tfstate"
  }
}