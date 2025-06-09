resource "ansible_host" "nginx-sites" {
  count  = 3
  name   = format("nginx-sites-%s", count.index+1)
  groups = ["nginx-sites"]
  variables = {
    # Connection vars.
    ansible_user = "sunny" # Default user depends on the OS.
    ansible_host = format("10.20.4.%s", count.index + 11)

    # Custom vars that we might use in roles/tasks.
    hostname = format("nginx-sites-%s.cifrum.local", count.index+1)
    fqdn     = format("nginx-sites-%s.cifrum.local", count.index+1)
  }
}

resource "windns_record" "nginx-sites" {
  count = 3
  name   = format("nginx-sites-%s", count.index+1)
  type = "A"
  zone_name = "foundation.local"
  records = [format("10.20.4.%s", count.index + 11)]
}

resource "vcd_vm" "nginx-sites" {
  count = 3
  org   = var.vcd_org_org
  vdc   = var.vcd_org_vdc

  name = format("nginx-sites-%s", count.index+1)

  computer_name = format("nginx-sites-%s", count.index+1)
  memory        = 16384
  cpus          = 8
  cpu_cores     = 1

  os_type          = "debian12_64Guest"
  vapp_template_id = data.vcd_catalog_vapp_template.debian12-xfs-tmpl.id

  lifecycle {
    ignore_changes = [guest_properties]
  }

  override_template_disk {
    bus_type    = "paravirtual"
    size_in_mb  = "102400"
    bus_number  = 0
    unit_number = 0
  }

  customization {
    enabled = true
  }

  power_on = true

  network {
    name               = data.vcd_network_isolated_v2.k8s-network-01.name
    type               = "org"
    ip_allocation_mode = "MANUAL"
    ip                 = format("10.20.4.%s", count.index + 11)
  }

  guest_properties = {
    "local-hostname" = format("nginx-sites-%s", count.index+1)
    "user-data"      = base64encode(file("./user-data/debian-v1.0.yaml"))
  }
}

resource "terraform_data" "nginx-sites" {
  depends_on = [ vcd_vm.nginx-sites ]
  provisioner "local-exec" {

    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "False"
      ANSIBLE_PERSISTENT_CONNECT_RETRY_TIMEOUT = 30
    }
    command = "sleep 180 && rm -rf ~/.ssh/known_hosts && cd ../ansible/ && ansible-playbook common.yml -i terraform.yml --extra-vars=\"ansible_password='pZAIHz5k71LyUbTD'\" --extra-vars=\"ansible_become_password='pZAIHz5k71LyUbTD'\""
    interpreter = [ "/bin/bash", "-c" ]
  }
}
