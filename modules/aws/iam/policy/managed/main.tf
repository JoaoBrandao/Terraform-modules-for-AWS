terraform {
  required_version  = "> 0.11.2"
}

resource "aws_iam_role_policy_attachment" "main" {
  role                      = "${var.role}"
  policy_arn                = "${var.policy_arn}"
}