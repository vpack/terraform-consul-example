output "consul_servers" { value = "${ join(", ", aws_instance.consul_server.*.private_ip) }" }
output "consul_ui" { value = "http://${ aws_instance.consul_server.0.private_ip }" }
