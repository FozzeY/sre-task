variable "hostname" {
  type = "string"
}

terraform {
  cloud {
    organization = "imel"
    workspaces {
      name = "sre-task"
    }
  }
  required_providers {
    vultr = {
      source = "vultr/vultr"
    }
  }
    namecheap = {
      source = "namecheap/namecheap"
    }
}

resource "vultr_ssh_key" "ansible" {
  name    = "Ansible"
  ssh_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJWRMiE+JFu2WAP2uOeaOoy11kdBz/7NWCdYow2mS5qA ansible@${var.hostname}"
}

resource "vultr_ssh_key" "personal" {
  name    = "Personal"
  ssh_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJP1YicVpdk9zzalUa+3MbQWAhFRAMLTEHAgbBiN8/Xu admin${var.hostname}"
}

data "vultr_os" "ubuntu_2404" {
  filter {
    name   = "name"
    values = ["Ubuntu 24.04 LTS x64"]
  }
}

resource "vultr_instance" "this" {
  region      = "waw"
  plan        = "vhp-1c-1gb-amd"
  os_id       = data.vultr_os.ubuntu_2404.id
  label       = var.hostname
  hostname    = var.hostname
  ssh_key_ids = [vultr_ssh_key.ansible.id, vultr_ssh_key.personal.id]
}
