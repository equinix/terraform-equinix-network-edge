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

variable "byol" {
  description = "Bring your Own License"
  type        = string
  default     = true
}

variable "account_number" {
  description = "Billing account number for a device"
  type        = string
  validation {
    condition     = var.account_number != null && length(var.account_number) > 0
    error_message = "Account number must not be blank or null."
  }
}

variable "platform" {
  description = "Device platform flavor that determines number of CPU cores and memory"
  type        = string
  validation {
    condition     = can(regex("^(small|medium|large)$", var.platform))
    error_message = "One of following platform flavors are supported: small, medium, large."
  }
}

variable "vendor_configuration" {
  description = "Device specific vendor configurations."
  type = object({
    accountKey   = string
    accountName  = string
    applianceTag = string
    hostname     = string
  })

  validation {
    condition     = try(length(var.vendor_configuration.accountKey) > 0, false)
    error_message = "Account Key has to be a non empty string."
  }

  validation {
    condition     = try(length(var.vendor_configuration.accountName) > 0, false)
    error_message = "Account Name has to be a non empty string."
  }

  validation {
    condition     = try(length(var.vendor_configuration.applianceTag) > 0, false)
    error_message = "Appliance Tag has to be a non empty string."
  }

  validation {
    condition     = try(length(var.vendor_configuration.hostname) > 0, false)
    error_message = "hostname has to be a non empty string."
  }
}

variable "package_code" {
  description = "Device software package"
  type        = string
  validation {
    condition     = can(regex("^(EC-V)$", var.package_code))
    error_message = "One of following software packages are supported: EC-V."
  }
}

variable "version_number" {
  description = "version number"
  type        = string
  default     = ""
}

variable "name" {
  description = "Device name"
  type        = string
  validation {
    condition     = length(var.name) >= 3 && length(var.name) <= 50
    error_message = "Device name should consist of 3 to 50 characters."
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

variable "interface_count" {
  description = "Number of network interfaces on a device. If not specified, default number for a given device type will be used."
  type        = number
  default     = 10
  validation {
    condition     = can(regex("^(10)$", var.interface_count))
    error_message = "One of following values are supported: 10."
  }
}

variable "secondary" {
  description = "Secondary device attributes"
  type = object({
    enabled         = bool
    metro_code      = string
    name            = string
    acl_template_id = string
    account_number  = string
    vendor_configuration = object({
      accountKey   = string
      accountName  = string
      applianceTag = string
      hostname     = string
    })
    additional_bandwidth = optional(number)
  })
  default = {
    enabled         = false
    metro_code      = null
    name            = null
    acl_template_id = null
    account_number  = null
    vendor_configuration = {
      accountKey   = string
      accountName  = string
      applianceTag = string
      hostname     = string
    }
    additional_bandwidth = null
  }

  validation {
    condition     = var.secondary.enabled ? can(regex("^[A-Z]{2}$", var.secondary.metro_code)) : true
    error_message = "Key 'metro_code' has to be defined for secondary device. Valid metro code consists of two capital letters, i.e. SV, DC."
  }

  validation {
    condition     = !try(var.secondary.enabled, false) || try(length(var.secondary.name) >= 3 && length(var.secondary.name) <= 50, false)
    error_message = "Key 'name' has to be defined and should consist of 3 to 50 characters."
  }

  validation {
    condition     = try(var.secondary.additional_bandwidth >= 25 && var.secondary.additional_bandwidth <= 5001, true)
    error_message = "Key 'additional_bandwidth' has to be between 25 and 5001 Mbps."
  }

  validation {
    condition     = !try(var.secondary.enabled, false) || try(length(var.secondary.account_number) > 0, false)
    error_message = "Key 'account_number' is required for secondary device."
  }

  validation {
    condition     = !try(var.secondary.enabled, false) || try(length(var.secondary.acl_template_id) > 0, false)
    error_message = "Key 'acl_template_id' is required for secondary device."
  }

  validation {
    condition     = var.secondary.enabled ? can(length(var.secondary.vendor_configuration.accountKey)) && length(var.secondary.vendor_configuration.accountKey) > 0 : true
    error_message = "Secondary Account Key has to be a non empty string."
  }

  validation {
    condition     = var.secondary.enabled ? can(length(var.secondary.vendor_configuration.accountName)) && length(var.secondary.vendor_configuration.accountName) > 0 : true
    error_message = "Secondary Account Name has to be a non empty string."
  }

  validation {
    condition     = var.secondary.enabled ? can(length(var.secondary.vendor_configuration.applianceTag)) && length(var.secondary.vendor_configuration.applianceTag) > 0 : true
    error_message = "Secondary Appliance Tag has to be a non empty string."
  }

  validation {
    condition     = var.secondary.enabled ? can(length(var.secondary.vendor_configuration.hostname)) && length(var.secondary.vendor_configuration.hostname) > 0 : true
    error_message = "Secondary hostname has to be a non empty string."
  }
}
