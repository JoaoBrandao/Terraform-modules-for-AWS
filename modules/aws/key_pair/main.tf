terraform {
  required_version  = "> 0.11.7"
}

resource "aws_key_pair" "main" {
  key_name                    = "${var.key_name}"
  public_key                  = "${var.public_key}"
}