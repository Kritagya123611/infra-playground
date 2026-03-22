//all the environment variables and provider configuration 
locals {
  prefix=(
    var.environment=="prod"?"PROD":
    var.environment=="dev"?"DEV":
    "DEFAULT"
  )
}

module "files" {
  source = "./modules/file_creator"

  /*users        = var.users
  environment  = var.environment
  file_version = var.file_version
  prefix       = local.prefix*/
}