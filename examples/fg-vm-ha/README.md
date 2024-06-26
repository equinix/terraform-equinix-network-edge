# Network Edge Fortinet FortiGate Firewall HA Device Example

This example demonstrates creation of Network Edge Fortinet FortiGate Firewall HA device. It will:

- Create two ACL templates
- Create an SSH key
- Provision Fortinet FortiGate Firewall HA device

## Usage

To provision this example, you should clone the github repository and run terraform from within this directory:

```bash
git clone https://github.com/equinix/terraform-equinix-network-edge.git
cd terraform-equinix-network-edge/examples/fg-vm-ha
terraform init
terraform apply
```

Note that this example may create resources which cost money. Run 'terraform destroy' when you don't need these resources.

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
| <a name="module_fg_vm_ha"></a> [fg\_vm\_ha](#module\_fg\_vm\_ha) | ../../modules/fortigate-firewall | n/a |

## Resources

| Name                                                                                                                                                     | Type |
|----------------------------------------------------------------------------------------------------------------------------------------------------------|------|
| [equinix_network_acl_template.fortigate_pri](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/equinix_network_acl_template) | resource |
| [equinix_network_acl_template.fortigate_sec](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/equinix_network_acl_template) | resource |
| [equinix_network_ssh_key.johndoe](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/equinix_network_ssh_key)                 | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id) | API Consumer Key available under 'My Apps' in developer portal. This argument can also be specified with the EQUINIX\_API\_CLIENTID shell environment variable. | `string` | n/a | yes |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | API Consumer secret available under 'My Apps' in developer portal. This argument can also be specified with the EQUINIX\_API\_CLIENTSECRET shell environment variable. | `string` | n/a | yes |
| <a name="input_metro_code_primary"></a> [metro\_code\_primary](#input\_metro\_code\_primary) | Primary device location metro code | `string` | n/a | yes |
| <a name="input_metro_code_secondary"></a> [metro\_code\_secondary](#input\_metro\_code\_secondary) | Secondary device location metro code | `string` | n/a | yes |
| <a name="input_ssh_rsa_public_key"></a> [ssh\_rsa\_public\_key](#input\_ssh\_rsa\_public\_key) | SSH RSA public key | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_device_details"></a> [device\_details](#output\_device\_details) | Virtual device details |
<!-- END_TF_DOCS -->
