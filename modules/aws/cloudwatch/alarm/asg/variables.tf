variable "alarm_name" {}

variable "comparison_operator" {}

variable "evaluation_periods" {}

variable "metric_name" {}

variable "namespace" {}

variable "period" {}

variable "statistic" {}

variable "threshold" {}

variable "alarm_description" {}

variable "datapoints_to_alarm" {}

variable "as_group_name" {}

variable "alarm_actions" {
  type = "list"
  default = []
}

variable "insufficient_data_actions" {
  type = "list"
  default = []
}

variable "ok_actions" {
  type = "list"
  default = []
}

variable "treat_missing_data" {}