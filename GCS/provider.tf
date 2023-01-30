provider "google" {
  credentials = file("credentials.json")
  project     = "anttech-373808"
  region      = "us-west1"
}
  