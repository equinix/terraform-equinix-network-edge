provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "vmware_sdwan_ha" {
  source               = "../../modules/velocloud-sdwan"
  name                 = "tf-vmware-sdwan"
  metro_code           = var.metro_code_primary
  platform             = "small"
  account_number       = "123456"
  project_id           = "e6be59d9-62c0-4140-aad6-150f0700203c"
  software_package     = "VMware-2"
  version_number       = "4.3.0"
  term_length          = 1
  notifications        = ["test@test.com"]
  additional_bandwidth = 100
  acl_template_id      = equinix_network_acl_template.velocloud_sdwan_pri.id
  vendor_configuration = {
    activationKey  = "xxxx-xxxx-xxxx-xxxx"
    controllerFqdn = "test.test.test"
    rootPassword   = "xxxxxxxxxxx"
  }
  secondary = {
    enabled              = true
    metro_code           = var.metro_code_secondary
    account_number       = "123456"
    name                 = "custom-secondary-name"
    additional_bandwidth = 100
    acl_template_id      = equinix_network_acl_template.velocloud_sdwan_sec.id
    vendor_configuration = {
      activationKey  = "xxxx-xxxx-xxxx-xxxx"
      controllerFqdn = "test.test.test"
      rootPassword   = "xxxxxxxxxxxx"
    }
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

resource "equinix_network_acl_template" "velocloud_sdwan_sec" {
  name        = "tf-velocloud-sdwan-sec"
  description = "Secondary VMWare SD-WAN ACL template"
  inbound_rule {
    subnet   = "193.39.0.0/16"
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}
