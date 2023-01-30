#Cloud SQL "MySQL"
resource "google_sql_database_instance" "master_instance" {

  name             = "${local.master_instance_name}"
  region           = "${var.region}"
  database_version = "${var.database_version}"
  

  depends_on = [google_service_networking_connection.private_vpc_connection]
#Making private
  settings {
    tier = "${var.tier}"
         backup_configuration {
      enabled            = "${var.backup_configuration.enabled}"
    binary_log_enabled = "${var.backup_configuration.binary_log_enabled}"
    }
    ip_configuration {
      ipv4_enabled    = "${var.ipv4_enabled}"
      private_network = google_compute_network.private_network.id
    }
  }
}

#Read Replica for Master Instance MYSQL Engine

resource "google_sql_database_instance" "read_replica" {
  name                 = "${local.read_replica_name}"
  master_instance_name = google_sql_database_instance.master_instance.name
  region               = "${var.region}"
  database_version     = "${var.replica_database_version}"

  replica_configuration {
    failover_target = false
  }

  settings {
    tier              = "${var.tier}"
    disk_size         = "${var.disk_size}"
  }
}
