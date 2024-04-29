# Network Edge Device Nginx Single Device Example

This example demonstrates creation of Network Edge NGINX single device. It will:

- Create a management ACL template
- Create a SSH key
- Provision NGINX single device

## Usage

To provision this example, you should clone the github repository and run terraform from within this directory:

```bash
git clone https://github.com/equinix-labs/terraform-equinix-nework-edge-device-nginx.git
cd terraform-equinix-nework-edge-device-nginx/examples/nginx-single
terraform init
terraform apply
```

Note that this example may create resources which cost money. Run 'terraform destroy' when you don't need these resources.

## Variables

See <https://registry.terraform.io/modules/equinix-labs/network-edge-device-nginx/equinix/latest?tab=inputs> for a description of all variables.

## Outputs

See <https://registry.terraform.io/modules/equinix-labs/network-edge-device-nginx/equinix/latest?tab=outputs> for a description of all outputs.
