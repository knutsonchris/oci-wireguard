variable "tenancy_ocid" {
  type        = string
  description = "The OCID of the tenancy to deploy into."
}

variable "user_ocid" {
  type        = string
  description = "The OCID of the user used to deploy."
}

variable "region" {
  type        = string
  description = "The OCI region to deploy into."
}

variable "wireguard_listen_port" {
  type        = string
  description = "This port will be open to UDP 0.0.0.0/0"
}

variable "instance_source_id" {
  type        = string
  description = "The OCID of the image to use for the instance"
}
