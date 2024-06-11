provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "fg_vm_ha" {
  source               = "../../modules/fortigate-firewall"
  license_token        = "primary license token"
  name                 = "terraform-test-fortigate-pri"
  project_id           = "0ee69e59-e641-4df7-8e95-bbb4d880c449"
  hostname             = "fortigate-pri"
  software_package     = "VM02"
  version_number       = "7.0.14"
  platform             = "small"
  metro_code           = var.metro_code_primary
  account_number       = "123456"
  term_length          = 1
  notifications        = ["test@test.com"]
  acl_template_id      = equinix_network_acl_template.fortigate_pri.id
  additional_bandwidth = 50
  ssh_key = {
    username = "johndoe-primary"
    key_name = equinix_network_ssh_key.johndoe.name
  }
  secondary = {
    enabled              = true
    license_token        = "secondary license token"
    name                 = "terraform-test-fortigate-sec"
    metro_code           = var.metro_code_secondary
    hostname             = "fortigate-sec"
    account_number       = "135887"
    notifications        = ["test@test.com"]
    acl_template_id      = equinix_network_acl_template.fortigate_sec.id
    additional_bandwidth = 50
  }
}

resource "equinix_network_ssh_key" "johndoe" {
  name       = "johndoe-secondary"
  public_key = var.ssh_rsa_public_key
}

resource "equinix_network_acl_template" "fortigate_pri" {
  name        = "tf-fortigate-pri"
  description = "Primary fortigate ACL template"
  inbound_rule {
    subnet   = "172.16.25.0/24"
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}

resource "equinix_network_acl_template" "fortigate_sec" {
  name        = "tf-fortigate-sec"
  description = "Secondary fortigate ACL template"
  inbound_rule {
    subnet   = "193.39.0.0/16"
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}
