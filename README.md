# pre requ

azure accoutn 
az cli


# Before you run 

`az login` you willbe redfirct

`az account show` make sure you are using the right account

make the script executable `─ chmod +x bin/remoteBackend.sh ` 

eval the following to export and make them avialble for terraform 

export ARM_SUBSCRIPTION_ID=$(az account show --query id -o tsv)
export ARM_TENANT_ID=$(az account show --query tenantId -o tsv)


removed staging folder
removed subscription var, use data instead


need to interpolate values to be env+whatever
tagging standand



try to remove this :


resource "azurerm_role_assignment" "kv_user" {
  principal_id         = "7c71686d-ae08-42c8-93fe-3339a4979468"
  role_definition_name = "Key Vault Secrets Officer"
  scope                = azurerm_key_vault.kv.id
}


and deploy again as this was missing


do not use ssh public key value in repo! add to terraform and inject value

todo:

cluster availibilt yzone not avaibale in canada 
cluster vm not avaible choose form list


removed unsed variables

version cluster or latest

add unsed outputfor more dynamic 

rename module resorces

node pool normalize