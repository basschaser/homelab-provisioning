terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.2.3"
    }
    remote = {
      source  = "tenstad/remote"
      version = "0.1.1"
    }
  }
}
