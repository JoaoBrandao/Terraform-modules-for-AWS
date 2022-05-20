terraform {
  required_version  = "> 0.11.2"
}

resource "aws_cloudfront_origin_access_identity" "main" {
  comment = "${var.comment}"
}