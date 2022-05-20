variable "function_name" {}

variable "execution_role" {}

variable "s3_bucket" {}

variable "s3_key" {}

variable "source_code_hash" {}

variable "handler" {
  default = ""
}

variable "memory_size" {
  default = 128
}

variable "runtime" {
  default = "nodejs8.10 | nodejs10.x | java8 | python2.7 | python3.6 | python3.7 | dotnetcore1.0 | dotnetcore2.1 | go1.x | ruby2.5 | provided"
  default = "nodejs8.10"
}

variable "timeout" {
  default = 3
}

variable "reserved_concurrent_executions" {
  default = "-1"
}

variable "publish" {
  default = true
}

variable "subnet_ids" {
  type    = "list"
  default = []
}

variable "security_group_ids" {
  type    = "list"
  default = []
}

variable "tracing_config_mode" {
  default = "Active"
}

variable "kms_key_arn" {
  default = ""
}

variable "environment_variables" {
  type    = "map"
  default = {}
}

// Tags

variable "tag_env" {
  default = ""
}

variable "other_tags" {
  type    = "map"
  default = {}
}