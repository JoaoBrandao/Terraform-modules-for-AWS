
terraform {
//  required_version  = "> 0.11.10"
}

resource "aws_iam_user" "main" {
  count = "${length(var.users) > 0 ? length(var.users) : 0}"
  name = "${element(var.users, count.index)}"
  force_destroy = "${var.force_destroy}"
  path = "${var.path}"
  tags = "${merge(map(
    "Name", "${element(var.users, count.index)}",
    "Environment", "${var.tag_env}"),
    var.other_tags
  )}"
}
