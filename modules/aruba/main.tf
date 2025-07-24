locals {
  equinix_network_device_type_code = "EDGECONNECT-SDWAN"
}

data "equinix_network_device_platform" "this" {
  device_type = local.equinix_network_device_type_code
  flavor      = var.platform
}

data "equinix_network_device_software" "this" {
  device_type = local.equinix_network_device_type_code
  packages    = [var.software_package]
  stable      = true
  most_recent = true
}

resource "equinix_network_device" "single" {
  name                 = var.name
  account_number       = var.account_number
  project_id           = var.project_id
  metro_code           = var.metro_code
  type_code            = local.equinix_network_device_type_code
  self_managed         = true
  byol                 = var.byol
  package_code         = var.software_package
  notifications        = var.notifications
  version              = data.equinix_network_device_software.this.version
  core_count           = data.equinix_network_device_platform.this.core_count
  term_length          = var.term_length
  additional_bandwidth = var.additional_bandwidth > 0 ? var.additional_bandwidth : null
  interface_count      = var.interface_count
  acl_template_id      = var.acl_template_id
  ssh_key {
    username = var.ssh_key.userName
    key_name = var.ssh_key.keyName
  }
}
