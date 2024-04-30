provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "pa_vm" {
  source               = "../../modules/palo-alto-network-firewall"
  name                 = "tf-pa-vm-single"
  metro_code           = var.metro_code_primary
  platform             = "medium"
  account_number       = "123456"
  software_package     = "VM300"
  connectivity         = "INTERNET-ACCESS-WITH-PRVT-MGMT"
  project_id           = "e6be59d9-62c0-4140-aad6-150f0700203c"
  term_length          = 1
  notifications        = ["test@test.com"]
  hostname             = "pavm-pri"
  additional_bandwidth = 100
  acl_template_id      = equinix_network_acl_template.pa_vm_pri.id
  ssh_key = {
    userName = "johndoe-primary"
    keyName  = equinix_network_ssh_key.johndoe.name
  }
}

resource "equinix_network_ssh_key" "johndoe" {
  name       = "johndoe-pri-0424-single-3"
  public_key = var.ssh_rsa_public_key
  project_id = "e6be59d9-62c0-4140-aad6-150f0700203c"
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
