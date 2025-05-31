output "resource_group_name" {
  value       = azurerm_resource_group.this.name
  description = "The name of the created Azure Resource Group"
}

output "cluster_config" {
  value       = module.aks.config
  sensitive   = true
   description = "The raw Kubernetes config to access the AKS cluster. Marked as sensitive to avoid being displayed in CLI output"
}

#Note: I coudl not find an easy way to filter the available vm in a region
#      so currently Terraform is calling a basch script to use the `az cli`
#      then output in a usable format for Terraform to pass the varibale
#      UNCOMMENT if you want to see all the available vm in the target region
#output "vm_sizes" {
#  value = local.series_vm_sizes
#  description = "A list of filtered avaibles vms in the target region"
#}