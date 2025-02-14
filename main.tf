terraform {
    required_providers {
      proxmox = {
        source = "telmate/proxmox"
      }
    }
}

provider "proxmox" {
  pm_api_url = "https://192.168.1.9:8006/api2/json"
  pm_api_token_id = "terraform@pve!Terraform-Token"
  pm_api_token_secret = "1a0fe11f-629b-43b9-8ee0-a6ec50d474ba"
  pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "vm-instance" {
    name            = "k8s-03"
    target_node     = "proxmox3"
    clone           = "Ubuntu-Server"
    full_clone      = true
    cores           = 2
    memory          = 4096

    disk {
        size        = "20G"
        type        = "scsi"
        storage     = "local-lvm"
        //discard     = "off" # change this to on if you have SSD disk
    }

    network {
        model       = "virtio"
        bridge      = "vmbr"
        firewall    = false
        link_down   = false
    }
}
