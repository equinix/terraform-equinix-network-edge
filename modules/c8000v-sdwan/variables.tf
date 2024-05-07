variable "metro_code" {
  description = "Device location metro code"
  type        = string
  validation {
    condition     = can(regex("^[A-Z]{2}$", var.metro_code))
    error_message = "Valid metro code consits of two capital leters, i.e. SV, DC."
  }
}

variable "account_number" {
  description = "Billing account number for a device"
  type        = string
  default     = 0
}

variable "platform" {
  description = "Device platform flavor that determines number of CPU cores and memory"
  type        = string
  validation {
    condition     = can(regex("^(small|medium|large)$", var.platform))
    error_message = "One of following platform flavors are supported: small, medium, large."
  }
}

variable "software_package" {
  description = "Device software package"
  type        = string
  validation {
    condition     = can(regex("^(network-advantage|network-essentials|network-premier)$", var.software_package))
    error_message = "One of following software packages are supported: network-advantage, network-essentials, network-premier."
  }
}

variable "name" {
  description = "Device name"
  type        = string
  validation {
    condition     = length(var.name) >= 2 && length(var.name) <= 50
    error_message = "Device name should consist of 2 to 50 characters."
  }
}

variable "cloud_init_file_id" {
  description = "C8000V Cloud-Init bootstrap configuration file"
  type        = string
  validation {
    condition     = length(var.cloud_init_file_id) > 0
    error_message = "Cloud-Init bootstrap is mandatory."
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
    condition     = length(var.acl_template_id) > 0
    error_message = "acl_template_id is mandatory"
  }
}

variable "additional_bandwidth" {
  description = "Additional internet bandwidth for a device"
  type        = number
  default     = 0
  validation {
    condition     = var.additional_bandwidth == 0 || (var.additional_bandwidth >= 25 && var.additional_bandwidth <= 2001)
    error_message = "Additional internet bandwidth should be between 25 and 2001 Mbps."
  }
}

variable "interface_count" {
  description = "Number of network interfaces on a device. If not specified, default number for a given device type will be used."
  type        = number
  default     = 10
}

variable "vendor_configuration" {
  description = "Device specific vendor configurations."
  type = object({
    hostname        = string
    siteId          = string
    systemIpAddress = string
  })

  validation {
    condition     = length(var.vendor_configuration.hostname) >= 2 && length(var.vendor_configuration.hostname) <= 10
    error_message = "Hostname must consist of 2 to 10 characters"
  }

  validation {
    condition     = length(var.vendor_configuration.siteId) > 0
    error_message = "Site ID is mandatory"
  }

  validation {
    condition     = length(var.vendor_configuration.systemIpAddress) > 0
    error_message = "System IP Address is mandatory"
  }
}


variable "secondary" {
  description = "Secondary device attributes"
  type = object({
    enabled            = bool
    metro_code         = string
    cloud_init_file_id = string
    acl_template_id    = string
    account_number     = string
    vendor_configuration = object({
      hostname        = string
      siteId          = string
      systemIpAddress = string
    })
    additional_bandwidth = optional(number)
  })
  default = {
    enabled            = false
    metro_code         = ""
    cloud_init_file_id = ""
    acl_template_id    = ""
    account_number     = ""
    vendor_configuration = {
      hostname        = ""
      siteId          = ""
      systemIpAddress = ""
    }
    additional_bandwidth = null
  }

  validation {
    condition     = var.secondary.enabled ? can(regex("^[A-Z]{2}$", var.secondary.metro_code)) : true
    error_message = "Key 'metro_code' has to be defined for secondary device. Valid metro code consists of two capital letters, i.e. SV, DC."
  }
  validation {
    condition     = try(var.secondary.additional_bandwidth >= 25 && var.secondary.additional_bandwidth <= 2001, true)
    error_message = "Key 'additional_bandwidth' has to be between 25 and 2001 Mbps."
  }
  validation {
    condition     = try(var.secondary.acl_template_id != null, true)
    error_message = "WAN ACL template is required."
  }
  validation {
    condition     = var.secondary.enabled ? can(length(var.secondary.vendor_configuration.hostname)) && length(var.secondary.vendor_configuration.hostname) >= 2 && length(var.secondary.vendor_configuration.hostname) <= 10 : true
    error_message = "Hostname must consist of 2 to 10 characters"
  }
  validation {
    condition     = var.secondary.enabled ? can(length(var.secondary.vendor_configuration.siteId)) && length(var.secondary.vendor_configuration.siteId) > 0 : true
    error_message = "Site ID is mandatory"
  }
  validation {
    condition     = var.secondary.enabled ? can(length(var.secondary.vendor_configuration.systemIpAddress)) && length(var.secondary.vendor_configuration.systemIpAddress) > 0 : true
    error_message = "System IP Address is mandatory"
  }
}
