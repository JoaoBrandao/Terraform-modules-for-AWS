variable "port" {
  default = "22"
}

variable "protocol" {
  default = "tcp"
}

variable "security_group_id" {}

variable "type" {
  default = "ingress"
}

variable "cidr_blocks" {
  type = "list"
  default = [""]
}

