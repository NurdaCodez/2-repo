// PROJECT Variables
variable "my_gcp_project" {
  default = "anttech-373808"
}

variable "region" {
  default = "us-west1"
}

//variable "provider"
variable "backend_prefix" {
  description = "The prefix for the Terraform state file in the GCS bucket."
  type        = string
  default     = "terraform/state"
}




// required
variable "database_version" {
  description = "The database version to use"
  type        = string
  default = "MYSQL_8_0"
}

variable "replica_database_version" {
  description = "The read replica database version to use. This var should only be used during a database update. The update sequence 1. read-replica 2. master, setting this to an updated version will cause the replica to update, then you may update the master with the var database_version and remove this field after update is complete"
  type        = string
  default     = "MYSQL_8_0"
}

variable "tier" {
  description = "The tier for the master instance."
  type        = string
  default     = "db-custom-2-13312"
}

variable "backup_configuration" {
  description = "The backup_configuration settings subblock for the database setings"
  type = object({
    binary_log_enabled             = bool
    enabled                        = bool
  })
default = {
    binary_log_enabled             = true
    enabled                        = true
  }
}

variable "ipv4_enabled" {
  description = "Whether IPv4 is enabled for the IP configuration."
  type        = bool
  default     = false
}

 variable "replica_configuration" {
    type = object({
    failover_target = bool 
    })
    default = {
     failover_target = false }
  }

variable "disk_size" {
  description = "The disk size for the master instance"
  type        = number
  default     = 100
}


//VPC variables
variable "network_name" {
  description = "The name of the private network."
  type        = string
  default     = "private-network"
}

variable "ip_address_name" {
  description = "The name of the private IP address."
  type        = string
  default     = "private-ip-address"
}

variable "purpose" {
  description = "The purpose of the private IP address."
  type        = string
  default     = "VPC_PEERING"
}


variable "address_type" {
  description = "The type of the private IP address."
  type        = string
  default     = "INTERNAL"
} 

variable "prefix_length" {
  description = "The length of the subnet prefix for the private network."
  type        = number
  default     = 16
}

variable "service" {
  description = "The name of the service for the VPC peering connection."
  type        = string
  default     = "servicenetworking.googleapis.com"
}
