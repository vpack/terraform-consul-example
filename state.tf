# Infrastructure State

# Notes:
#  Always use us-east-1 region for State.

resource "terraform_remote_state" "vpc" {
    backend = "s3"
    config {
#        bucket = "${format("terraform-tf-states-%x-%x-%x", "${var.environment}" , "${var.project}", "${var.region}")}"
        bucket = "terraform-tf-states-dev-infra-us-east-1"
        key = "infra_dev"
        region = "us-east-1"
    }
}
