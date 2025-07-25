provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "aruba_edgeconnect_single" {
  source               = "../../modules/aruba-sdwan"
  name                 = "tf-aruba-edgeconnect"
  account_number       = "123456"
  project_id           = "e6be59d9-62c0-4140-aad6-150f0700203c"
  metro_code           = var.metro_code_primary
  type_code            = "EDGECONNECT-SDWAN"
  self_managed         = true
  byol                 = true
  package_code         = "EC-V"
  notifications        = ["test@test.com"]
  version              = "9.2.5"
  core_count           = 2
  term_length          = 1
  additional_bandwidth = 50
  interface_count      = 10
  acl_template_id      = equinix_network_acl_template.aruba_edgeconnect.id
  vendor_configuration = {
    accountKey : "xxxxx"
    accountName : "xxxx"
    applianceTag : "tests"
    hostname : "test-aruba-tf"
  }
}

resource "equinix_network_acl_template" "aruba_edgeconnect" {
  name        = "tf-aruba-edgeconnect-pri"
  description = "Primary aruba edgeconnect ACL template"
  project_id  = "e6be59d9-62c0-4140-aad6-150f0700203c"
}
