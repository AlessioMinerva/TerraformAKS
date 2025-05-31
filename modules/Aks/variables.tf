variable "tags_map" {
  type    = map(string)
  default = {}
}

variable "location" {

}

 variable "resource_group_name" {}

variable "service_principal_name" {
  type = string
}

variable "ssh_public_key" {
}

variable "client_id" {}
variable "client_secret" {
  type = string
  sensitive = true
}

variable "node_pool_name" {
  
}
variable "cluster_name" {
  
}

variable "cluster_version" {
    type = string
    default = null
  
}

variable "vm_size" {
  
}

variable "admin_username" {
  type = string
  default = "ubuntu"
}