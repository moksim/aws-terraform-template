variable "app_bucket_name" {
  type = string
}

variable "logs_bucket_name" {
  type = string
}

variable "logs_retention_days" {
  type    = number
  default = 30
}

variable "tags" {
  type    = map(string)
  default = {}
}
