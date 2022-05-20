variable "bucket" {}

variable "sns_arn" { default = "" }

variable "events" {
  type = "list"
  default = []
}


variable "filter_suffix" { default = "" }

variable "filter_prefix" { default = "" }
