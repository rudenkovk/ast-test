data "vcd_catalog_vapp_template" "debian12-xfs-tmpl" {
  org        = "org-fyim9ycf-cifrum-common"
  catalog_id = data.vcd_catalog.catalog-ac.id
  # name       = "debian12-xfs-v1.4"
  name         = "debian12-xfs-v1.4_old_mephi"
}

data "vcd_network_isolated_v2" "k8s-network-01" {
  org      = "org-fyim9ycf-cifrum-common"
  name     = "k8s-network-01"
  owner_id = data.vcd_org_vdc.atom-code.id
}

