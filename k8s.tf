data "vkcs_compute_flavor" "k8s-master-flavor" {
  name = "Standard-2-4-40"
}

data "vkcs_compute_flavor" "k8s-node-group-flavor" {
  name = "Standard-2-4-40"
}

data "vkcs_kubernetes_clustertemplate" "k8s-template" {
  version = var.k8s_version
}

resource "vkcs_kubernetes_cluster" "k8s-cluster" {
  depends_on = [
    vkcs_networking_router_interface.k8s,
  ]

  name                = "k8s-cluster-tf"
  cluster_template_id = data.vkcs_kubernetes_clustertemplate.k8s-template.id
  master_flavor       = data.vkcs_compute_flavor.k8s-master-flavor.id
  master_count        = 1
  network_id          = vkcs_networking_network.k8s.id
  subnet_id           = vkcs_networking_subnet.k8s.id
  availability_zone   = "GZ1"

  floating_ip_enabled = true
}

resource "vkcs_kubernetes_node_group" "k8s-node-group" {
  name = "k8s-node-group"
  cluster_id = vkcs_kubernetes_cluster.k8s-cluster.id
  flavor_id = data.vkcs_compute_flavor.k8s-node-group-flavor.id

  autoscaling_enabled = true

  node_count = 1

  min_nodes = 1
  max_nodes = 3

  labels {
    key = "disktype"
    value = "ssd"
  }
}
