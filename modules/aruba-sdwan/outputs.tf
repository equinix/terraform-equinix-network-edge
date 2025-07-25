output "id" {
  description = "Device identifier"
  value       = equinix_network_device.single.uuid
}

output "status" {
  description = "Device provisioning status"
  value       = equinix_network_device.single.status
}

output "license_status" {
  description = "Device license status"
  value       = equinix_network_device.single.license_status
}

output "account_number" {
  description = "Device billing account number"
  value       = equinix_network_device.single.account_number
}

output "cpu_count" {
  description = "Device CPU cores count"
  value       = data.equinix_network_device_platform.this.core_count
}

output "memory" {
  description = "Device memory amount"
  value = join(" ", [
    data.equinix_network_device_platform.this.memory, data.equinix_network_device_platform.this.memory_unit
  ])
}

output "software_version" {
  description = "Device software version"
  value       = data.equinix_network_device_software.this.version
}

output "region" {
  description = "Device region"
  value       = equinix_network_device.single.region
}

output "ibx" {
  description = "Device IBX center"
  value       = equinix_network_device.single.ibx
}

output "ssh_ip_address" {
  description = "Device SSH interface IP address"
  value       = equinix_network_device.single.ssh_ip_address
}

output "ssh_ip_fqdn" {
  description = "Device SSH interface FQDN"
  value       = equinix_network_device.single.ssh_ip_fqdn
}

output "interfaces" {
  description = "Device interfaces"
  value       = equinix_network_device.single.interface
}
