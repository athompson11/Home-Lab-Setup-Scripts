resource "vsphere_virtual_machine" "database_server" {
  name             = var.vm_name
  num_cpus         = var.vm_cpu
  memory           = var.vm_memory
  guest_id         = var.guest_id
  datastore_id     = var.datastore_id
  resource_pool_id = var.resource_pool_id

  network_interface {
    network_id = var.network_id
    mac_address = var.mac_address
    use_static_mac = true
  }

  disk {
    label = "disk0"
    size  = 100
    thin_provisioned = true
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize{
    linux_options {
        host_name = var.host_name
        domain    = var.domain_name
      }
    }
  }
}

data "vsphere_virtual_machine" "template" {
  name          = var.template_name
  datacenter_id = var.datacenter_id
}