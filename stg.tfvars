project = "tfAks"

env = "stg"

default_tags = {

  Owner     = "Minerva"
  ManagedBy = "Terraform"

}

vm_type = {
  type  = "Standard_D2" #Family and series
  cores = "3"           #number of VCPU
}