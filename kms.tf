module "my-kms" {
  source       = "./module/kms"
  project_name = var.project_name
}