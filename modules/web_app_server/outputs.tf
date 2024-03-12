output "ip" {
  value       = vsphere_virtual_machine.web_app_server.default_ip_address
  description = "IP address of the web app server"
}