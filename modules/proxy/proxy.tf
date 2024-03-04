# modules/proxy

data "vsphere_virtual_machine" "ubuntu_template" {
  name = "UbuntuTemplate" 
}

resource "vsphere_virtual_machine" "proxy_server" {
  name             = var.proxy_server_name
  template_uuid    = data.vsphere_virtual_machine.ubuntu_template.id
  resource_pool_id = data.vsphere_resource_pool.pool.id  # Assuming you get pool data
  datastore_id     = data.vsphere_datastore.datastore.id  # Assuming you get datastore data
  num_cpus         = var.proxy_cpu_cores
  memory           = var.proxy_memory

  network_interface {
    network_id = data.vsphere_network.network.id  # Assuming you get network data
  }
}
