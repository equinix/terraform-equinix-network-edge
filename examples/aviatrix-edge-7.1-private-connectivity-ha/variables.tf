variable "equinix_client_id" {
  type        = string
  description = "API Consumer Key available under 'My Apps' in developer portal. This argument can also be specified with the EQUINIX_API_CLIENTID shell environment variable."
}

variable "equinix_client_secret" {
  type        = string
  description = "API Consumer secret available under 'My Apps' in developer portal. This argument can also be specified with the EQUINIX_API_CLIENTSECRET shell environment variable."
}
variable "metro_code_primary" {
  description = "Primary device location metro code"
  type        = string
}
variable "metro_code_secondary" {
  description = "Secondary device location metro code"
  type        = string
}
