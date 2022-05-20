terraform {
  required_version  = "~> 0.11.12"
}

resource "aws_kms_grant" "main" {
//  provider          = "${var.alias}"
  name              = "${var.name}"
  key_id            = "${var.key_id}"
  grantee_principal = "${var.grantee_principal}"
  operations        = ["${var.operations}"]

}