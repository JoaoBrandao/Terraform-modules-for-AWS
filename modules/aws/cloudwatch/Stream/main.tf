terraform {
  required_version  = "> 0.11.2"
}

resource "aws_cloudwatch_log_stream" "main" {
  name           = "${var.stream_name}"
  log_group_name = "${var.logGroup}"
}