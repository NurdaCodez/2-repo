#vnet block
resource "google_compute_network" "private_network" {
  name = "${var.network_name}"
}
#IP addresses
resource "google_compute_global_address" "private_ip_address" {

  name          = "${var.ip_address_name}"
  purpose       = "${var.purpose}"
  address_type  = "${var.address_type}"
  prefix_length = "${var.prefix_length}"
  network       = google_compute_network.private_network.id
}
#PEERING VPC network peering
resource "google_service_networking_connection" "private_vpc_connection" {
  
  network                 = google_compute_network.private_network.id
  service                 = "${var.service}"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}
