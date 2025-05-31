variable "tags_map" {
  type        = map(string)
  description = "A map of key-value tags to apply to all Azure resources, for `azurerm` provider"
}

variable "location" {
  type        = string
  description = "Azure region where resources will be deployed (e.g., `UK South`)"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create resources"
}

variable "keyvault_name" {
  type = string
}

variable "service_principal_name" {
  type        = string
  description = "The name to assign to the Azure Active Directory Service Principal"
}