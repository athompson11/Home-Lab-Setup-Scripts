output "dns_server_ip" {
  value       = vsphere_virtual_machine.dns_server.default_ip_address
  description = "IP address of the DNS server"
}