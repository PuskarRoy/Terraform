module "data-s3-bucket-1" {
  source            = "./module/s3"
  bucket_versioning = false
  bucket_name       = "data-bucket-2"
  encryption-type   = "aws:kms"
  kms_key_id        = module.my-kms.arn
}

module "data-s3-bucket-2" {
  source = "./module/s3"
  bucket_versioning = true
  bucket_name = "data-bucket-2"


}

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
