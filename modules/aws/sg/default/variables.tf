

variable "vpc_id" {
  description = "The vpc id to create the security group in"
}

variable "igr_from" {
  description = "igr_from"
  default = 22
}

variable "igr_to" {
  description = "igr_to"
  default = 22
}

variable "igr_protocol" {
  default = "tcp"
}

variable "igr_cidr_blocks" {
  description = ""
  type = "list"
  default = ["0.0.0.0/0"]
}

variable "igr_security_groups" {
  description = ""
  type = "list"
  default = []
}

variable "egr_from" {
  default = 0
}

variable "egr_to" {
  default = 0
}

variable "egr_protocol" {
  default = "-1"
}

variable "egr_cidr_blocks" {
  type = "list"
  default = ["0.0.0.0/0"]
}

variable "egr_security_groups" {
  description = ""
  type = "list"
  default = []
}

/*
Tags
*/
variable "name" {
  description = "Input the name of stack"
  default     = ""
}

variable "tag_env" {
  description = "The environemnt this resource is being deployed to"
  default     = ""
}

variable "other_tags" {
  description = "For adding an additional values for tags"
  type = "map"
  default = {}
}
