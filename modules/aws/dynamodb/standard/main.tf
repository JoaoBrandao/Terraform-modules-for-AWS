terraform {
  required_version  = "> 0.11.2"
}

resource "aws_dynamodb_table" "main" {
  name           = "${var.name}"
  read_capacity  = "${var.read_capacity}"
  write_capacity = "${var.write_capacity}"
  hash_key       = "${var.hash_key}"
  range_key      = "${var.range_key}"  
  attribute      = ["${var.attributes}"]
  stream_enabled = "${var.stream_enabled}"
  point_in_time_recovery {
    enabled = "${var.point_in_time_recovery_enabled}"
  }
  server_side_encryption {
    enabled = "${var.server_side_encryption_enabled}"
  }
  stream_view_type = "${var.stream_view_type}"
  tags = "${merge(map(
    "Name", "${var.name}",
    "Environment", "${var.tag_env}"),
    var.other_tags
  )}"
}