provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "c8000v" {
  source           = "../../modules/c8000v"
  name             = "tf-c8000v-router-msla-single"
  metro_code       = var.metro_code_primary
  platform         = "medium"
  account_number   = "123456"
  byol             = true
  software_package = "network-essentials"
  connectivity     = "INTERNET-ACCESS"
  project_id       = "e6be59d9-62c0-4140-aad6-150f07002234"
  term_length      = 1
  notifications    = ["test@test.com"]
  hostname         = "c8000v-pri"
  acl_template_id  = equinix_network_acl_template.c8000v_pri.id
  ssh_key = {
    userName = "johndoe-primary"
    keyName  = equinix_network_ssh_key.johndoe.name
  }
}

resource "equinix_network_ssh_key" "johndoe" {
  name       = "johndoe-pri-0501-byol-10"
  public_key = var.ssh_rsa_public_key
  project_id = "e6be59d9-62c0-4140-aad6-150f07002234"
}

resource "equinix_network_acl_template" "c8000v_pri" {
  name        = "tf-c8000v-pri"
  description = "Primary C8000V Router ACL template"
  project_id  = "e6be59d9-62c0-4140-aad6-150f07002234"
  inbound_rule {
    subnet   = "12.16.103.0/24"
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}
