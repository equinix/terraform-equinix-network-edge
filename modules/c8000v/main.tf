data "equinix_network_device_type" "this" {
  category = "ROUTER"
  vendor   = "Cisco"
}

data "equinix_network_device_platform" "this" {
  device_type = data.equinix_network_device_type.this.code
  flavor      = var.platform
}

data "equinix_network_device_software" "this" {
  device_type = data.equinix_network_device_type.this.code
  packages    = [var.software_package]
  stable      = true
  most_recent = true
}

resource "equinix_network_device" "non_cluster" {
  self_managed         = true
  byol                 = var.byol
  name                 = var.name
  project_id           = var.project_id
  hostname             = var.hostname
  type_code            = data.equinix_network_device_type.this.code
  package_code         = var.software_package
  version              = data.equinix_network_device_software.this.version
  core_count           = data.equinix_network_device_platform.this.core_count
  metro_code           = var.metro_code
  connectivity         = var.connectivity
  account_number       = var.account_number
  license_token        = var.byol ? var.license_token : null
  term_length          = var.term_length
  interface_count      = var.interface_count
  notifications        = var.notifications
  acl_template_id      = var.acl_template_id != "" ? var.acl_template_id : null
  additional_bandwidth = var.additional_bandwidth > 0 ? var.additional_bandwidth : 0
  ssh_key {
    username = var.ssh_key.userName
    key_name = var.ssh_key.keyName
  }

  dynamic "secondary_device" {
    for_each = var.secondary.enabled ? [1] : []
    content {
      name                 = "${var.name}-secondary"
      license_token        = try(var.secondary.license_token, null)
      hostname             = var.secondary.hostname
      metro_code           = var.secondary.metro_code
      account_number       = var.secondary.account_number
      notifications        = var.notifications
      acl_template_id      = try(var.secondary.acl_template_id, null)
      additional_bandwidth = var.additional_bandwidth > 0 ? var.additional_bandwidth : 0
      ssh_key {
        username = var.ssh_key.userName
        key_name = var.ssh_key.keyName
      }
    }
  }
}
