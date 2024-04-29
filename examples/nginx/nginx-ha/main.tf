provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "nginx_ha" {
  source                 = "../../../modules/nginx"
  name                   = "terraform-test-NGINX-ha"
  hostname               = "nginx-pri"
  metro_code             = var.metro_code_primary
  account_number         = "123456"
  platform               = "small"
  software_package       = "STD"
  term_length            = 1
  notifications          = ["test@test.com"]
  additional_bandwidth   = 50
  mgmt_acl_template_uuid = equinix_network_acl_template.nginx_pri.id
  ssh_key = {
    userName = "johndoe-primary"
    keyName  = equinix_network_ssh_key.johndoe.name
  }
  secondary = {
    enabled                = true
    metro_code             = var.metro_code_secondary
    hostname               = "nginx-sec"
    account_number         = "135887"
    additional_bandwidth   = 50
    mgmt_acl_template_uuid = equinix_network_acl_template.nginx_sec.id
  }
}

resource "equinix_network_ssh_key" "johndoe" {
  name       = "johndoe-secondary"
  public_key = var.ssh_rsa_public_key
}

resource "equinix_network_acl_template" "nginx_pri" {
  name        = "tf-nginx-pri"
  description = "Primary NGINX management ACL template"
  inbound_rule {
    subnet   = "172.16.25.0/24"
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}

resource "equinix_network_acl_template" "nginx_sec" {
  name        = "tf-vsrx-sec"
  description = "Secondary NGINX management ACL template"
  inbound_rule {
    subnet   = "193.39.0.0/16"
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}
