provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "pa_vm_cluster" {
  source           = "../../../modules/Palo-Alto-Network-Firewall"
  #  version          = "1.0.0"
  name             = "tf-pa-vm-cluster"
  metro_code       = var.metro_code_primary
  platform         = "medium"
  account_number   = "123456"
  connectivity     = "PRIVATE"
  software_package = "VM300"
  project_id       = "e6be59d9-62c0-4140-aad6-150f0700203c"
  term_length      = 1
  notifications    = ["test@test.com"]
  hostname         = "pavm-pri"
  ssh_key          = {
    userName = "johndoe-primary"
    keyName  = equinix_network_ssh_key.johndoe_pri.name
  }
  cluster = {
    enabled                             = true
    name                                = "test-pa-vm-cluster"
    node0_vendor_configuration_hostname = "node0"
    node1_vendor_configuration_hostname = "node1"
  }
  license_token = "I1234567"
}

resource "equinix_network_ssh_key" "johndoe_pri" {
  name       = "johndoe-pri-0414-6"
  public_key = var.ssh_rsa_public_key
  project_id = "e6be59d9-62c0-4140-aad6-150f0700203c"
}