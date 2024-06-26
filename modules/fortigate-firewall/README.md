# Network Edge Virtual Device Fortinet FortiGate Firewall SubModule

The Network Edge Virtual Device Fortinet FortiGate Firewall Module will create Fortinet FortiGate firewall devices on the Equinix
Network Edge platform.

1. Single or Non HA device
2. HA devices
3. Cluster devices

Please refer to the fg-vm-* examples in this module's registry for more details on how to leverage the
submodule.

<!-- Begin Module Docs (Do not edit contents) -->

## Equinix Network Edge Developer Documentation

To see the documentation for the APIs that the Network Edge Terraform Provider is built on
and to learn how to procure your own Client_Id and Client_Secret follow the link below:
[Equinix Network Edge Developer Portal](https://developer.equinix.com/catalog/network-edgev1)
<!-- End Module Docs -->

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | >= 1.34.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | >= 1.34.0 |

## Modules

No modules.

## Resources

| Name                                                                                                                                                     | Type |
|----------------------------------------------------------------------------------------------------------------------------------------------------------|------|
| [equinix_network_device.cluster](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/equinix_network_device)                   | resource |
| [equinix_network_device.non_cluster](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/equinix_network_device)               | resource |
| [equinix_network_device_platform.this](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/equinix_network_device_platform) | data source |
| [equinix_network_device_software.this](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/equinix_network_device_software) | data source |
| [equinix_network_device_type.this](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/equinix_network_device_type)         | data source |

## Inputs

| Name | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                           | Type | Default | Required |
|------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------|---------|:--------:|
| <a name="input_account_number"></a> [account\_number](#input\_account\_number) | Billing account number for a device                                                                                                                                                                                                                                                                                                                                                                                                                                   | `string` | n/a | yes |
| <a name="input_acl_template_id"></a> [acl\_template\_id](#input\_acl\_template\_id) | Identifier of an ACL template that will be applied on a device                                                                                                                                                                                                                                                                                                                                                                                                        | `string` | n/a | yes |
| <a name="input_metro_code"></a> [metro\_code](#input\_metro\_code) | Device location metro code. Please refer to [available metros](https://docs.equinix.com/en-us/Content/Interconnection/NE/user-guide/NE-metros.htm)                                                                                                                                                                                                                                                                                                                    | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Device name                                                                                                                                                                                                                                                                                                                                                                                                                                                           | `string` | n/a | yes |
| <a name="input_notifications"></a> [notifications](#input\_notifications) | List of email addresses that will receive device status notifications                                                                                                                                                                                                                                                                                                                                                                                                 | `list(string)` | n/a | yes |
| <a name="input_platform"></a> [platform](#input\_platform) | Device platform flavor that determines number of CPU cores and memory                                                                                                                                                                                                                                                                                                                                                                                                 | `string` | n/a | yes |
| <a name="input_software_package"></a> [software\_package](#input\_software\_package) | Device software package. Use [equinix_network_device_software](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/equinix_network_device_software) data source with device type code to find the supported package codes                                                                                                                                                                                                                | `string` | n/a | yes |
| <a name="input_ssh_key"></a> [ssh\_key](#input\_ssh\_key) | SSH public key for a device                                                                                                                                                                                                                                                                                                                                                                                                                                           | <pre>object({<br>    username = string<br>    key_name = string<br>  })</pre> | n/a | yes |
| <a name="input_term_length"></a> [term\_length](#input\_term\_length) | Term length in months                                                                                                                                                                                                                                                                                                                                                                                                                                                 | `number` | n/a | yes |
| <a name="input_additional_bandwidth"></a> [additional\_bandwidth](#input\_additional\_bandwidth) | Additional internet bandwidth for a device                                                                                                                                                                                                                                                                                                                                                                                                                            | `number` | `0` | no |
| <a name="input_cluster"></a> [cluster](#input\_cluster) | Cluster device attributes                                                                                                                                                                                                                                                                                                                                                                                                                                             | <pre>object({<br>    enabled = bool<br>    name    = string<br>    node0 = object({<br>      vendor_configuration = object({<br>        hostname = string<br>      })<br>      license_file_id = optional(string)<br>      license_token   = optional(string)<br>    })<br>    node1 = object({<br>      vendor_configuration = object({<br>        hostname = string<br>      })<br>      license_file_id = optional(string)<br>      license_token   = optional(string)<br>    })<br>  })</pre> | <pre>{<br>  "enabled": false,<br>  "name": null,<br>  "node0": {<br>    "license_file_id": null,<br>    "license_token": null,<br>    "vendor_configuration": {<br>      "hostname": null<br>    }<br>  },<br>  "node1": {<br>    "license_file_id": null,<br>    "license_token": null,<br>    "vendor_configuration": {<br>      "hostname": null<br>    }<br>  }<br>}</pre> | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Device hostname prefix                                                                                                                                                                                                                                                                                                                                                                                                                                                | `string` | `null` | no |
| <a name="input_interface_count"></a> [interface\_count](#input\_interface\_count) | Number of network interfaces on a device                                                                                                                                                                                                                                                                                                                                                                                                                              | `number` | `10` | no |
| <a name="input_license_file"></a> [license\_file](#input\_license\_file) | Path to the device license file                                                                                                                                                                                                                                                                                                                                                                                                                                       | `string` | `null` | no |
| <a name="input_license_token"></a> [license\_token](#input\_license\_token) | License token                                                                                                                                                                                                                                                                                                                                                                                                                                                         | `string` | `null` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Unique identifier for the project resource where the device is scoped to                                                                                                                                                                                                                                                                                                                                                                                              | `string` | `null` | no |
| <a name="input_secondary"></a> [secondary](#input\_secondary) | Secondary device attributes                                                                                                                                                                                                                                                                                                                                                                                                                                           | <pre>object({<br>    enabled              = bool<br>    name                 = string<br>    hostname             = string<br>    metro_code           = string<br>    license_token        = optional(string)<br>    license_file         = optional(string)<br>    account_number       = string<br>    notifications        = list(string)<br>    additional_bandwidth = optional(number)<br>    acl_template_id      = string<br>  })</pre> | <pre>{<br>  "account_number": null,<br>  "acl_template_id": null,<br>  "additional_bandwidth": null,<br>  "enabled": false,<br>  "hostname": null,<br>  "license_file": null,<br>  "license_token": null,<br>  "metro_code": null,<br>  "name": null,<br>  "notifications": null<br>}</pre> | no |
| <a name="input_version_number"></a> [version\_number](#input\_version\_number) | Device software package version number. Please refer to [certified VNF versions](https://docs.equinix.com/en-us/Content/Interconnection/NE/user-guide/NE-certified-VNFs.htm) document for the supported versions. If this value is not passed most recent and stable version will be used by invoking [equinix_network_device_software](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/equinix_network_device_software) data source | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_account_number"></a> [account\_number](#output\_account\_number) | Device billing account number |
| <a name="output_cpu_count"></a> [cpu\_count](#output\_cpu\_count) | Device CPU cores count |
| <a name="output_ibx"></a> [ibx](#output\_ibx) | Device IBX center |
| <a name="output_id"></a> [id](#output\_id) | Device identifier |
| <a name="output_interfaces"></a> [interfaces](#output\_interfaces) | Device interfaces |
| <a name="output_license_status"></a> [license\_status](#output\_license\_status) | Device license status |
| <a name="output_memory"></a> [memory](#output\_memory) | Device memory amount |
| <a name="output_region"></a> [region](#output\_region) | Device region |
| <a name="output_secondary"></a> [secondary](#output\_secondary) | Secondary device attributes |
| <a name="output_software_version"></a> [software\_version](#output\_software\_version) | Device software version |
| <a name="output_ssh_ip_address"></a> [ssh\_ip\_address](#output\_ssh\_ip\_address) | Device SSH interface IP address |
| <a name="output_ssh_ip_fqdn"></a> [ssh\_ip\_fqdn](#output\_ssh\_ip\_fqdn) | Device SSH interface FQDN |
| <a name="output_status"></a> [status](#output\_status) | Device provisioning status |
<!-- END_TF_DOCS -->
