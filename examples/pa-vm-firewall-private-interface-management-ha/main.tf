provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "pa_vm_ha" {
  source               = "../../modules/Palo-Alto-Network-Firewall"
  name                 = "tf-pa-vm-ha"
  metro_code           = var.metro_code_primary
  platform             = "medium"
  account_number       = "123456"
  software_package     = "VM300"
  project_id           = "e6be59d9-62c0-4140-aad6-150f0700203c"
  term_length          = 1
  connectivity         = "INTERNET-ACCESS-WITH-PRVT-MGMT"
  notifications        = ["test@test.com"]
  hostname             = "pavm-pri"
  additional_bandwidth = 100
  acl_template_id      = equinix_network_acl_template.pa_vm_pri.id
  ssh_key = {
    userName = "johndoe-primary"
    keyName  = equinix_network_ssh_key.johndoe_pri.name
  }
  secondary = {
    enabled              = true
    metro_code           = var.metro_code_secondary
    hostname             = "pavm-sec"
    account_number       = "123456"
    additional_bandwidth = 50
    acl_template_id      = equinix_network_acl_template.pa_vm_sec.id
    license_token        = var.license_token
  }

}

resource "equinix_network_ssh_key" "johndoe_pri" {
  name       = "johndoe-pri-0425-2"
  public_key = var.ssh_rsa_public_key
  project_id = "e6be59d9-62c0-4140-aad6-150f0700203c"
}

resource "equinix_network_ssh_key" "johndoe_sec" {
  name       = "johndoe-sec-0425-2"
  public_key = var.ssh_rsa_public_key
}

resource "equinix_network_acl_template" "pa_vm_pri" {
  name        = "tf-pa-vm-pri"
  description = "Primary Palo Alto Networks VM ACL template"
  project_id  = "e6be59d9-62c0-4140-aad6-150f0700203c"
  inbound_rule {
    subnet   = "12.16.103.0/24"
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}

resource "equinix_network_acl_template" "pa_vm_sec" {
  name        = "tf-pa-vm-sec"
  description = "Secondary Palo Alto Networks VM ACL template"
  inbound_rule {
    subnet   = "172.16.25.0/24"
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}
