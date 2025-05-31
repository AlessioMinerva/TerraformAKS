output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "client_id" {
  description = "The application id of AzureAD application created."
  value       = module.ServicePrincipal.client_id
}

output "client_secret" {
  description = "Password for service principal."
  value       = module.ServicePrincipal.client_secret
  sensitive = true

}


#output "debug_scope" {
#  value = module.ServicePrincipal.service_principal_object_id
#}
#
#output "current_user_object_id" {
#  value = data.azuread_client_config.current.object_id
#}

output "vm_sizes" {
  value = local.d_series_vm_sizes[2]#data.external.vm_available.result
  #Since we need this forAKS I will choose the 3 on the list, I do not haveto go in production with this 
  #+ vm_sizes               = [
  #    + "Standard_B2ms",
  #    + "Standard_B2s",
  #    + "Standard_B2ls_v2",
  #    + "Standard_B2s_v2",
  #    + "Standard_B2ts_v2",
  #    + "Standard_B2als_v2",
  #    + "Standard_B2as_v2",
  #    + "Standard_B2ats_v2",
  #    + "Standard_B2pls_v2",
  #    + "Standard_B2ps_v2",
  #    + "Standard_B2pts_v2",
  #    + "Standard_B20ms",
  #  ]
#

}