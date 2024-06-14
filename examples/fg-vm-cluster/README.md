<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 1.34 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | >= 1.34 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_fg_vm_cluster"></a> [fg\_vm\_cluster](#module\_fg\_vm\_cluster) | ../../modules/fortigate-firewall | n/a |

## Resources

| Name | Type |
|------|------|
| [equinix_network_acl_template.fortigate_cluster](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/network_acl_template) | resource |
| [equinix_network_file.fg_vm_license_file_node0](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/network_file) | resource |
| [equinix_network_file.fg_vm_license_file_node1](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/network_file) | resource |
| [equinix_network_ssh_key.johndoe_cluster](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/network_ssh_key) | resource |
| [equinix_network_device_type.fg_vm_type](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/network_device_type) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | API Consumer Key available under 'My Apps' in developer portal. This argument can also be specified with the EQUINIX\_API\_CLIENTID shell environment variable. | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | API Consumer secret available under 'My Apps' in developer portal. This argument can also be specified with the EQUINIX\_API\_CLIENTSECRET shell environment variable. | `string` | n/a | yes |
| <a name="input_metro_code_cluster"></a> [metro\_code\_cluster](#input\_metro\_code\_cluster) | Device location metro code | `string` | n/a | yes |
| <a name="input_ssh_rsa_public_key"></a> [ssh\_rsa\_public\_key](#input\_ssh\_rsa\_public\_key) | SSH RSA public key | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_device_details"></a> [device\_details](#output\_device\_details) | Virtual device details |
<!-- END_TF_DOCS -->