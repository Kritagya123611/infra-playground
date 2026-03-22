//this are the inputs/variables required by the root modules
//users,environment,file_version

variable "users" {
  type = list(string)
  default = [ "usr1", "usr2", "usr3" ]
}

variable "environment" {
  type = string
  default = "prod"
}

variable "file_version" {
  type = number
  default = 1.0
}