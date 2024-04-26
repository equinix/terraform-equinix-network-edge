data "equinix_network_device_type" "this" {
  category = "FIREWALL"
  vendor   = "Palo Alto Networks"
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

  count = !var.cluster.enabled ? 1 : 0
  lifecycle {
    ignore_changes = [version, core_count]
    precondition {
      condition     = length(var.hostname) >= 2 && length(var.hostname) <= 10
      error_message = "Device hostname should consist of 2 to 10 characters."
    }
  }
  self_managed         = true
  byol                 = true
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
  term_length          = var.term_length
  interface_count      = var.interface_count
  notifications        = var.notifications
  acl_template_id      = var.acl_template_id != "" ? var.acl_template_id : null
  additional_bandwidth = var.additional_bandwidth > 0 ? var.additional_bandwidth : null
  ssh_key {
    username = var.ssh_key.userName
    key_name = var.ssh_key.keyName
  }

  dynamic "secondary_device" {
    for_each = var.secondary.enabled ? [1] : []
    content {
      name                 = "${var.name}-secondary"
      hostname             = var.secondary.hostname
      metro_code           = var.secondary.metro_code
      account_number       = var.secondary.account_number
      notifications        = var.notifications
      acl_template_id      = try(var.secondary.acl_template_id, null)
      additional_bandwidth = var.additional_bandwidth > 0 ? var.additional_bandwidth : null
      ssh_key {
        username = var.ssh_key.userName
        key_name = var.ssh_key.keyName
      }
    }
  }
}

resource "equinix_network_device" "cluster" {
  count = var.cluster.enabled ? 1 : 0
  lifecycle {
    ignore_changes = [version, core_count]
  }
  self_managed           = true
  byol                   = true
  name                   = var.name
  type_code              = data.equinix_network_device_type.this.code
  package_code           = var.software_package
  version                = data.equinix_network_device_software.this.version
  core_count             = data.equinix_network_device_platform.this.core_count
  metro_code             = var.metro_code
  account_number         = var.account_number
  term_length            = var.term_length
  interface_count        = var.interface_count
  notifications          = var.notifications
  connectivity           = var.connectivity
  acl_template_id        = var.acl_template_id != "" ? var.acl_template_id : null
  mgmt_acl_template_uuid = var.mgmt_acl_template_uuid != "" ? var.mgmt_acl_template_uuid : null
  additional_bandwidth   = var.additional_bandwidth > 0 ? var.additional_bandwidth : null
  ssh_key {
    username = var.ssh_key.userName
    key_name = var.ssh_key.keyName
  }
  cluster_details {
    cluster_name = var.cluster.name
    node0 {
      vendor_configuration {
        hostname = var.cluster.node0_vendor_configuration_hostname
      }
      license_token = var.license_token
    }
    node1 {
      vendor_configuration {
        hostname = var.cluster.node1_vendor_configuration_hostname
      }
      license_token = var.license_token
    }

  }
}
