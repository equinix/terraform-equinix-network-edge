data "equinix_network_device_type" "this" {
  name = "Catalyst 8000V (Controller Mode)"
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

resource "equinix_network_device" "c8000v_sdwan" {
  self_managed         = true
  byol                 = true
  name                 = var.name
  type_code            = data.equinix_network_device_type.this.code
  package_code         = var.software_package
  version              = data.equinix_network_device_software.this.version
  core_count           = data.equinix_network_device_platform.this.core_count
  metro_code           = var.metro_code
  account_number       = var.account_number
  term_length          = var.term_length
  interface_count      = var.interface_count
  notifications        = var.notifications
  cloud_init_file_id   = var.cloud_init_file_id
  acl_template_id      = var.acl_template_id
  additional_bandwidth = var.additional_bandwidth > 0 ? var.additional_bandwidth : null
  vendor_configuration = {
    hostname        = var.vendor_configuration.hostname
    siteId          = var.vendor_configuration.siteId
    systemIpAddress = var.vendor_configuration.systemIpAddress
  }

  dynamic "secondary_device" {
    for_each = var.secondary.enabled ? [1] : []
    content {
      name               = "${var.name}-secondary"
      cloud_init_file_id = var.secondary.cloud_init_file_id
      metro_code         = var.secondary.metro_code
      account_number     = var.secondary.account_number
      notifications      = var.notifications
      acl_template_id    = var.secondary.acl_template_id
      vendor_configuration = {
        hostname        = var.secondary.vendor_configuration.hostname
        siteId          = var.secondary.vendor_configuration.siteId
        systemIpAddress = var.secondary.vendor_configuration.systemIpAddress
      }
    }
  }
}
