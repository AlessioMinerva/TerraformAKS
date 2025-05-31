# export ssh key
output "private_key" {
  value     = tls_private_key.this.private_key_pem
  sensitive = true
}

# export ssh key
output "public_key" {
  value     = tls_private_key.this.public_key_openssh
}
