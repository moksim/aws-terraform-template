variable "name" {}
variable "vpc_id" {}
variable "public_subnet_id" {}
variable "my_ip" {}
variable "key_name" {}
variable "public_key_path" {}
variable "ami" {}
variable "instance_type" {}
variable "private_key_path" {
  default = "~/.ssh/maksim-key"
}

variable "ssh_user" {
  default = "ubuntu"
}
