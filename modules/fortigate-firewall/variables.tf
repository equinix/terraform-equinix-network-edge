variable "metro_code" {
  description = "Device location metro code"
  type        = string
  validation {
    condition     = can(regex("^[A-Z]{2}$", var.metro_code))
    error_message = "Valid metro code consists of two capital letters, i.e. SV, DC."
  }
}

variable "project_id" {
  description = "Unique identifier for the project resource where the device is scoped to"
  type        = string
  default     = null
}

variable "account_number" {
  description = "Billing account number for a device"
  type        = string
  validation {
    condition     = try(length(var.account_number) > 0, false)
    error_message = "Account number is required."
  }
}

variable "platform" {
  description = "Device platform flavor that determines number of CPU cores and memory"
  type        = string
  validation {
    condition     = can(regex("^(small|medium|large|xlarge)$", var.platform))
    error_message = "One of following platform flavors are supported: small, medium, large, xlarge."
  }
}

variable "software_package" {
  description = "Device software package"
  type        = string
  validation {
    condition     = can(regex("^(VM02|VM04|VM08|VM16)$", var.software_package))
    error_message = "One of following software packages are supported: VM02, VM04, VM08, VM16."
  }
}

variable "version_number" {
  description = "Device software package version number"
  type        = string
  default     = ""
}

variable "license_file" {
  description = "Path to the device license file"
  type        = string
  default     = null
}

variable "license_token" {
  description = "License token"
  type        = string
  default     = null
}

variable "name" {
  description = "Device name"
  type        = string
  validation {
    condition     = length(var.name) >= 3 && length(var.name) <= 50
    error_message = "Device name should consist of 3 to 50 characters."
  }
}

variable "hostname" {
  description = "Device hostname prefix"
  type        = string
  default     = null
  validation {
    condition     = try(length(var.hostname) >= 2 && length(var.hostname) <= 30, true)
    error_message = "Device hostname should consist of 2 to 30 characters."
  }
}

variable "term_length" {
  description = "Term length in months"
  type        = number
  validation {
    condition     = can(regex("^(1|12|24|36)$", var.term_length))
    error_message = "One of following term lengths are available: 1, 12, 24, 36 months."
  }
}

variable "notifications" {
  description = "List of email addresses that will receive device status notifications"
  type        = list(string)
  validation {
    condition     = length(var.notifications) > 0
    error_message = "Notification list cannot be empty."
  }
}

variable "acl_template_id" {
  description = "Identifier of an ACL template that will be applied on a device"
  type        = string
  validation {
    condition     = try(length(var.acl_template_id) > 0, false)
    error_message = "Acl template is required."
  }
}

variable "additional_bandwidth" {
  description = "Additional internet bandwidth for a device"
  type        = number
  default     = 0
  validation {
    condition     = var.additional_bandwidth == 0 || (var.additional_bandwidth >= 25 && var.additional_bandwidth <= 5001)
    error_message = "Additional internet bandwidth should be between 25 and 5001 Mbps."
  }
}

variable "ssh_key" {
  description = "SSH public key for a device"
  type = object({
    username = string
    key_name = string
  })
}

variable "interface_count" {
  description = "Number of network interfaces on a device"
  type        = number
  default     = 10
  validation {
    condition     = var.interface_count == 10 || var.interface_count == 18
    error_message = "Device interface count has to be either 10 or 18."
  }
}

variable "secondary" {
  description = "Secondary device attributes"
  type = object({
    enabled              = bool
    name                 = string
    hostname             = string
    metro_code           = string
    license_token        = optional(string)
    license_file         = optional(string)
    account_number       = string
    notifications        = list(string)
    additional_bandwidth = optional(number)
    acl_template_id      = string
  })
  default = {
    enabled              = false
    name                 = null
    hostname             = null
    metro_code           = null
    license_token        = null
    license_file         = null
    account_number       = null
    notifications        = null
    additional_bandwidth = null
    acl_template_id      = null
  }
  validation {
    condition     = can(var.secondary.enabled)
    error_message = "Key 'enabled' has to be defined for secondary device."
  }
  validation {
    condition     = !try(var.secondary.enabled, false) || try(length(var.secondary.name) >= 3 && length(var.secondary.name) <= 50, false)
    error_message = "Key 'name' has to be defined and should consist of 3 to 50 characters."
  }
  validation {
    condition     = !try(var.secondary.enabled, false) || try(length(var.secondary.hostname) >= 2 && length(var.secondary.hostname) <= 30, false)
    error_message = "Key 'hostname' has to be between 2 and 30 characters long."
  }
  validation {
    condition     = !try(var.secondary.enabled, false) || can(regex("^[A-Z]{2}$", var.secondary.metro_code))
    error_message = "Key 'metro_code' has to be defined for secondary device. Valid metro code consists of two capital letters, i.e. SV, DC."
  }
  validation {
    condition     = !try(var.secondary.enabled, false) || try(length(var.secondary.account_number) > 0, false)
    error_message = "Key 'account_number' is required for secondary device."
  }
  validation {
    condition     = !try(var.secondary.enabled, false) || try(var.secondary.additional_bandwidth >= 25 && var.secondary.additional_bandwidth <= 5001, true)
    error_message = "Key 'additional_bandwidth' has to be between 25 and 5001 Mbps."
  }
  validation {
    condition     = !try(var.secondary.enabled, false) || try(length(var.secondary.acl_template_id) > 0, false)
    error_message = "Key 'acl_template_id' is required for secondary device."
  }
}

variable "cluster" {
  description = "Cluster device attributes"
  type = object({
    enabled = bool
    name    = string
    node0 = object({
      vendor_configuration = object({
        hostname = string
      })
      license_file_id = optional(string)
      license_token   = optional(string)
    })
    node1 = object({
      vendor_configuration = object({
        hostname = string
      })
      license_file_id = optional(string)
      license_token   = optional(string)
    })
  })
  default = {
    enabled = false
    name    = null
    node0 = {
      vendor_configuration = {
        hostname = null
      }
      license_file_id = null
      license_token   = null
    }
    node1 = {
      vendor_configuration = {
        hostname = null
      }
      license_file_id = null
      license_token   = null
    }
  }
  validation {
    condition     = can(var.cluster.enabled)
    error_message = "Key 'enabled' has to be defined for cluster device."
  }
  validation {
    condition     = !try(var.cluster.enabled, false) || try(length(var.cluster.name) >= 3 && length(var.cluster.name) <= 50, false)
    error_message = "Key 'name' has to be defined for cluster device and should consist of 3 to 50 characters."
  }
  validation {
    condition     = !try(var.cluster.enabled, false) || try(length(var.cluster.node0.vendor_configuration.hostname) >= 2 && length(var.cluster.node0.vendor_configuration.hostname) <= 30, false)
    error_message = "Key 'node0.vendor_configuration.hostname' has to be defined for cluster device. Valid hostname has to be from 2 to 30 characters long."
  }
  validation {
    condition     = !try(var.cluster.enabled, false) || try(length(var.cluster.node1.vendor_configuration.hostname) >= 2 && length(var.cluster.node1.vendor_configuration.hostname) <= 30, false)
    error_message = "Key 'node1.vendor_configuration.hostname' has to be defined for cluster device. Valid hostname has to be from 2 to 30 characters long."
  }
}
