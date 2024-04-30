# Network Edge Virtual Device NGINX SubModule

The Network Edge Virtual Device NGINX Module will create NGINX devices on the Equinix
Network edge platform.

1. Single or Non HA device
2. HA devices
3. Cluster devices

Please refer to the nginx-* examples in this module's registry for more details on how to leverage the
submodule.

<!-- Begin Module Docs (Do not edit contents) -->

## Equinix Network Edge Developer Documentation

To see the documentation for the APIs that the Network Edge Terraform Provider is built on
and to learn how to procure your own Client_Id and Client_Secret follow the link below:
[Equinix Network Edge Developer Portal](https://developer.equinix.com/catalog/network-edgev1)
<!-- End Module Docs -->

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                      | Version |
|---------------------------------------------------------------------------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3  |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix)       | >= 1.34 |

## Providers

| Name                                                          | Version |
|---------------------------------------------------------------|---------|
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | >= 1.34 |

## Modules

No modules.

## Resources

| Name                                                                                                                                             | Type        |
|--------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [equinix_network_device.cluster](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/network_device)                   | resource    |
| [equinix_network_device.non_cluster](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/network_device)               | resource    |
| [equinix_network_device_platform.this](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/network_device_platform) | data source |
| [equinix_network_device_software.this](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/network_device_software) | data source |
| [equinix_network_device_type.this](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/network_device_type)         | data source |

## Inputs

| Name                                                                                                       | Description                                                                                                      | Type                                                                          | Default                                 | Required |
|------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------|-----------------------------------------|:--------:|
| <a name="input_metro_code"></a> [metro\_code](#input\_metro\_code)                                         | Device location metro code                                                                                       | `string`                                                                      | n/a                                     |   yes    |
| <a name="input_name"></a> [name](#input\_name)                                                             | Device name                                                                                                      | `string`                                                                      | n/a                                     |   yes    |
| <a name="input_notifications"></a> [notifications](#input\_notifications)                                  | List of email addresses that will receive device status notifications                                            | `list(string)`                                                                | n/a                                     |   yes    |
| <a name="input_platform"></a> [platform](#input\_platform)                                                 | Device platform flavor that determines number of CPU cores and memory                                            | `string`                                                                      | n/a                                     |   yes    |
| <a name="input_software_package"></a> [software\_package](#input\_software\_package)                       | Device software package                                                                                          | `string`                                                                      | n/a                                     |   yes    |
| <a name="input_ssh_key"></a> [ssh\_key](#input\_ssh\_key)                                                  | SSH public key for a device                                                                                      | <pre>object({<br>    userName = string<br>    keyName  = string<br>  })</pre> | n/a                                     |   yes    |
| <a name="input_term_length"></a> [term\_length](#input\_term\_length)                                      | Term length in months                                                                                            | `number`                                                                      | n/a                                     |   yes    |
| <a name="input_account_number"></a> [account\_number](#input\_account\_number)                             | Billing account number for a device                                                                              | `string`                                                                      | `0`                                     |    no    |
| <a name="input_additional_bandwidth"></a> [additional\_bandwidth](#input\_additional\_bandwidth)           | Additional internet bandwidth for a device                                                                       | `number`                                                                      | `0`                                     |    no    |
| <a name="input_cluster"></a> [cluster](#input\_cluster)                                                    | cluster device attributes                                                                                        | `map(any)`                                                                    | <pre>{<br>  "enabled": false<br>}</pre> |    no    |
| <a name="input_hostname"></a> [hostname](#input\_hostname)                                                 | Device hostname                                                                                                  | `string`                                                                      | `""`                                    |    no    |
| <a name="input_interface_count"></a> [interface\_count](#input\_interface\_count)                          | Number of network interfaces on a device. If not specified, default number for a given device type will be used. | `number`                                                                      | `10`                                    |    no    |
| <a name="input_mgmt_acl_template_uuid"></a> [mgmt\_acl\_template\_uuid](#input\_mgmt\_acl\_template\_uuid) | Identifier of an management ACL template that will be applied on a device                                        | `string`                                                                      | `""`                                    |    no    |
| <a name="input_secondary"></a> [secondary](#input\_secondary)                                              | Secondary device attributes                                                                                      | `map(any)`                                                                    | <pre>{<br>  "enabled": false<br>}</pre> |    no    |

## Outputs

| Name                                                                                   | Description                     |
|----------------------------------------------------------------------------------------|---------------------------------|
| <a name="output_account_number"></a> [account\_number](#output\_account\_number)       | Device billing account number   |
| <a name="output_cpu_count"></a> [cpu\_count](#output\_cpu\_count)                      | Device CPU cores count          |
| <a name="output_ibx"></a> [ibx](#output\_ibx)                                          | Device IBX center               |
| <a name="output_id"></a> [id](#output\_id)                                             | Device identifier               |
| <a name="output_interfaces"></a> [interfaces](#output\_interfaces)                     | Device interfaces               |
| <a name="output_license_status"></a> [license\_status](#output\_license\_status)       | Device license status           |
| <a name="output_memory"></a> [memory](#output\_memory)                                 | Device memory amount            |
| <a name="output_region"></a> [region](#output\_region)                                 | Device region                   |
| <a name="output_secondary"></a> [secondary](#output\_secondary)                        | Secondary device attributes     |
| <a name="output_software_version"></a> [software\_version](#output\_software\_version) | Device software version         |
| <a name="output_ssh_ip_address"></a> [ssh\_ip\_address](#output\_ssh\_ip\_address)     | Device SSH interface IP address |
| <a name="output_ssh_ip_fqdn"></a> [ssh\_ip\_fqdn](#output\_ssh\_ip\_fqdn)              | Device SSH interface FQDN       |
| <a name="output_status"></a> [status](#output\_status)                                 | Device provisioning status      |

<!-- END_TF_DOCS -->
