provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "pa_vm_ha" {
  source           = "../../modules/Palo-Alto-Network-Firewall"
  name             = "tf-pa-vm-ha"
  metro_code       = var.metro_code_primary
  platform         = "small"
  account_number   = "123456"
  software_package = "VM300"
  project_id       = "e6be59d9-62c0-4140-aad6-150f0700203c"
  term_length      = 1
  notifications    = ["test@test.com"]
  hostname         = "pavm-pri"
  ssh_key = {
    userName = "johndoe-primary"
    keyName  = equinix_network_ssh_key.johndoe_pri.name
  }
  secondary = {
    enabled        = true
    metro_code     = var.metro_code_secondary
    hostname       = "pavm-sec"
    account_number = "123456"
    license_token  = var.license_token
  }

}

resource "equinix_network_ssh_key" "johndoe_pri" {
  name       = "johndoe-pri-0426-10"
  public_key = var.ssh_rsa_public_key
  project_id = "e6be59d9-62c0-4140-aad6-150f0700203c"
}

resource "equinix_network_ssh_key" "johndoe_sec" {
  name       = "johndoe-pri-0426-10"
  public_key = var.ssh_rsa_public_key
}
