terraform {
  required_version  = "> 0.11.2"
}

resource "aws_sns_topic_policy" "main" {
  arn = "${var.topic_arn}"
  policy = "${var.policy_doc}"
}
