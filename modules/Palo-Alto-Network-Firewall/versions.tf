terraform {
  required_version = ">= 1.3"
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = "~> 1.34.0"
    }
  }
  provider_meta "equinix" {
    module_name = "terraform-equinix-network-edge"
  }
}
