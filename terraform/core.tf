resource "oci_core_instance" "this" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = oci_identity_compartment.this.id
  display_name        = "wireguard"
  metadata = {
    "ssh_authorized_keys" = file("~/.ssh/oci1.pub")
  }
  shape = "VM.Standard.E2.1.Micro"
  // image ocid found here https://docs.oracle.com/en-us/iaas/images/image/aeb80dc6-48a2-4c28-953b-5ddc386eb667/
  source_details {
    source_id   = var.instance_source_id
    source_type = "image"
  }
  create_vnic_details {
    assign_public_ip = true
    subnet_id        = oci_core_subnet.this.id
  }
}
