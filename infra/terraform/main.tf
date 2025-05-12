# infra/terraform/main.tf
terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 4.0.0"
    }
  }
}

provider "oci" {
  tenancy_ocid        = var.tenancy_ocid
  user_ocid           = var.user_ocid
  fingerprint         = var.fingerprint
  private_key_path    = var.private_key_path
  region              = var.region
}

resource "oci_core_instance" "rag_slack_instance" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_ocid
  shape               = "VM.Standard.E2.1.Micro"

  create_vnic_details {
    assign_public_ip = true
    subnet_id        = var.subnet_ocid
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key_path)
    user_data            = base64encode(file("${path.module}/user_data.sh"))
  }

  source_details {
    source_type = "image"
    source_id   = var.image_ocid
  }

  display_name = "rag-slack-instance"
}

output "instance_public_ip" {
  value = oci_core_instance.rag_slack_instance.public_ip
}
