terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

variable "users" {
  type = list(string)
}
variable "environment" {
  type = string
}

variable "file_version" {
  type = number
}

locals {
  prefix = (
    var.environment == "prod" ? "PROD" :
    var.environment == "dev"  ? "DEV"  :
    "UNKNOWN"
  )
}

variable "enable_file_audit" {
  type = bool
}

resource "local_file" "prod_only" {
  filename = "prod_only.txt"
  content  = "This file is only created in the PROD environment."
  count=var.environment=="prod"? 1 : 0
}

//create a file only if environment is prod and file audit is enabled
resource "local_file" "audit_prod" {
  filename = "audit_production.txt"
  content = <<-EOT
this is a file which would be created only if environment is prod and the file audit is enabled
  EOT
  count=var.environment=="prod"&&var.enable_file_audit?1:0
}
//always create one config file 
/*
dev  → DEBUG MODE ENABLED
prod → HIGH SECURITY MODE
else → DEFAULT MODE
*/
resource "local_file" "config" {
  filename = "config-${var.environment}.txt"
  content = (
    var.environment == "dev" ? "DEBUG MODE ENABLED" :
    var.environment == "prod" ? "HIGH SECURITY MODE" :
    "DEFAULT MODE"
  )
}
//add an output to show the prefix value and the content of the config file
output "prefix_outputs" {
  value = {
    prefix = local.prefix
    config_content = local_file.config.content
  }
}

resource "aws_instance" "name" {
  //make something interesting
  region = abs()
}

