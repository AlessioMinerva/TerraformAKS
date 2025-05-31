variable "project" {
  type = string
  description = "Project for which these resouces are created for"
}

variable "env" {
  type = string
  description = "Deployment environment, such as dev or prod."
  
  validation {
    condition     = contains(["dev", "int", "stg", "prod"], var.env)
    error_message = "Valid values for var.env are : dev,int,stg,prod \nuse them accordingly to your enviroment"
  } 
}

variable "default_tags" {
  type = map(string)
  default = {
    Owner     = "Minerva"
    ManagedBy = "Terraform"
  }
  description = ""
}

variable "extra_tags" {
  type    = map(string)
  default = {}
  
  validation {
    condition     = contains(keys(merge(var.default_tags, var.extra_tags)), "Owner")
    error_message = "The combined tags must include the 'Owner' key."
  }
}

variable "location" {
  type    = string
  default = "UKSouth" #"canadacentral"
}

#variable "service_principal_name" {
#  type = string
#}
#
#variable "keyvault_name" {
#  type = string
#}

#variable "SUB_ID" {
#  type = string
#}
#variable "node_pool_name" {
#  
#}
#variable "cluster_name" {
#  
#}

variable "filter_vm" {
  type = string
  default = "Standard_D2"
}