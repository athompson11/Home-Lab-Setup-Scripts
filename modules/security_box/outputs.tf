output "ip" {
  value       = vsphere_virtual_machine.security_server.default_ip_address
  description = "IP address of the security server"
}