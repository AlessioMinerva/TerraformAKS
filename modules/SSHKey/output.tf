output "private_key" {
  value       = tls_private_key.this.private_key_pem
  sensitive   = true
  description = "The generated private key in PEM format. Marked as sensitive to avoid accidental exposure"
}

output "public_key" {
  value       = tls_private_key.this.public_key_openssh
  description = "The generated public key in OpenSSH format, used for SSH access to virtual machines"
}
