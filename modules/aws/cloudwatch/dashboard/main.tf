terraform {
  required_version = "> 0.11.12"
}

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_body = "${var.dashboard_body}"
  dashboard_name = "${var.name}"
}