terraform {
  required_version = "~> 1.15"
  backend "s3" {
    bucket = "terraform-state-bucket-908957720785"
    key    = "state/terraform.tfstate"
    region = "ap-south-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.9"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.2"
    }
  }
}