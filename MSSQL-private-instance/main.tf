#Cloud SQL "MySQL"
resource "google_sql_database_instance" "master_instance" {

  name             = "private-mssql-master-instance-task"
  region           = "us-west1"
  database_version = "MYSQL_8_0"
  

  depends_on = [google_service_networking_connection.private_vpc_connection]
#Making private
  settings {
    tier = "db-custom-2-13312"
         backup_configuration {
      enabled            = "true"
      binary_log_enabled = "true"
    }
    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.private_network.id
    }
  }
}

#Read Replica for Master Instance MYSQL Engine

resource "google_sql_database_instance" "read_replica" {
  name                 = "replica-for-master-mysql"
  master_instance_name = google_sql_database_instance.master_instance.name
  region               = "us-west1"
  database_version     = "MYSQL_8_0"

  replica_configuration {
    failover_target = false
  }

  settings {
    tier              = "db-custom-2-13312"
    disk_size         = "100"
  }
}
