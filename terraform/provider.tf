terraform {
  required_version = ">=1.3.0"

  required_providers {
    vcd = {
      source  = "vmware/vcd"
      version = "3.14.0"
    }

    ansible = {
      source  = "ansible/ansible"
      version = "1.3.0"
    }

    windns = {
      source  = "rvanmarkus/windns"
      version = "1.0.7"
    }
  }
}

provider "windns" {
  ssh_hostname = "dc04.foundation.local"
  ssh_username = "dns_admin"
  ssh_password = "LUrXAfHXEc0VLHe673uWpJHs2rgH6Jm9"
}

data "vault_generic_secret" "terraform" {
  path = "login-passwords/terraform"
}

provider "vcd" {
  user      = "terraform"
  password  = "hUc9fH1s8cJJKqFbB1JR10vL5HBnQEyN"
  auth_type = "integrated"
  org       = "B689B81B-3E74-4162-805E-A14BB7652BE4"
  vdc       = "foundation-prj-01"
  url       = "https://vcd-az1.t1.cloud/api"
  # max_retry_timeout    = var.vcd_max_retry_timeout
  allow_unverified_ssl = true
}

provider "vault" {
  address = "https://vault.foundation.local/"
  token   = var.vault_token
}

