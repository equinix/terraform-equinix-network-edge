data "equinix_network_device_type" "this" {
  category = "FIREWALL"
  vendor   = "Fortinet"
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
  count                = !var.cluster.enabled ? 1 : 0
  self_managed         = true
  byol                 = true
  license_file         = var.license_file
  license_token        = var.license_token
  name                 = var.name
  project_id           = var.project_id
  hostname             = var.hostname
  type_code            = data.equinix_network_device_type.this.code
  package_code         = var.software_package
  version              = var.version_number != "" ? var.version_number : data.equinix_network_device_software.this.version
  core_count           = data.equinix_network_device_platform.this.core_count
  metro_code           = var.metro_code
  account_number       = var.account_number
  term_length          = var.term_length
  notifications        = var.notifications
  acl_template_id      = var.acl_template_id
  additional_bandwidth = var.additional_bandwidth > 0 ? var.additional_bandwidth : null
  interface_count      = var.interface_count
  dynamic "ssh_key" {
    for_each = var.ssh_key.username != "" ? [1] : []
    content {
      username = var.ssh_key.username
      key_name = var.ssh_key.key_name
    }
  }
  dynamic "secondary_device" {
    for_each = try(var.secondary.enabled, false) ? [1] : []
    content {
      license_file         = try(var.secondary.license_file, null)
      license_token        = try(var.secondary.license_token, null)
      name                 = var.secondary.name
      hostname             = var.secondary.hostname
      metro_code           = var.secondary.metro_code
      account_number       = var.secondary.account_number
      notifications        = var.secondary.notifications != null ? var.secondary.notifications : var.notifications
      acl_template_id      = var.secondary.acl_template_id
      additional_bandwidth = var.secondary.additional_bandwidth
      dynamic "ssh_key" {
        for_each = var.ssh_key.username != "" ? [1] : []
        content {
          username = var.ssh_key.username
          key_name = var.ssh_key.key_name
        }
      }
    }
  }
}

resource "equinix_network_device" "cluster" {
  count                = var.cluster.enabled ? 1 : 0
  self_managed         = true
  byol                 = true
  name                 = var.name
  project_id           = var.project_id
  type_code            = data.equinix_network_device_type.this.code
  package_code         = var.software_package
  version              = var.version_number != "" ? var.version_number : data.equinix_network_device_software.this.version
  core_count           = data.equinix_network_device_platform.this.core_count
  metro_code           = var.metro_code
  account_number       = var.account_number
  term_length          = var.term_length
  notifications        = var.notifications
  acl_template_id      = var.acl_template_id
  additional_bandwidth = var.additional_bandwidth > 0 ? var.additional_bandwidth : null
  interface_count      = var.interface_count
  dynamic "ssh_key" {
    for_each = var.ssh_key.username != "" ? [1] : []
    content {
      username = var.ssh_key.username
      key_name = var.ssh_key.key_name
    }
  }
  cluster_details {
    cluster_name = var.cluster.name
    node0 {
      vendor_configuration {
        hostname = var.cluster.node0.vendor_configuration.hostname
      }
      license_file_id = try(var.cluster.license_file_id, null)
      license_token   = try(var.cluster.license_token, null)
    }
    node1 {
      vendor_configuration {
        hostname = var.cluster.node1.vendor_configuration.hostname
      }
      license_file_id = try(var.cluster.license_file_id, null)
      license_token   = try(var.cluster.license_token, null)
    }
  }
}
