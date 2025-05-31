<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 3.0.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.12.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 3.0.2 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.12.0 |
| <a name="provider_external"></a> [external](#provider\_external) | 2.3.5 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ServicePrincipal"></a> [ServicePrincipal](#module\_ServicePrincipal) | ./modules/ServicePrincipal | n/a |
| <a name="module_aks"></a> [aks](#module\_aks) | ./modules/Aks/ | n/a |
| <a name="module_keyvault"></a> [keyvault](#module\_keyvault) | ./modules/KeyVault | n/a |
| <a name="module_ssh_key"></a> [ssh\_key](#module\_ssh\_key) | ./modules/SSHKey | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_secret.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [local_file.kubeconfig](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |
| [azurerm_subscription.id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [external_external.vm_available](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default tags applied to all resources. Should include at least 'Owner' and 'ManagedBy' | `map(string)` | <pre>{<br/>  "ManagedBy": "Terraform",<br/>  "Owner": "Minerva"<br/>}</pre> | no |
| <a name="input_env"></a> [env](#input\_env) | Deployment environment, such as dev or prod. | `string` | n/a | yes |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Additional tags to apply to resources. Merged with default\_tags | `map(string)` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region where the resources will be deployed | `string` | `"UKSouth"` | no |
| <a name="input_project"></a> [project](#input\_project) | Project for which these resouces are created for | `string` | n/a | yes |
| <a name="input_vm_type"></a> [vm\_type](#input\_vm\_type) | Map specifying the base VM type and minimum v-core version (e.g., v3+). Used for filtering SKUs | `map(string)` | <pre>{<br/>  "cores": "3",<br/>  "type": "Standard_D2"<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_config"></a> [cluster\_config](#output\_cluster\_config) | The raw Kubernetes config to access the AKS cluster. Marked as sensitive to avoid being displayed in CLI output |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the created Azure Resource Group |
<!-- END_TF_DOCS -->