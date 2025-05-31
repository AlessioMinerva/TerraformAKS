#create SSH key
module "ssh_key" {
  source = "./modules/SSHKey"
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.env}-${var.project}-rg"
  location = var.location

  tags     = local.tags_map

}

module "ServicePrincipal" {
  source                 = "./modules/ServicePrincipal"
  service_principal_name = "${var.env}-${var.project}-spn"
  
 tags_set = local.tags_set

  depends_on = [
    azurerm_resource_group.rg  ]

  
}

resource "azurerm_role_assignment" "rolespn" {

  scope                = data.azurerm_subscription.id.id
  role_definition_name = "Contributor"
  principal_id         = module.ServicePrincipal.service_principal_object_id

  depends_on = [
    module.ServicePrincipal
  ]
}

module "keyvault" {
  source                      = "./modules/KeyVault"
  keyvault_name               = "${var.env}-${var.project}-kv"
  location                    = var.location
  resource_group_name         = azurerm_resource_group.rg.name
  service_principal_name      = module.ServicePrincipal.service_principal_name
  #service_principal_object_id = module.ServicePrincipal.service_principal_object_id
  #service_principal_tenant_id = module.ServicePrincipal.service_principal_tenant_id

  tags_map = local.tags_map


  depends_on = [
    module.ServicePrincipal
  ]
}

resource "azurerm_key_vault_secret" "example" {
  name         = module.ServicePrincipal.client_id
  value        = module.ServicePrincipal.client_secret
  key_vault_id = module.keyvault.keyvault_id

  tags     = local.tags_map


  depends_on = [
    module.keyvault
  ]
}

#create Azure Kubernetes Service
module "aks" {
  source                 = "./modules/Aks/"
  service_principal_name = "${var.env}-${var.project}-spn"
  client_id              = module.ServicePrincipal.client_id
  client_secret          = module.ServicePrincipal.client_secret
  location               = var.location
  resource_group_name    = azurerm_resource_group.rg.name
  ssh_public_key = module.ssh_key.public_key
  cluster_name ="${var.env}-${var.project}-cluster"
  node_pool_name = "${var.env}-${var.project}-np"
  vm_size = local.d_series_vm_sizes[2]

  tags_map = local.tags_map

  depends_on = [
    module.ServicePrincipal
  ]

}

resource "local_file" "kubeconfig" {
  depends_on   = [module.aks]
  filename     = "./kubeconfig"
  content      = module.aks.config
  
}