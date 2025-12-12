variable "name" {}
variable "vpc_id" {}
variable "public_subnet_id" {}
variable "my_ip" {}
variable "ami" {}
variable "instance_type" {}
variable "existing_key_name" {
  type = string
}
variable "ssh_user" {
  default = "ubuntu"
}

variable "iam_instance_profile" {
  type    = string
  default = null
}

variable "user_data" {
  type    = string
  default = null
}
