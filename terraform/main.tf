terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "4.110.0"
    }
  }
}

provider "oci" {
  tenancy_ocid        = var.tenancy_ocid
  user_ocid           = var.user_ocid
  config_file_profile = "DEFAULT"
  region              = var.region
}
