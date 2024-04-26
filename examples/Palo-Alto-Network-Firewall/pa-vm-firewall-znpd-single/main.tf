provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "pa_vm" {
  source           = "../../../modules/Palo-Alto-Network-Firewall"
  #  version          = "1.0.0"
  name             = "tf-pa-vm-single"
  metro_code       = var.metro_code_primary
  platform         = "small"
  account_number   = "123456"
  software_package = "VM300"
  connectivity     = "PRIVATE"
  project_id       = "e6be59d9-62c0-4140-aad6-150f0700203c"
  term_length      = 1
  notifications    = ["test@test.com"]
  hostname         = "pavm-pri"
  ssh_key          = {
    userName = "johndoe-primary"
    keyName  = equinix_network_ssh_key.johndoe.name
  }
  license_token = "I3372903"
}

resource "equinix_network_ssh_key" "johndoe" {
  name       = "johndoe-pri-0414-single-7"
  public_key = var.ssh_rsa_public_key
  project_id = "e6be59d9-62c0-4140-aad6-150f0700203c"
}
