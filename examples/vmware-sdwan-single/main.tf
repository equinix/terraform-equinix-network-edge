provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "vmware_sdwan_single" {
  source               = "../../modules/velocloud-sdwan"
  name                 = "tf-vmware-sdwan"
  account_number       = "123456"
  project_id           = "e6be59d9-62c0-4140-aad6-150f0700203c"
  metro_code           = var.metro_code_primary
  platform             = "small"
  version_number       = "4.3.0"
  software_package     = "VMware-2"
  term_length          = 1
  notifications        = ["test@test.com"]
  additional_bandwidth = 100
  acl_template_id      = equinix_network_acl_template.velocloud_sdwan_pri.id
  vendor_configuration = {
    activationKey  = "xxxxx-xxxx-xxxx-xxxx"
    controllerFqdn = "test.test.test"
    rootPassword   = "xxxxxxxxxxxx"
  }
}

resource "equinix_network_acl_template" "velocloud_sdwan_pri" {
  name        = "tf-velocloud-sdwan-pri"
  description = "Primary velocloud sdwan ACL template"
  project_id  = "e6be59d9-62c0-4140-aad6-150f0700203c"
  inbound_rule {
    subnet   = "12.16.103.0/24"
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}
