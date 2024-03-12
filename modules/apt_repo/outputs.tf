output "ip" {
  value       = vsphere_virtual_machine.artifactory_server.default_ip_address
  description = "IP address of the Artifactory server"
}