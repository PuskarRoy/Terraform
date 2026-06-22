module "my-vpc" {
  source       = "./module/vpc"
  vpc_cidr     = "10.100.0.0/16"
  enable_nat   = false
  project_name = "test"
}

