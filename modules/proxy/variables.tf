variable "vm_name" {
  description = "The name of the virtual machine"
  type        = string
}

variable "vm_cpu" {
  description = "The number of CPUs for the virtual machine"
  type        = number
}

variable "vm_memory" {
  description = "The amount of memory (in MB) for the virtual machine"
  type        = number
}

variable "guest_id" {
  description = "The guest ID for the virtual machine"
  type        = string
}

variable "datacenter_id" {
  description = "The ID of the datacenter where the virtual machine will be created"
  type        = string
}

variable "datastore_id" {
  description = "The ID of the datastore where the virtual machine will be created"
  type        = string
}

variable "resource_pool_id" {
  description = "The ID of the resource pool for the virtual machine"
  type        = string
}

variable "network_id" {
  description = "The ID of the network for the virtual machine"
  type        = string
}

variable "template_name" {
  description = "The name of the template to use for cloning"
  type        = string
}

variable "mac_address"{
  description = "The VM's Mac Address"
  type = string
}