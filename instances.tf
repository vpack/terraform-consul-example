resource "aws_instance" "consul_server" {
    ami = "${var.ami}"
    instance_type = "${var.consul_instance_type}"
    key_name = "${var.key_name}"
    count = "${var.consul_servers_count}"
    availability_zone = "${element(split(",", terraform_remote_state.vpc.output.zones), count.index % length(split(",", terraform_remote_state.vpc.output.zones)))}"
    subnet_id     = "${element(split(",", "${terraform_remote_state.vpc.output.WebSubnets}" ), count.index)}"
    
    vpc_security_group_ids = [
        "${aws_security_group.consul.id}"
    ]

    connection {
        user = "${var.connection_user}"
        key_file = "${var.key_path}"
    }

    tags {
        Name = "${var.consul_tag_name}-${count.index+1}"
        Environment = "production"
        Role = "consul"
    }

    # Set some data
    provisioner "remote-exec" {
        inline = [
            "echo Running remote-exec: ",
            "echo ${var.consul_servers_count} > /tmp/consul-server-count",
            "echo ${aws_instance.consul_server.0.private_ip} > /tmp/consul-server-addr",
            "echo aws-${var.aws_region} > /tmp/consul-datacenter",
        ]
    }
    
    # Upgrade and set variables
    provisioner "remote-exec" {
        scripts = [
            "${path.module}/scripts/upgrade.sh",
            "${path.module}/scripts/variables.sh",
        ]
    }

    # Run ansible
    provisioner "local-exec" {
        command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --user=${var.connection_user} -i \"${self.private_ip},\" ${path.module}/ansible/playbook.yml"
    }
}
