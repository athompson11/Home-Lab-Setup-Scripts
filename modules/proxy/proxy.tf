# modules/proxy
resource "vsphere_virtual_machine" "proxy_server" {
  name             = var.proxy_server_name
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = var.proxy_cpu_cores
  memory           = var.proxy_memory

  network_interface {
    network_id = data.vsphere_network.network.id
  }
}
