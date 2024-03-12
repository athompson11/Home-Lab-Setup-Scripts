resource "vsphere_virtual_machine" "web_app_server" {
  name             = var.vm_name
  num_cpus         = var.vm_cpu
  memory           = var.vm_memory
  guest_id         = var.guest_id
  datastore_id     = var.datastore_id
  resource_pool_id = var.resource_pool_id

  network_interface {
    network_id = var.network_id
    mac_address = var.mac_address
  }

  disk {
    label = "disk0"
    size  = 1000
    thin_provisioned = true
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }
}

data "vsphere_virtual_machine" "template" {
  name          = var.template_name
  datacenter_id = var.datacenter_id
}