output "user_arn" {
  value = aws_iam_user.main.arn
}

output "user_name" {
  value = aws_iam_user.main.name
}

output "user_unique_id" {
  value = aws_iam_user.main.unique_id
}

output "policy_arn" {
  value = aws_iam_policy.main[0].arn
}

