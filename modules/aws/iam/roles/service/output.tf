output "arn" {
  value = "${aws_iam_instance_profile.main.arn}"
}

output "unique_id" {
  value = "${aws_iam_instance_profile.main.unique_id}"
}

output "name" {
  value = "${aws_iam_instance_profile.main.name}"
}
