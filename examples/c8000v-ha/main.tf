provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "c8000v_ha" {
  source               = "../../modules/c8000v"
  name                 = "tf-c8000v-router-ha"
  metro_code           = var.metro_code_primary
  platform             = "small"
  account_number       = "664566"
  license_token        = "N2FiZTJiZWQtYTE5ZS00NGU1LTg0ZmItOTc1YTI4OTQ0MWM0LTE2NjkzMjI2%0AOTg1NDV8ZlFaWGNUMWNDZDlMbUYvbllKeGtIZlA5bDgzUU9nOFlOMUdqUmM4%0AaVBYaz0%3D%0A"
  software_package     = "network-essentials"
  connectivity         = "INTERNET-ACCESS"
  project_id           = "e6be59d9-62c0-4140-aad6-150f0700203c"
  term_length          = 1
  notifications        = ["test@test.com"]
  hostname             = "c8000v-pri"
  additional_bandwidth = 100
  acl_template_id      = equinix_network_acl_template.c8000v_pri.id
  ssh_key = {
    userName = "johndoe-primary"
    keyName  = equinix_network_ssh_key.johndoe_pri.name
  }
  secondary = {
    enabled              = true
    metro_code           = var.metro_code_secondary
    hostname             = "c8000v-sec"
    account_number       = "664566"
    license_token        = "N2FiZTJiZWQtYTE5ZS00NGU1LTg0ZmItOTc1YTI4OTQ0MWM0LTE2NjkzMjI2%0AOTg1NDV8ZlFaWGNUMWNDZDlMbUYvbllKeGtIZlA5bDgzUU9nOFlOMUdqUmM4%0AaVBYaz0%3D%0A"
    additional_bandwidth = 50
    acl_template_id      = equinix_network_acl_template.c8000v_sec.id
  }
}

resource "equinix_network_ssh_key" "johndoe_pri" {
  name       = "johndoe-pri-0430-3"
  public_key = var.ssh_rsa_public_key
  project_id = "e6be59d9-62c0-4140-aad6-150f0700203c"
}

resource "equinix_network_ssh_key" "johndoe_sec" {
  name       = "johndoe-sec-0430-3"
  public_key = var.ssh_rsa_public_key
  project_id = "e6be59d9-62c0-4140-aad6-150f0700203c"
}

resource "equinix_network_acl_template" "c8000v_pri" {
  name        = "tf-c8000v-pri"
  description = "Primary C8000V Router ACL template"
  project_id  = "e6be59d9-62c0-4140-aad6-150f0700203c"
  inbound_rule {
    subnet   = "12.16.103.0/24"
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}

resource "equinix_network_acl_template" "c8000v_sec" {
  name        = "tf-c8000v-sec"
  description = "Secondary C8000V Router ACL template"
  project_id  = "e6be59d9-62c0-4140-aad6-150f0700203c"
  inbound_rule {
    subnet   = "12.16.103.0/24"
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}
