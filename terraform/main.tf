variable "hostname" {
  type = string
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
}

resource "vultr_ssh_key" "ansible" {
  name    = "Ansible"
  ssh_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJWRMiE+JFu2WAP2uOeaOoy11kdBz/7NWCdYow2mS5qA ansible@${var.hostname}"
}

data "vultr_os" "ubuntu_2404" {
  filter {
    name   = "name"
    values = ["Ubuntu 24.04 LTS x64"]
  }
}

resource "vultr_reserved_ip" "this" {
  label   = var.hostname
  region  = "waw"
  ip_type = "v4"
}

resource "vultr_instance" "this" {
  region         = "waw"
  plan           = "vhp-1c-1gb-amd"
  os_id          = data.vultr_os.ubuntu_2404.id
  label          = var.hostname
  hostname       = var.hostname
  ssh_key_ids    = [vultr_ssh_key.ansible.id]
  reserved_ip_id = vultr_reserved_ip.this.id
}

output "instance_ip" {
  value = vultr_instance.this.main_ip
}
