module "data-s3-bucket" {
  source            = "./module/s3"
  bucket_versioning = false
  bucket_name       = "data-bucket"
  encryption-type   = "aws:kms"
  kms_key_id        = module.my-kms.id
}

module "key_pair" {
  source        = "./module/key-pair"
  bucket_name   = module.data-s3-bucket.bucket_name
  key_pair_name = "my-keypair"
}


module "my-kms" {
  source          = "./module/kms"
  project_name    = var.project_name
  kms-policy-path = "./assets/kms-key-policy.json"
}

module "cloudtrail" {
  source       = "./module/cloudtrail"
  project_name = "my-project"
  kms_key_arn  = module.my-kms.arn

}

