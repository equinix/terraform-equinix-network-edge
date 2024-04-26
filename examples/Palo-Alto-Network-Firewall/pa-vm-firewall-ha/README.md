# Network Edge Palo Alto Firewall HA Device Example

This example demonstrates creation of Network Edge Palo Alto Firewall HA device. It will:

- Create a ACL template
- Create an SSH key
- Provision Palo Alto Firewall HA device

## Usage

To provision this example, you should clone the github repository and run terraform from within this directory:

```bash
git clone https://github.com/equinix/terraform-equinix-network-edge.git
cd terraform-equinix-network-edge/examples/pa-vm-firewall-ha
terraform init
terraform apply
```

Note that this example may create resources which cost money. Run 'terraform destroy' when you don't need these
resources.

To use this example of the module in your own terraform configuration include the following:

*NOTE: terraform.tfvars must be a separate file, but all other content can be placed together in main.tf if you prefer*

terraform.tfvars (Replace these values with your own):

```hcl

equinix_client_id     = "<MyEquinixClientId>"
equinix_client_secret = "<MyEquinixSecret>"

name                 = "tf-pa-vm-ha"
metro_code           = var.metro_code_primary
platform             = "medium"
account_number       = "123456"
software_package     = "VM300"
project_id           = "e6be59d9-62c0-4140-aad6-150f0700203c"
software_version     = "10.1.10"
term_length          = 1
notifications        = ["test@test.com"]
hostname             = "pavm-pri"
additional_bandwidth = 100
acl_template_id      = equinix_network_acl_template.pa-vm-pri.id
ssh_key              = {
  userName = "johndoe-primary"
  keyName  = equinix_network_ssh_key.johndoe-pri.name
}
secondary = {
  enabled              = true
  metro_code           = var.metro_code_secondary
  hostname             = "nginx-sec"
  account_number       = "123456"
  additional_bandwidth = 50
  acl_template_id      = equinix_network_acl_template.pa-vm-sec.id
}
license_token = "123456"

```

versions.tf:

```hcl

terraform {
  required_version = ">= 0.13"
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = "~> 1.34.0"
    }
  }
}
```

variables.tf:

```hcl

variable "equinix_client_id" {
  type        = string
  description = "API Consumer Key available under 'My Apps' in developer portal. This argument can also be specified with the EQUINIX_API_CLIENTID shell environment variable."
}

variable "equinix_client_secret" {
  type        = string
  description = "API Consumer secret available under 'My Apps' in developer portal. This argument can also be specified with the EQUINIX_API_CLIENTSECRET shell environment variable."
}

variable "metro_code_primary" {
  description = "Device location metro code"
  type        = string
}

variable "metro_code_secondary" {
  description = "Device location metro code"
  type        = string
}
variable "ssh_rsa_public_key" {
  description = "SSH RSA public key"
  type        = string
}
```

outputs.tf:

```hcl

output "device_details" {
  description = "Virtual device details"
  value       = module.pa-vm-ha
}

```

main.tf:

```hcl

provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "pa-vm-ha" {
  source               = "../../modules/Palo-Alto-Network-Firewall"
  # source               = "equinix/pa-vm/equinix"
  # version              = "1.1.0" # Use the latest version, according to https://github.com/equinix/terraform-equinix-pa-vm/releases
  name                 = "tf-pa-vm-ha"
  metro_code           = var.metro_code_primary
  platform             = "medium"
  account_number       = "123456"
  software_package     = "VM300"
  project_id           = "e6be59d9-62c0-4140-aad6-150f0700203c"
  #  software_version     = "10.1.10"
  term_length          = 1
  notifications        = ["test@test.com"]
  hostname             = "pavm-pri"
  additional_bandwidth = 100
  acl_template_id      = equinix_network_acl_template.pa-vm-pri.id
  ssh_key              = {
    userName = "johndoe-primary"
    keyName  = equinix_network_ssh_key.johndoe-pri.name
  }
  secondary = {
    enabled              = true
    metro_code           = var.metro_code_secondary
    hostname             = "nginx-sec"
    account_number       = "123456"
    additional_bandwidth = 50
    acl_template_id      = equinix_network_acl_template.pa-vm-sec.id
  }
  license_token = ""
}

resource "equinix_network_ssh_key" "johndoe-pri" {
  name       = "johndoe-pri-0414-8"
  public_key = var.ssh_rsa_public_key
  project_id = "e6be59d9-62c0-4140-aad6-150f0700203c"
}

resource "equinix_network_ssh_key" "johndoe-sec" {
  name       = "johndoe-sec-0414-8"
  public_key = var.ssh_rsa_public_key
}

resource "equinix_network_acl_template" "pa-vm-pri" {
  name        = "tf-pa-vm-pri"
  description = "Primary Palo Alto Networks VM ACL template"
  project_id  = "e6be59d9-62c0-4140-aad6-150f0700203c"
  inbound_rule {
    subnet   = "12.16.103.0/24"
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}

resource "equinix_network_acl_template" "pa-vm-sec" {
  name        = "tf-pa-vm-sec"
  description = "Secondary Palo Alto Networks VM ACL template"
  inbound_rule {
    subnet   = "172.16.25.0/24"
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}

```

<!-- End Example Usage -->



<!-- TEMPLATE: The following block has been generated by terraform-docs util: https://github.com/terraform-docs/terraform-docs -->
<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                      | Version   |
|---------------------------------------------------------------------------|-----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.4  |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix)       | ~> 1.34.0 |

## Providers

| Name                                                          | Version   |
|---------------------------------------------------------------|-----------|
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | ~> 1.34.0 |

## Resources

| Name                                                                                                                                                 | Type     |
|------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [equinix_network_acl_template.pa-vm-pri](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/equinix_network_acl_template) | resource |
| [equinix_network_ssh_key.johndoe](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/equinix_network_ssh_key)             | resource |

## Inputs

| Name                                                                                                  | Description                                                                                                                                                            | Type     | Default | Required |
|-------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|---------|:--------:|
| <a name="input_equinix_client_id"></a> [equinix\_client\_id](#input\_equinix\_client\_id)             | API Consumer Key available under 'My Apps' in developer portal. This argument can also be specified with the EQUINIX\_API\_CLIENTID shell environment variable.        | `string` | n/a     |   yes    |
| <a name="input_equinix_client_secret"></a> [equinix\_client\_secret](#input\_equinix\_client\_secret) | API Consumer secret available under 'My Apps' in developer portal. This argument can also be specified with the EQUINIX\_API\_CLIENTSECRET shell environment variable. | `string` | n/a     |   yes    |
| <a name="input_metro_code_primary"></a> [metro\_code\_primary](#input\_metro\_code\_primary)          | Device location metro code                                                                                                                                             | `string` | n/a     |   yes    |
| <a name="input_ssh_rsa_public_key"></a> [ssh\_rsa\_public\_key](#input\_ssh\_rsa\_public\_key)        | SSH RSA public key                                                                                                                                                     | `string` | n/a     |   yes    |

## Outputs

| Name                                                                             | Description            |
|----------------------------------------------------------------------------------|------------------------|
| <a name="output_device_details"></a> [device\_details](#output\_device\_details) | Virtual device details |

<!-- END_TF_DOCS -->
