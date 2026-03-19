
module "key_pair" {
  source        = "./module/key-pair"
  bucket_name   = module.data-s3-bucket-1.bucket_name
  key_pair_name = "my-keypair"
}


module "my-kms" {
  source          = "./module/kms"
  project_name    = var.project_name
  kms-policy-path = "./assets/policies/kms-key-policy.json"
}

module "cloudtrail" {
  source       = "./module/cloudtrail"
  project_name = "my-project"
}

module "my-vpc" {
  source = "./module/vpc"
  enable_ipv6 = false
  vpc_cidr = "10.100.0.0/16"
  enable_nat = false
  project_name = "test"
  tags = {
    "key" = "values" 
  }
}
