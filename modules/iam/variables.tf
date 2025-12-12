variable "role_name" {
  type = string
}

variable "instance_profile_name" {
  type = string
}

variable "logs_bucket_arn" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
