variable "region" {
  default = "eu-west-1"
}

variable "ami" {
  default = "ami-0be2988e4d5a5c301"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "my_ip" {
  default = "127.0.0.1/32"
}

variable "app_bucket_name" {
  type = string
}

variable "logs_bucket_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
