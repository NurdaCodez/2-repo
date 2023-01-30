provider "google" {
credentials = file("credentials.json")
  project     = "${var.my_gcp_project}"
  region      = "${var.region}"
}

#version
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.50.0"
    }
  }
  backend "gcs" {
    bucket = "nurdabucket"
     prefix = "terraform/state"
    credentials = "credentials.json"
  }
}