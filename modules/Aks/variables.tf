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

variable "service_principal_name" {
  type        = string
  description = "The name to assign to the Azure Active Directory Service Principal"
}

variable "ssh_public_key" {
  description = "The SSH public key to use for authentication with AKS cluster nodes"
}

variable "client_id" {
  type        = string
  description = "The client ID of the service principal used to authenticate with Azure"
}

variable "client_secret" {
  type        = string
  sensitive   = true
  description = "The client secret associated with the service principal"
}

variable "node_pool_name" {
  type        = string
  description = "The name of the AKS node pool"
}

variable "cluster_name" {
  type        = string
  description = "The name of the AKS cluster"
}

variable "cluster_version" {
  type        = string
  default     = null
  description = "The Kubernetes version to use for the AKS cluster. If null, the latest available version will be used"
}

variable "vm_size" {
  type        = string
  description = "The size of the virtual machines to use in the AKS node pool (e.g., `Standard_D2_v3`)"
}

variable "admin_username" {
  type        = string
  default     = "ubuntu"
  description = "The admin username for AKS Linux nodes. Default is `ubuntu`"
}
