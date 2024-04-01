data "vkcs_compute_flavor" "db_small" {
  name = "Standard-2-4-40"
}

resource "vkcs_db_instance" "pg-dev" {
  name = "db-instance"

  datastore {
    type    = "postgresql"
    version = "15"
  }

  floating_ip_enabled = true

  flavor_id         = data.vkcs_compute_flavor.db_small.id
  availability_zone = "MS1"

  size        = 8
  volume_type = "MS1"

  disk_autoexpand {
    autoexpand    = true
    max_disk_size = 64
  }

  network {
    uuid = vkcs_networking_network.db.id
  }

  capabilities {
    name = "node_exporter"
  }

  capabilities {
    name = "postgres_extensions"
  }
}
