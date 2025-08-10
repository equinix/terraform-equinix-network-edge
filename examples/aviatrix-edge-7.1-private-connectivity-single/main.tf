provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "aviatrix_edge_7_1" {
  source               = "../../modules/aviatrix-edge-7.1"
  name                 = "terraform-test-aviatrix-edge-7.1-primary"
  metro_code           = data.equinix_network_account.ny.metro_code
  account_number       = data.equinix_network_account.ny.number
  platform             = "small"
  software_package     = "STD"
  vnf_version          = 7.1
  project_id           = "c9a8e930-5f54-4d8b-8e4d-0fc2c3f034af"
  term_length          = 1
  connectivity         = "PRIVATE"
  notifications        = ["test@test.com"]
  additional_bandwidth = 50
  cloud_init_file_id   = equinix_network_file.aviatrix_edge_7_1_bootstrap_file.uuid
}

resource "equinix_network_file" "aviatrix_edge_7_1_bootstrap_file" {
  file_name        = "aviatrix.txt"
  content          = file("${path.module}/../../files/aviatrix-edge-7.1/aviatrix.txt")
  metro_code       = var.metro_code_primary
  device_type_code = "AVIATRIX_EDGE"
  process_type     = "CLOUD_INIT"
  self_managed     = true
  byol             = true
}

data "equinix_network_account" "ny" {
  name       = "test"
  metro_code = "NY"
  project_id = "c9a8e930-5f54-4d8b-8e4d-0fc2c3f034af"
}
