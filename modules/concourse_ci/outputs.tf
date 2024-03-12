output "ip" {
  value       = vsphere_virtual_machine.concourse_server.default_ip_address
  description = "IP address of the Concourse server"
}