terraform {
  required_version  = "> 0.11.12"
}

resource "aws_iam_access_key" "main" {
  user = "${var.name}"
}