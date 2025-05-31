<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_application.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_service_principal.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azuread_service_principal_password.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal_password) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_service_principal_name"></a> [service\_principal\_name](#input\_service\_principal\_name) | The name to assign to the Azure Active Directory Service Principal | `string` | n/a | yes |
| <a name="input_tags_set"></a> [tags\_set](#input\_tags\_set) | A map of key-value tags to apply to all Azure resources, for `azuread` provider | `set(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | The application id of AzureAD application created. |
| <a name="output_client_secret"></a> [client\_secret](#output\_client\_secret) | Password for service principal. |
| <a name="output_service_principal_name"></a> [service\_principal\_name](#output\_service\_principal\_name) | The object id of service principal. Can be used to assign roles to user. |
| <a name="output_service_principal_object_id"></a> [service\_principal\_object\_id](#output\_service\_principal\_object\_id) | The object id of service principal. Can be used to assign roles to user. |
| <a name="output_service_principal_tenant_id"></a> [service\_principal\_tenant\_id](#output\_service\_principal\_tenant\_id) | n/a |
<!-- END_TF_DOCS -->