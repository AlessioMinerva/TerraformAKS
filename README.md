# Azure Terraform Infrastructure Module

This repository provides a modular and improved Terraform configuration for deploying infrastructure on Microsoft Azure, with a focus on automation, environment isolation, tagging, and best practices.

> ✨ Based on [piyushsachdeva/Terraform-Full-Course-Azure](https://github.com/piyushsachdeva/Terraform-Full-Course-Azure/tree/main/lessons/day26) with several enhancements for better reusability, security, and automation.

## ✨ Improvements Over the Original

This module introduces several key improvements and refinements over the original structure:

- **Environment Configuration**: Instead of using separate folders for `staging` and `dev`, this module supports environment-specific configuration via separate variable files and pipeline deployment.
- **Dynamic Subscription Retrieval**: Azure subscription information is dynamically retrieved using the `azurerm_subscription` data source, removing the need to hardcode subscription IDs.
- **Role Assignment**: Adds a dedicated `azurerm_role_assignment` block to assign the `Key Vault Secrets Officer` role to the authenticated client:
  ```hcl
  resource "azurerm_role_assignment" "this" {
    principal_id         = data.azuread_client_config.current.object_id
    role_definition_name = "Key Vault Secrets Officer"
    scope                = azurerm_key_vault.this.id
  }
  ```


* **Tagging Support**: Implements a tagging strategy by combining default and custom tags to ensure resources are well-annotated.
* **Naming Convention**: Adopts structured naming for resources using environment and project context (e.g., `${var.env}-${var.project}-rg`).
* **SSH Key Generation**: Automatically generates SSH keys using Terraform instead of requiring manual key generation or storing them in the repo.
* **VM SKU Filtering**: Dynamically selects an available VM SKU in the region by filtering on type and minimum core requirements.
* **AKS Versioning**: Defaults to the latest AKS cluster version when not explicitly specified.
* **Cleanup**: Removed unused variables and refined module structure for better readability and maintainability.

## 🔧 Usage

To deploy this infrastructure, create an environment-specific variable file (e.g., `dev.tfvars`) and run:

```bash
terraform init
terraform plan -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars"
```

## 🔐 Prerequisites

Ensure you have the following configured:

* Azure CLI authenticated (`az login`)
* Proper permissions to assign roles and manage resources in the target subscription
* Terraform >= 1.9.0 installed


---

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

## 📦 Terraform Pipelines

### 🔐 Prerequisites
* GitHub Application with relevat role
* GitHub Actions Secret in the repo

### Plan

This GitHub Actions workflow automatically runs terraform plan on pull requests targeting the dev, stage, or prod branches, or when manually triggered via the Actions tab. It performs a full Terraform initialization using environment-specific remote backend configurations, validates and formats the Terraform code, and generates a detailed execution plan. The resulting plan is saved as an artifact, summarized in the GitHub Actions step summary, and posted as a comment on the pull request. This allows teams to review infrastructure changes before approval or merge. The workflow uses OIDC-based Azure authentication and requires specific permissions, including the ability to write PR comments.

### Apply

This workflow is triggered on a push event, which typically occurs when a pull request is approved and merged. Like the plan workflow, it dynamically detects the current branch—this time using the branch where the merge occurred—and applies the corresponding Terraform changes using the appropriate state and variable files.

### Destroy 

This pipeline can only be triggered manually using the workflow_dispatch event. The user must provide the target branch as an input, which will be used similarly to how it's handled in the Apply pipeline. For safety, an additional confirmation input is required, if this is not provided correctly, the destroy job will be skipped to prevent accidental deletions.