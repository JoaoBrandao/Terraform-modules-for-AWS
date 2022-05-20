resource "aws_iam_user" "main" {
  name          = var.name
  force_destroy = var.force_destroy
  path          = var.path
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

resource "aws_iam_access_key" "main" {
  count = var.keys == true ? 1 : 0
  user  = aws_iam_user.main.name
}

resource "aws_iam_policy" "main" {
  count  = length(var.policy) > 0 ? 1 : 0
  name   = "${var.name}-policy"
  policy = var.policy
}

resource "aws_iam_policy_attachment" "main" {
  count      = length(var.policy) > 0 ? 1 : 0
  name       = var.name
  users      = [aws_iam_user.main.name]
  policy_arn = aws_iam_policy.main[0].arn
  depends_on = [aws_iam_policy.main]
}

