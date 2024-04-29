provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "nginx_single" {
  source                 = "../../../modules/nginx"
  name                   = "terraform-test-NGINX-primary"
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
}

resource "equinix_network_ssh_key" "johndoe" {
  name       = "johndoe-pri1"
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
