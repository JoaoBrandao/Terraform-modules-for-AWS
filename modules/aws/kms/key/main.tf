terraform {
  required_version  = "> 0.11.12"
}

resource "aws_kms_key" "main" {
  description                 = "${var.description}"
  policy                      = "${var.policy}"
  is_enabled                  = "${var.is_enabled}"
  tags = "${merge(map(
    "Name", "${var.name}",
    "Environment", "${var.tag_env}"),
    var.other_tags
  )}"
}

resource "aws_kms_alias" "main" {
  name          = "${var.key_alias}"
  target_key_id = "${aws_kms_key.main.key_id}"
}