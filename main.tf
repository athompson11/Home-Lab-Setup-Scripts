provider "vsphere" {
  user                 = var.vsphere_username
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "datacenter" {
  name = var.vsphere_datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_cluster
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_resource_pool" "pool" {
  name          = var.resource_pool
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  name          = var.network_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

module "dns" {
  source = "./modules/dns"
  vm_name = "dns_server"
  vm_cpu = 4
  vm_memory = 4096
  guest_id = "ubuntu64Guest"
  datacenter_id = data.vsphere_datacenter.datacenter.id
  datastore_id = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  network_id = data.vsphere_network.network.id
  template_name = "ubuntu-base-image"
}

module "concourse" {
  source = "./modules/concourse_ci"
  vm_name = "concourse_host"
  vm_cpu = 8
  vm_memory = 8192
  guest_id = "ubuntu64Guest"
  datacenter_id = data.vsphere_datacenter.datacenter.id
  datastore_id = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  network_id = data.vsphere_network.network.id
  template_name = "ubuntu-base-image"
}