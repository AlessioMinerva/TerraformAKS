variable "project" {
  type        = string
  description = "Project for which these resouces are created for"
}

variable "env" {
  type        = string
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
  description = "Default tags applied to all resources. Should include at least 'Owner' and 'ManagedBy'"
}

variable "extra_tags" {
  type    = map(string)
  default = {}

  description = "Additional tags to apply to resources. Merged with default_tags"

  validation {
    condition     = contains(keys(merge(var.default_tags, var.extra_tags)), "Owner")
    error_message = "The combined tags must include the 'Owner' key"
  }
}

variable "location" {
  type        = string
  default     = "UKSouth"
  description = "Azure region where the resources will be deployed"
}

variable "vm_type" {
  type = map(string)
  default = {
    type  = "Standard_D2" #Family and series
    cores = "3"           #number of VCPU
  }
  description = "Map specifying the base VM type and minimum v-core version (e.g., v3+). Used for filtering SKUs"
}