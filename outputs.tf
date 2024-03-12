output "dns_server_ip" {
    value = module.dns.ip
}
output "concourse_server_ip" {
    value = module.concourse.ip
}
output "zabbix_server_ip" {
    value = module.zabbix.ip
}
output "apt_server_ip" {
    value = module.apt_server.ip
}

output "security_server_ip" {
    value = module.security_server.ip
}

output "proxy_server_ip" {
    value = module.proxy.ip
}

output "portfolio_server_ip" {
    value = module.portfolio.ip
}