terraform {
  required_providers {
    macaddress = {
      source = "ivoronin/macaddress"
      version = "0.3.2"
    }
  }
}

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
resource "macaddress" "dns_address" {
}
resource "macaddress" "concourse_address" {
}
resource "macaddress" "zabbix_address" {
}
resource "macaddress" "apt_address" {
}
resource "macaddress" "security_address" {
}
resource "macaddress" "proxy_address" {
}
resource "macaddress" "portfolio_address" {
}
module "dns" {
  source = "./modules/dns"
  vm_name = "dns_server"
  vm_cpu = 4
  vm_memory = 4096
  guest_id = "ubuntu64Guest"
  mac_address  = macaddress.dns_address.address
  datacenter_id = data.vsphere_datacenter.datacenter.id
  datastore_id = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  network_id = data.vsphere_network.network.id
  template_name = "ubuntu-base-image"
}
module "concourse" {
  source = "./modules/concourse_ci"
  vm_name = "concourse_server"
  vm_cpu = 8
  vm_memory = 8192
  guest_id = "ubuntu64Guest"
  mac_address  = macaddress.concourse_address.address
  datacenter_id = data.vsphere_datacenter.datacenter.id
  datastore_id = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  network_id = data.vsphere_network.network.id
  template_name = "ubuntu-base-image"
}
module "zabbix" {
  source = "./modules/web_app_server"
  vm_name = "zabbix_server"
  vm_cpu = 4
  vm_memory = 4096
  guest_id = "ubuntu64Guest"
  host_name = "zabbix"
  domain_name = "zabbix.homelab.dev"
  mac_address  = macaddress.zabbix_address.address
  datacenter_id = data.vsphere_datacenter.datacenter.id
  datastore_id = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  network_id = data.vsphere_network.network.id
  template_name = "ubuntu-base-image"
}
module "apt_server" {
  source = "./modules/apt_repo"
  vm_name = "artifactory_server"
  vm_cpu = 4
  vm_memory = 4096
  guest_id = "ubuntu64Guest"
  mac_address  = macaddress.apt_address.address
  datacenter_id = data.vsphere_datacenter.datacenter.id
  datastore_id = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  network_id = data.vsphere_network.network.id
  template_name = "ubuntu-base-image"
}

module "security_server" {
  source = "./modules/security_box"
  vm_name = "perry"
  vm_cpu = 4
  vm_memory = 4096
  guest_id = "ubuntu64Guest"
  mac_address  = macaddress.security_address.address
  datacenter_id = data.vsphere_datacenter.datacenter.id
  datastore_id = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  network_id = data.vsphere_network.network.id
  template_name = "ubuntu-base-image"
}

module "proxy" {
  source = "./modules/proxy"
  vm_name = "proxy_server"
  vm_cpu = 4
  vm_memory = 2048
  guest_id = "ubuntu64Guest"
  mac_address  = macaddress.proxy_address.address
  datacenter_id = data.vsphere_datacenter.datacenter.id
  datastore_id = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  network_id = data.vsphere_network.network.id
  template_name = "webserver-base-image"
}

module "portfolio" {
  source = "./modules/web_server"
  vm_name = "portfolio_server"
  vm_cpu = 2
  vm_memory = 2048
  guest_id = "ubuntu64Guest"
  host_name = "resumewebserver"
  domain_name = "resume.homelab.dev"
  mac_address  = macaddress.portfolio_address.address
  datacenter_id = data.vsphere_datacenter.datacenter.id
  datastore_id = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  network_id = data.vsphere_network.network.id
  template_name = "webserver-base-image"
}

data "template_file" "ansible_inventory" {
template = <<EOF
[dns_server]
${module.dns.ip}
[concourse_server]
${module.concourse.ip}
[zabbix_server]
${module.zabbix.ip}
[artifactory_server]
${module.apt_server.ip}
[perry]
${module.security_server.ip}
[proxy_server]
${module.proxy.ip}
[portfolio_server]
${module.portfolio.ip}
EOF
}

# Create the inventory file
resource "local_file" "inventory" {
  depends_on = [module.dns,module.concourse,module.portfolio,module.proxy,module.security_server,module.apt_server,module.zabbix]
  content  = data.template_file.ansible_inventory.rendered
  filename = "inventory.ini"
}