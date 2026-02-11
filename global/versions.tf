terraform {
  required_version = ">= 1.5.0"     # Version Terraform

  required_providers {
    aws = {
        source = "hashicorp/aws"    # AWS provider official
        version = "~> 5.0"          # Version provider 5
    }
  }
}