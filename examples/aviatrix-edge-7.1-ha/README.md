# Network Edge Device Aviatrix Edge 7.1 HA Device Example

This example demonstrates creation of Network Edge Aviatrix Edge 7.1 HA device. It will:

- Create a ACL template
- Upload Aviatrix bootstrap file
- Provision Aviatrix Edge 7.1 HA device

## Usage

To provision this example, you should clone the github repository and run terraform from within this directory:

```bash
git clone https://github.com/equinix/terraform-equinix-network-edge.git
cd terraform-equinix-network-edge/examples/aviatrix-edge-7.1-ha
terraform init
terraform apply
```

Note that this example may create resources which cost money. Run 'terraform destroy' when you don't need these resources.

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                      | Version |
| --------------------------------------------------------------------------- | --------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3  |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix)       | >= 1.34 |

## Providers

| Name                                                          | Version |
| --------------------------------------------------------------- | --------- |
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | >= 1.34 |

## Modules

| Name                                                                                            | Source                          | Version |
| ------------------------------------------------------------------------------------------------- | --------------------------------- | --------- |
| <a name="aviatrix-edge-7.1-single_ha"></a> [Aviatrix_Edge_7.1-ha](#aviatrix-edge-7.1-single_ha) | ../../modules/Aviatrix Edge 7.1 | n/a     |

## Resources

| Name                                                                                                                                                                             | Type     |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------- |
| [equinix_network_acl_template.aviatrix_edge_7_1_ha_wan_acl_template](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/equinix_network_acl_template) | resource |
| [equinix_network_file.aviatrix_edge_7_1_ha_bootstrap_file](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/equinix_network_file)                   | resource |

## Inputs

| Name                                                                                                  | Description                                                                                                                                                            | Type     | Default | Required |
| ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ---------- | --------- | :--------: |
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id)             | API Consumer Key available under 'My Apps' in developer portal. This argument can also be specified with the EQUINIX\_API\_CLIENTID shell environment variable.        | `string` | n/a     |   yes   |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | API Consumer secret available under 'My Apps' in developer portal. This argument can also be specified with the EQUINIX\_API\_CLIENTSECRET shell environment variable. | `string` | n/a     |   yes   |
| <a name="input_metro_code_primary"></a> [metro\_code\_primary](#input\_metro\_code\_primary)          | Device location metro code                                                                                                                                             | `string` | n/a     |   yes   |

## Outputs

| Name                                                                             | Description            |
| ---------------------------------------------------------------------------------- | ------------------------ |
| <a name="output_device_details"></a> [device\_details](#output\_device\_details) | Virtual device details |

<!-- END_TF_DOCS -->
