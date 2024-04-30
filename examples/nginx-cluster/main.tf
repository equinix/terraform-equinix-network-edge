provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "nginx_cluster" {
  source                 = "../../modules/nginx"
  name                   = "terraform-test-NGINX-cluster1"
  metro_code             = var.metro_code_primary
  account_number         = "123456"
  platform               = "small"
  software_package       = "STD"
  term_length            = 1
  notifications          = ["test@test.com"]
  additional_bandwidth   = 50
  mgmt_acl_template_uuid = equinix_network_acl_template.nginx_cluster.id
  ssh_key = {
    userName = "johndoe"
    keyName  = equinix_network_ssh_key.jd_cluster.name
  }
  cluster = {
    enabled                             = true
    name                                = "test-nginx-cluster"
    node0_vendor_configuration_hostname = "node0"
    node1_vendor_configuration_hostname = "node1"
  }
}

resource "equinix_network_ssh_key" "jd_cluster" {
  name       = "jd-cluster"
  public_key = var.ssh_rsa_public_key
}

resource "equinix_network_acl_template" "nginx_cluster" {
  name        = "tf-nginx-cluster"
  description = "Cluster NGINX ACL template"
  inbound_rule {
    subnet   = "172.16.25.0/24"
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}
