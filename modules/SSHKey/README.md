<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tls_private_key.this](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_key"></a> [private\_key](#output\_private\_key) | The generated private key in PEM format. Marked as sensitive to avoid accidental exposure |
| <a name="output_public_key"></a> [public\_key](#output\_public\_key) | The generated public key in OpenSSH format, used for SSH access to virtual machines |
<!-- END_TF_DOCS -->