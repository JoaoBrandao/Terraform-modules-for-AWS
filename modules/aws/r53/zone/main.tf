terraform {
  required_version  = "> 0.11.2"
}

resource "aws_route53_zone" "main" {
  name = "${var.name}"
  comment = "${var.comment}"
  tags = "${merge(map(
    "Name", "${var.name}",
    "Environment", "${var.tag_env}"),
    var.other_tags
  )}"
}