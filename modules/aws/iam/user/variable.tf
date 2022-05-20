variable "name" {
}

variable "force_destroy" {
  default = false
}

variable "path" {
  default = "/"
}

variable "policy" {
  default = ""
}

variable "tag_env" {
  description = "The environment this resource is being deployed to"
  default     = ""
}

variable "keys" {
  default = false
}

variable "other_tags" {
  description = "For adding an additional values for tags"
  type        = map(string)
  default     = {}
}

