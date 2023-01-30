provider "google" {
credentials = file("credentials.json")
  project     = "anttech-373808"
  region      = "us-west1"
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
