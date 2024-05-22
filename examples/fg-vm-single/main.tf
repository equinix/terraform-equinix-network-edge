provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "fg_vm_single" {
  source                 = "../../modules/fortigate-firewall"
  license_file           = "/tmp/FGVM-pri.lic"
  name                   = "terraform-test-fortigate-primary"
  project_id             = "0ee69e59-e641-4df7-8e95-bbb4d880c449"
  hostname               = "fortigate-pri"
  software_package       = "VM02"
  version_number         = "7.0.14"
  platform               = "small"
  metro_code             = data.equinix_network_account.test_account.metro_code
  account_number         = data.equinix_network_account.test_account.number
  term_length            = 1
  notifications          = ["test@test.com"]
  acl_template_id        = equinix_network_acl_template.fortigate_pri.id
  additional_bandwidth   = 50
  ssh_key = {
    userName = "johndoe-primary"
    keyName  = equinix_network_ssh_key.johndoe.name
  }
}

data "equinix_network_account" "test_account" {
  name       = "test_account"
  metro_code = var.metro_code_primary
  project_id = "f1a596ed-d24a-497c-92a8-44e0923cee62"
}

resource "equinix_network_ssh_key" "johndoe" {
  name       = "johndoe-pri"
  public_key = var.ssh_rsa_public_key
}

resource "equinix_network_acl_template" "fortigate_pri" {
  name        = "tf-fortigate-pri"
  description = "Primary fortigate ACL template"
  inbound_rule {
    subnet   = "172.16.25.0/24"
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}
