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
  validation {
    condition     = length(var.account_number) > 0 && var.account_number != null
    error_message = "Account number must not be blank or null."
  }
}

variable "project_id" {
  description = "project_id"
  type        = string
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
    condition     = can(regex("^(STD)$", var.software_package))
    error_message = "Only STD package will be supported."
  }
}

variable "name" {
  description = "Device name"
  type        = string
  validation {
    condition     = length(var.name) >= 3 && length(var.name) <= 50
    error_message = "Device name should consist of 3 to 50 characters."
  }
}

variable "connectivity" {
  description = "Parameter to identify internet access for device. Supported Values: INTERNET-ACCESS(default) or PRIVATE"
  type        = string
  default     = "INTERNET-ACCESS"
}

variable "cloud_init_file_id" {
  description = "Aviatrix Cloud-Init bootstrap configuration file"
  type        = string
  validation {
    condition     = length(var.cloud_init_file_id) > 0
    error_message = "Cloud-Init bootstrap file is mandatory."
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
  description = "Identifier of an ACL template that will be applied on a device."
  type        = string
  default     = null
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

variable "interface_count" {
  description = "Number of network interfaces on a device. If not specified, default number for a given device type will be used."
  type        = number
  default     = 10
}

variable "vnf_version" {
  description = "Device software package version number"
  type        = string
  default     = ""
}

variable "secondary" {
  description = "Secondary device attributes"
  type = object({
    enabled              = bool
    metro_code           = string
    cloud_init_file_id   = string
    acl_template_id      = optional(string)
    account_number       = string
    additional_bandwidth = optional(number)
  })
  default = {
    enabled              = false
    metro_code           = null
    cloud_init_file_id   = null
    acl_template_id      = null
    account_number       = null
    additional_bandwidth = null
  }

  validation {
    condition     = var.secondary.enabled ? can(regex("^[A-Z]{2}$", var.secondary.metro_code)) : true
    error_message = "Key 'metro_code' has to be defined for secondary device. Valid metro code consists of two capital letters, i.e. SV, DC."
  }
  validation {
    condition     = try(var.secondary.additional_bandwidth >= 25 && var.secondary.additional_bandwidth <= 5001, true)
    error_message = "Key 'additional_bandwidth' has to be between 25 and 2001 Mbps."
  }

  validation {
    condition     = try(!var.secondary.enabled || (length(var.secondary.account_number) > 0 && var.secondary.account_number != null), true)
    error_message = "Secondary account number must not be blank or null when secondary is enabled."
  }

  validation {
    condition     = try(!var.secondary.enabled || length(var.secondary.cloud_init_file_id) > 0, true)
    error_message = "Secondary Cloud-Init bootstrap file is mandatory."
  }
}
