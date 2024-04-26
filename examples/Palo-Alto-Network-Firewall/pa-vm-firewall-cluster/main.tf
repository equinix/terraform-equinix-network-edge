provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "pa_vm_cluster" {
  source                 = "../../../modules/Palo-Alto-Network-Firewall"
#  version                = "1.0.0"
  name                   = "tf-pa-vm-cluster"
  metro_code             = var.metro_code_primary
  platform               = "medium"
  account_number         = "123456"
  software_package       = "VM300"
  project_id             = "e6be59d9-62c0-4140-aad6-150f0700203c"
  term_length            = 1
  notifications          = ["test@test.com"]
  hostname               = "pavm-pri"
  additional_bandwidth   = 100
  connectivity           = "INTERNET-ACCESS"
  acl_template_id        = equinix_network_acl_template.pa_vm_cluster_wan_acl.id
  mgmt_acl_template_uuid = equinix_network_acl_template.pa_vm_cluster_mgmt_acl.id
  ssh_key                = {
    userName = "johndoe-primary"
    keyName  = equinix_network_ssh_key.johndoe_pri.name
  }
  cluster = {
    enabled                             = true
    name                                = "test-pa-vm-cluster"
    node0_vendor_configuration_hostname = "node0"
    node1_vendor_configuration_hostname = "node1"
    license_token                       = var.license_token
  }
}

resource "equinix_network_ssh_key" "johndoe_pri" {
  name       = "johndoe-pri-0426-12"
  public_key = var.ssh_rsa_public_key
  project_id = "e6be59d9-62c0-4140-aad6-150f0700203c"
}

resource "equinix_network_acl_template" "pa_vm_cluster_mgmt_acl" {
  name        = "tf-pa-vm-cluster-mgmt"
  description = "Primary Palo Alto Networks VM ACL template"
  project_id  = "e6be59d9-62c0-4140-aad6-150f0700203c"
  inbound_rule {
    subnet   = "12.16.103.0/24"
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}

resource "equinix_network_acl_template" "pa_vm_cluster_wan_acl" {
  name        = "tf-pa-vm-cluster-wan"
  description = "Secondary Palo Alto Networks VM ACL template"
  inbound_rule {
    subnet   = "172.16.25.0/24"
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}
