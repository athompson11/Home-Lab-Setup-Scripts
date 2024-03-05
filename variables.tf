variable "vsphere_username" {
  description = "Username for vSphere"
  type        = string
}

variable "vsphere_password" {
  description = "Password for vSphere"
  type        = string
}

variable "vsphere_server" {
  description = "vSphere server URL"
  type        = string
}

variable "vsphere_datacenter" {
  description = "vCenter Datacenter"
  type        = string
}

variable "vsphere_datastore" {
  description = "vSphere Datastore"
  type        = string
}

variable "network_name" {
  description = "vSphere Network Name"
  type        = string
}

variable "vsphere_cluster" {
  description = "vCenter Cluster"
  type        = string
}

variable "resource_pool" {
  description = "vCenter Resource Pool"
  type        = string
}

variable "ubuntu_base_image" {
  description = "Path to base Ubuntu image"
  type        = string
}

variable "webserver_base_image" {
  description = "Path to base webserver image"
  type        = string
}