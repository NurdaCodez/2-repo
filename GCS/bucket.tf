# [START storage settings for "import" command]
# storage bucket in the US multi-region
# with standard storage
# public access prevented
# retention policy is 1 day 

resource "google_storage_bucket" "bucketer" {
  name          = "nurbucket23"
  location      = "US"
  storage_class = "STANDARD"
  public_access_prevention = "enforced"
  uniform_bucket_level_access = true
  retention_policy {
  retention_period = 86400
}

# [END, Existing storage's settings are done to "import" command
#First lifecycle added after importing the existing gcs bucket to tf 
  lifecycle_rule {
    condition {
      age = 30
    }
    action {
      type = "SetStorageClass"
      storage_class = "NEARLINE"
    }
  }
#Second lifecycle 
  lifecycle_rule {
    action {
      type = "SetStorageClass"
      storage_class = "COLDLINE"
    }
    condition {
      age = 90
      matches_storage_class = ["STANDARD"]
    }
  }
#Third  lifecycle will delete bucket after 365 days from the day of creation 
lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 365
    }
  }
}