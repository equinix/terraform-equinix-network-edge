provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "c8000v_single" {
  source               = "../../modules/c8000v-sdwan"
  name                 = "terraform-test-c8000v-sdwan-primary"
  metro_code           = data.equinix_network_account.ny.metro_code
  account_number       = data.equinix_network_account.ny.number
  platform             = "small"
  software_package     = "network-essentials"
  term_length          = 1
  notifications        = ["test@test.com"]
  additional_bandwidth = 50
  cloud_init_file_id   = equinix_network_file.c8k_bootstrap_file.uuid
  acl_template_id      = equinix_network_acl_template.c8000v_sdwan_single_wan_acl_template.id
  vendor_configuration = {
    hostname        = "c8kv-sdwan"
    siteId          = "1234"
    systemIpAddress = "10.0.0.1"
  }
}


resource "equinix_network_acl_template" "c8000v_sdwan_single_wan_acl_template" {
  name        = "tf-c8000v-sdwan-pri-wan-acl"
  description = "Primary C8000V SDWAN wan ACL template"
  inbound_rule {
    subnet   = "0.0.0.0/0"
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}


resource "equinix_network_file" "c8k_bootstrap_file" {
  file_name        = "C8K-6BDD255F-F75E-144B-2095-2918F995A37C.cfg"
  content          = file("${path.module}/../../files/c8000v-sdwan/C8K-6BDD255F-F75E-144B-2095-2918F995A37C.cfg")
  metro_code       = var.metro_code_primary
  device_type_code = "C8000V-SDWAN"
  process_type     = "CLOUD_INIT"
  self_managed     = true
  byol             = true
}

data "equinix_network_account" "ny" {
  name       = "test_account"
  metro_code = "NY"
  project_id = "f1a596ed-d24a-497c-92a8-44e0923cee62"
}
