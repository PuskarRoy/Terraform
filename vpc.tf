module "my-project-vpc" {
  source       = "./module/vpc"
  vpc_cidr     = "10.20.0.0/16"
  enable_nat   = true
  project_name = "MY Project"
}

