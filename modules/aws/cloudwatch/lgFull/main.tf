terraform {
  required_version  = "> 0.9.8"
}

resource "aws_cloudwatch_log_group" "main" {
  name = "${var.name}"
  tags = "${merge(map(
    "Name", "${var.name}",
    "Environment", "${var.tag_env}"),
    var.other_tags
  )}"
}

resource "aws_cloudwatch_log_stream" "main" {
  name           = "${var.stream_name}"
  log_group_name = "${aws_cloudwatch_log_group.main.name}"
}