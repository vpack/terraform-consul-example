# AWS credentials
variable "aws_region" {
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
