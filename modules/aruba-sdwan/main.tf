locals {
  equinix_network_device_type_code = "EDGECONNECT-SDWAN"
}

data "equinix_network_device_platform" "this" {
  device_type = local.equinix_network_device_type_code
  flavor      = var.platform
}

data "equinix_network_device_software" "this" {
  device_type = local.equinix_network_device_type_code
  packages    = [var.package_code]
  stable      = true
  most_recent = true
}

resource "equinix_network_device" "ha" {
  name                 = var.name
  account_number       = var.account_number
  project_id           = var.project_id
  metro_code           = var.metro_code
  type_code            = local.equinix_network_device_type_code
  self_managed         = true
  byol                 = var.byol
  package_code         = var.package_code
  notifications        = var.notifications
  version              = var.version_number != "" ? var.version_number : data.equinix_network_device_software.this.version
  core_count           = data.equinix_network_device_platform.this.core_count
  term_length          = var.term_length
  additional_bandwidth = var.additional_bandwidth > 0 ? var.additional_bandwidth : null
  interface_count      = var.interface_count
  acl_template_id      = var.acl_template_id
  vendor_configuration = {
    accountKey   = var.vendor_configuration.accountKey
    accountName  = var.vendor_configuration.accountName
    applianceTag = var.vendor_configuration.applianceTag
    hostname     = var.vendor_configuration.hostname
  }

  dynamic "secondary_device" {
    for_each = var.secondary.enabled ? [1] : []
    content {
      name                 = var.secondary.name
      license_token        = try(var.secondary.license_token, null)
      metro_code           = var.secondary.metro_code
      account_number       = var.secondary.account_number
      notifications        = var.notifications
      acl_template_id      = try(var.secondary.acl_template_id, null)
      additional_bandwidth = var.additional_bandwidth > 0 ? var.additional_bandwidth : null
      vendor_configuration = {
        accountKey   = var.secondary.vendor_configuration.accountKey
        accountName  = var.secondary.vendor_configuration.accountName
        applianceTag = var.secondary.vendor_configuration.applianceTag
        hostname     = var.secondary.vendor_configuration.hostname
      }
    }
  }
}
