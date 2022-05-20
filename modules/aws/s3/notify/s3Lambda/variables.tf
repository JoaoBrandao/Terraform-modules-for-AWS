variable "bucket" {}

variable "lambda_function_arn" {}

variable "events" {
  type = "list"
  default = []
}

variable "filter_prefix" { default = "" }

variable "filter_suffix" { default = "" }

