output "id" {
  description = "Device identifier"
  value       = !var.cluster.enabled ? equinix_network_device.non_cluster[0].uuid : equinix_network_device.cluster[0].uuid
}

output "status" {
  description = "Device provisioning status"
  value       = !var.cluster.enabled ? equinix_network_device.non_cluster[0].status : equinix_network_device.cluster[0].status
}

output "license_status" {
  description = "Device license status"
  value       = !var.cluster.enabled ? equinix_network_device.non_cluster[0].license_status : equinix_network_device.cluster[0].license_status
}

output "account_number" {
  description = "Device billing account number"
  value       = !var.cluster.enabled ? equinix_network_device.non_cluster[0].account_number : equinix_network_device.cluster[0].account_number
}

output "cpu_count" {
  description = "Device CPU cores count"
  value       = data.equinix_network_device_platform.this.core_count
}

output "memory" {
  description = "Device memory amount"
  value       = join(" ", [data.equinix_network_device_platform.this.memory, data.equinix_network_device_platform.this.memory_unit])
}

output "software_version" {
  description = "Device software version"
  value       = !var.cluster.enabled ? equinix_network_device.non_cluster[0].version : equinix_network_device.cluster[0].version
}

output "region" {
  description = "Device region"
  value       = !var.cluster.enabled ? equinix_network_device.non_cluster[0].region : equinix_network_device.cluster[0].region
}

output "ibx" {
  description = "Device IBX center"
  value       = !var.cluster.enabled ? equinix_network_device.non_cluster[0].ibx : equinix_network_device.cluster[0].ibx
}

output "ssh_ip_address" {
  description = "Device SSH interface IP address"
  value       = !var.cluster.enabled ? equinix_network_device.non_cluster[0].ssh_ip_address : equinix_network_device.cluster[0].ssh_ip_address
}

output "ssh_ip_fqdn" {
  description = "Device SSH interface FQDN"
  value       = !var.cluster.enabled ? equinix_network_device.non_cluster[0].ssh_ip_fqdn : equinix_network_device.cluster[0].ssh_ip_fqdn
}

output "interfaces" {
  description = "Device interfaces"
  value       = !var.cluster.enabled ? equinix_network_device.non_cluster[0].interface : equinix_network_device.cluster[0].interface
}

output "secondary" {
  description = "Secondary device attributes"
  value = !var.cluster.enabled && var.secondary.enabled ? {
    id             = equinix_network_device.non_cluster[0].secondary_device[0].uuid
    status         = equinix_network_device.non_cluster[0].secondary_device[0].status
    license_status = equinix_network_device.non_cluster[0].secondary_device[0].license_status
    account_number = equinix_network_device.non_cluster[0].secondary_device[0].account_number
    region         = equinix_network_device.non_cluster[0].secondary_device[0].region
    ibx            = equinix_network_device.non_cluster[0].secondary_device[0].ibx
    ssh_ip_address = equinix_network_device.non_cluster[0].secondary_device[0].ssh_ip_address
    ssh_ip_fqdn    = equinix_network_device.non_cluster[0].secondary_device[0].ssh_ip_fqdn
    interfaces     = equinix_network_device.non_cluster[0].secondary_device[0].interface
  } : null
}
