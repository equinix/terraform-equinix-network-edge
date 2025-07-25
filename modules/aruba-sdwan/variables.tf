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

variable "version_number" {
  description = "version number"
  type        = string
  default     = ""
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
    activationKey  = string
    controllerFqdn = string
    rootPassword   = string
  })

  validation {
    condition     = try(length(var.vendor_configuration.activationKey) > 0, false)
    error_message = "Activation Key has to be a non empty string."
  }

  validation {
    condition     = can(regex("^[a-zA-Z_.+-]+.[a-zA-Z-]+.[a-zA-Z-.]$", var.vendor_configuration.controllerFqdn))
    error_message = "Controller FQDN has to be valid string. Example: www.equinix.com"
  }

  validation {
    condition     = length(var.vendor_configuration.rootPassword) == 0 || (length(var.vendor_configuration.rootPassword) >= 8 && length(var.vendor_configuration.rootPassword) <= 128)
    error_message = "Device root password has to be from 8 to 128 characters long."
  }
}

variable "ssh_key" {
  description = "SSH public key for a device"
  type = object({
    userName = string
    keyName  = string
  })
}

variable "software_package" {
  description = "Device software package"
  type        = string
  validation {
    condition     = can(regex("^(VMware-2|VMware-4|VMware-8)$", var.software_package))
    error_message = "One of following software packages are supported: VMware-2, VMware-4, VMware-8."
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
  default     = 8
  validation {
    condition     = can(regex("^(8)$", var.interface_count))
    error_message = "One of following values are supported: 8."
  }
}
