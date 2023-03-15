resource "oci_identity_compartment" "this" {
  compartment_id = var.tenancy_ocid
  description    = "all the resources for the always-free wireguard vpn"
  name           = "wireguard"
  freeform_tags  = { "terraform/managed" = "true" }
}
