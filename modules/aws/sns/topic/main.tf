
terraform {
  required_version  = "> 0.11.2"
}

resource "aws_sns_topic" "main" {
  name = "${var.name}"
}