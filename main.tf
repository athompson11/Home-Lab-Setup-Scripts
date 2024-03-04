provider "vsphere" {
  user     = var.vsphere_username
  password = var.vsphere_password
  vsphere_server = var.vsphere_server
  datacenter = 
}