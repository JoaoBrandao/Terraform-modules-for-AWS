terraform {
  required_version  = "> 0.11.2"
}

resource "aws_cloudfront_origin_access_identity" "main" {
  comment = "${var.name}"
}

resource "aws_cloudfront_distribution" "main" {
  aliases                           = ["${var.aliases}"]
  ordered_cache_behavior            = ["${var.ordered_cache_behavior}"]
  comment                           = "${var.comment}"
  custom_error_response             = ["${var.custom_error_response}"]
  default_cache_behavior {
    allowed_methods                 = ["${var.default_allowed_methods}"]
    cached_methods                  = ["${var.default_cached_methods}"]
    target_origin_id                = "s3-${var.name}-cft-target-origin-id"
    forwarded_values {
      query_string                  = "${var.default_forward_query_string}"
      headers                       = "${var.default_forward_headers}"
      cookies {
        forward                     = "${var.default_forward_cookies}"
      }
    }
//    viewer_protocol_policy          = "${var.default_forward_viewer_protocol_policy}"
    min_ttl                         = "${var.default_forward_min_ttl}"
    default_ttl                     = "${var.default_forward_default_ttl}"
    max_ttl                         = "${var.default_forward_max_ttl}"
  }
  default_root_object               = "${var.default_root_object}"
  enabled                           = "${var.enabled}"
  is_ipv6_enabled                   = "${var.is_ipv6_enabled}"
  http_version                      = "${var.http_version}"
//  logging_config {
//    include_cookies                 = "${var.log_include_cookies}"
//    bucket                          = "${var.log_bucket}"
//    prefix                          = "${var.log_prefix}"
//  }
  origin {
    domain_name                     = "${var.origin_domain_name}"
    origin_id                       = "s3-${var.name}-cft-target-origin-id"
    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.main.cloudfront_access_identity_path}"
    }
  }
  price_class                       = "${var.price_class}"
  restrictions {
    geo_restriction {
      restriction_type              = "${var.geo_restriction_type}"
      # locations                     = ["${var.geo_locations}"]
    }
  }
//  viewer_certificate {
//    acm_certificate_arn             = "${var.acm_certificate_arn}"
//    minimum_protocol_version        = "${var.minimum_protocol_version}"
//    ssl_support_method              = "${var.ssl_support_method}"
//  }
//  web_acl_id                        = "${var.web_acl_id}"
  retain_on_delete                  = "${var.retain_on_delete}"
  tags = "${merge(map(
    "Name", "${var.name}",
    "Environment", "${var.tag_env}"),
    var.other_tags
  )}"
}

resource "aws_s3_bucket" "main" {
  bucket = "${var.name}"
  acl    = "${var.acl}"
  force_destroy = "${var.destroy}"
  tags = "${merge(map(
    "Name", "${var.name}",
    "Environment", "${var.tag_env}"),
    var.other_tags
  )}"
}


resource "aws_s3_bucket_policy" "main" {
  bucket = "${aws_s3_bucket.main.id}"
  policy = <<POLICY
{
   "Version":"2012-10-17",
   "Id":"PolicyForCloudFrontPrivateContent",
   "Statement":[
     {
       "Sid":" Grant a CloudFront Origin Identity access to support private content",
       "Effect":"Allow",
       "Principal":{"CanonicalUser":"CloudFront Origin Identity ${aws_cloudfront_distribution.main.id}"},
       "Action":"s3:GetObject",
       "Resource":"${aws_s3_bucket.main.arn}/*"
     }
   ]
POLICY
}

