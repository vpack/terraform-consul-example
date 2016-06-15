variable "connection_user" {
    default = "ubuntu"
    description = "Ubuntu SSH user"
}

variable "consul_servers_count" {
    default = 3
    description = "The number of Consul servers to launch."
}

variable "consul_instance_type" {
    default = "t2.micro"
    description = "AWS Instance type"
}

variable "consul_tag_name" {
    default = "consul"
    description = "Name tag for the servers"
}

variable "ami"          { }

variable "environment"  { }

variable "region" {
  description = "AWS region to launch servers in."
  default = "us-east-1"
}

variable "key_name" {
    description = "SSH key name in your AWS account for AWS instances."
    default = "default"
}

variable "key_path" {
    description = "Path to the private key specified by key_name."
    default = "~/.ssh/id_rsa"
}

provider "aws" { }
