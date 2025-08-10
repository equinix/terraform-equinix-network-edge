data "equinix_network_device_type" "this" {
  name = "Aviatrix Edge 7.1"
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

resource "equinix_network_device" "aviatrix_edge_7_1" {
  self_managed         = true
  byol                 = true
  name                 = var.name
  type_code            = data.equinix_network_device_type.this.code
  package_code         = var.software_package
  version              = length(var.vnf_version) > 0 ? var.vnf_version : data.equinix_network_device_software.this.version
  core_count           = data.equinix_network_device_platform.this.core_count
  project_id           = var.project_id
  metro_code           = var.metro_code
  account_number       = var.account_number
  connectivity         = var.connectivity
  term_length          = var.term_length
  interface_count      = var.interface_count
  notifications        = var.notifications
  cloud_init_file_id   = var.cloud_init_file_id
  acl_template_id      = var.connectivity != "PRIVATE" ? var.acl_template_id : null
  additional_bandwidth = var.additional_bandwidth > 0 ? var.additional_bandwidth : null

  dynamic "secondary_device" {
    for_each = var.secondary.enabled ? [1] : []
    content {
      name               = var.secondary.name
      cloud_init_file_id = var.secondary.cloud_init_file_id
      metro_code         = var.secondary.metro_code
      account_number     = var.secondary.account_number
      notifications      = var.notifications
      acl_template_id    = var.connectivity != "PRIVATE" ? var.secondary.acl_template_uuid : null
    }
  }
}
