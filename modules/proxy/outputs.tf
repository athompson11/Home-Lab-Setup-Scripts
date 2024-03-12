output "ip" {
  value       = vsphere_virtual_machine.proxy_server.default_ip_address
  description = "IP address of the proxy server"
}