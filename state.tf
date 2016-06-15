# Infrastructure State

resource "terraform_remote_state" "vpc" {
    backend = "s3"
    config {
        bucket = "terraform-tf-states-${var.environment}-infra-${var.region}"
        key = "infra_${var.environment}" 
        region = "us-east-1"                    #  Always save State file to us-east-1 region.
    }
}
