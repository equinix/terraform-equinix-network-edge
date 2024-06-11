provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "fg_vm_cluster" {
  source               = "../../modules/fortigate-firewall"
  name                 = "terraform-test-fortigate-cluster"
  project_id           = "0ee69e59-e641-4df7-8e95-bbb4d880c449"
  software_package     = "VM04"
  version_number       = "7.0.14"
  platform             = "small"
  metro_code           = var.metro_code_cluster
  account_number       = "123456"
  term_length          = 1
  notifications        = ["test@test.com"]
  acl_template_id      = equinix_network_acl_template.fortigate_cluster.id
  additional_bandwidth = 50
  ssh_key = {
    username = "johndoe"
    key_name = equinix_network_ssh_key.johndoe_cluster.name
  }
  cluster = {
    enabled = true
    name    = "test-fortigate-cluster"
    node0 = {
      vendor_configuration = {
        hostname = "fg-vm-node0"
      }
      license_file_id = equinix_network_file.fg_vm_license_file_node0.uuid
    }
    node1 = {
      vendor_configuration = {
        hostname = "fg-vm-node1"
      }
      license_file_id = equinix_network_file.fg_vm_license_file_node1.uuid
    }
  }
}

data "equinix_network_device_type" "fg_vm_type" {
  category = "FIREWALL"
  vendor   = "Fortinet"
}

resource "equinix_network_ssh_key" "johndoe_cluster" {
  name       = "johndoe-cluster"
  public_key = var.ssh_rsa_public_key
}

resource "equinix_network_acl_template" "fortigate_cluster" {
  name        = "tf-fortigate-cluster"
  description = "Cluster fortigate ACL template"
  inbound_rule {
    subnet   = "172.16.25.0/24"
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}

resource "equinix_network_file" "fg_vm_license_file_node0" {
  file_name        = "FG-VM-node0"
  content          = file("${path.module}/../../files/fg-vm/FG-VM-node0.lic")
  metro_code       = var.metro_code_cluster
  device_type_code = data.equinix_network_device_type.fg_vm_type.code
  process_type     = "LICENSE"
  self_managed     = true
  byol             = true
}

resource "equinix_network_file" "fg_vm_license_file_node1" {
  file_name        = "FG-VM-node1"
  content          = file("${path.module}/../../files/fg-vm/FG-VM-node1.lic")
  metro_code       = var.metro_code_cluster
  device_type_code = data.equinix_network_device_type.fg_vm_type.code
  process_type     = "LICENSE"
  self_managed     = true
  byol             = true
}
