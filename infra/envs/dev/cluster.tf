module "k8s_network" {
  source = "../../modules/openstack/network"

  network_name        = "k8s_net"
  default_subnet_cidr = "10.0.0.0/24"
  external_network    = data.openstack_networking_network_v2.public
}

module "k8s_cluster" {
  source = "../../modules/openstack/k8s-cluster"

  image            = openstack_images_image_v2.coreos_37
  keypair          = data.openstack_compute_keypair_v2.admin

  // Node Settings
  ha_control_plane  = false
  base_worker_count = 2

  // Networking
  internal_network = module.k8s_network.network
  internal_subnet  = module.k8s_network.default_subnet
  external_network = data.openstack_networking_network_v2.public

  bootstrap = {
    enabled    = true
    repository = "https://gitlab.com/ralgar/homelab.git"
    branch     = "main"
    path       = "./cluster/system/flux-cd"
  }
}
