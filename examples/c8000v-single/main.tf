provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "c8000v" {
  source               = "../../modules/c8000v"
  name                 = "tf-c8000v-router-single"
  metro_code           = var.metro_code_primary
  platform             = "small"
  account_number       = "664566"
  license_token        = "123456"
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
    keyName  = equinix_network_ssh_key.johndoe.name
  }
}

resource "equinix_network_ssh_key" "johndoe" {
  name       = "johndoe-pri-0430-1"
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
