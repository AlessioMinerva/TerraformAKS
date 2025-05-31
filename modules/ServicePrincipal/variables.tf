
variable "tags_set" {
  type        = set(string)
  description = "A map of key-value tags to apply to all Azure resources, for `azuread` provider"
}

variable "service_principal_name" {
  type        = string
  description = "The name to assign to the Azure Active Directory Service Principal"
}