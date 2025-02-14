terraform {
    required_providers {
      proxmox = {
        source = "telmate/proxmox"
      }
    }
}

provider "proxmox" {
  pm_api_url = "Proxmox-URL/api2/json"
  pm_api_token_id = "token-id-xxx" # Create first an API token on Proxmox, paste the ID here
  pm_api_token_secret = "token-secret-xxx" # Create first an API token on Proxmox, paste the secret here
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
        //discard     = "on" # use this to on if you have SSD disk
    }

    network {
        model       = "virtio"
        bridge      = "vmbr"
        firewall    = false
        link_down   = false
    }
}
