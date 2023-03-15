output "name-of-first-availability-domain" {
  value = data.oci_identity_availability_domains.ads.availability_domains[0].name
}

output "wireguard_instance_public_ip" {
  value = oci_core_instance.this.public_ip
}

output "wireguard_vcn_ocid" {
  value = oci_core_vcn.this.id
}

output "wireguard_compartment_ocid" {
  value = oci_identity_compartment.this.id
}
