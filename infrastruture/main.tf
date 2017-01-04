provider "aws" {
  region = "us-east-1"
}

# data "terraform_remote_state" "master_state" {
#   backend = "s3"
#   config {
#     bucket = "meet-app--terraform-state"
#     region = "eu-west-2"
#     key = "meet-app--${var.env}.tfstate"
#   }
# }
