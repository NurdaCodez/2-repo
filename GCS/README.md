Step by Step Guide for the code
Prerequisites
Have a Google Cloud account with sufficient permissions to create a storage bucket and add lifecycle policies to it.
Step 1: Create a Storage Bucket
Copy the below code and paste it in the .tf file in your Terraform environment.

Copy code
# storage bucket in the US multi-region
# with standard storage
# public access prevented
# retention policy is 1 day 
#We provided this code in order to import state existing Bucket to Terraform. Make sure that configurations matches with existing Bucket's configuration

resource "google_storage_bucket" "bucketer" {
  name          = "nurbucket23"
  location      = "US"
  storage_class = "STANDARD"
  public_access_prevention = "enforced"
  uniform_bucket_level_access = true
  retention_policy {
  retention_period = 86400
}

#On terminal run the command "terraform import google_storage_bucket.sample sample-project/my-bucket"
# Rename "sample" to your bucket name and project respectively 

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

Step 2: Apply the Terraform Configuration
Run the following command to initialize the Terraform environment.

Copy code

terraform init

Run the following command to check if the Terraform code is valid.

Copy code

terraform validate

Run the following command to apply the Terraform code and create the resources.

Copy code

terraform apply

Step 3: Verify the Storage Bucket

Log in to the Google Cloud Console.

Go to the Storage section.

Check if the storage bucket with the name "your_bucket_s_name" is created.

Verify if the lifecycle policies are correctly applied to the bucket.
Conclusion
With these steps, you have imported existing Google Cloud Storage bucket to Terraform's state file and modified with the specified lifecycle policies .