resource "oci_core_vcn" "this" {
  compartment_id = oci_identity_compartment.this.id
  cidr_blocks    = ["10.0.0.0/16"]
  display_name   = "wireguard"
  dns_label      = "wireguard"
}

resource "oci_core_subnet" "this" {
  cidr_block        = "10.0.1.0/24"
  compartment_id    = oci_identity_compartment.this.id
  vcn_id            = oci_core_vcn.this.id
  display_name      = "wireguard"
  dns_label         = "wireguard"
  security_list_ids = [oci_core_security_list.this.id]
  route_table_id    = oci_core_route_table.this.id
}

resource "oci_core_security_list" "this" {
  compartment_id = oci_identity_compartment.this.id
  vcn_id         = oci_core_vcn.this.id
  display_name   = "wireguard"

  ingress_security_rules {
    protocol    = "17" # one of ICMP ("1"), TCP ("6"), UDP ("17"), and ICMPv6 ("58").
    source      = "0.0.0.0/0"
    description = "Allow ${var.wireguard_listen_port} UDP from anywhere (wireguard listen port)"
    udp_options {
      min = var.wireguard_listen_port
      max = var.wireguard_listen_port
    }
  }

  ingress_security_rules {
    protocol    = "6" # one of ICMP ("1"), TCP ("6"), UDP ("17"), and ICMPv6 ("58").
    source      = "0.0.0.0/0"
    description = "Allow 22 TCP from anywhere for ssh"
    tcp_options {
      min = "22"
      max = "22"
    }
  }

  egress_security_rules {
    description      = "Allow all ports and all protocols"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"
    stateless        = false
  }
}

resource "oci_core_internet_gateway" "this" {
  compartment_id = oci_identity_compartment.this.id
  vcn_id         = oci_core_vcn.this.id
  enabled        = true
  display_name   = "wireguard"
}

resource "oci_core_route_table" "this" {
  #Required
  compartment_id = oci_identity_compartment.this.id
  vcn_id         = oci_core_vcn.this.id
  display_name   = "wireguard"
  route_rules {
    network_entity_id = oci_core_internet_gateway.this.id
    description       = "route internet traffic through the igw"
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
  }
}
