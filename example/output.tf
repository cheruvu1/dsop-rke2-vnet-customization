output "rke2_cluster" {
  value = module.rke2.rke2_cluster
}

output "kv_name" {
  value = module.rke2.kv_name
}

output "rg_name" {
  value = var.use_external_vnet ? var.external_vnet_resource_group : azurerm_resource_group.rke2.*.name[0]
}
