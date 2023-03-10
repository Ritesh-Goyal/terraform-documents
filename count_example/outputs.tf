output "one_arn" {
  value       = aws_iam_user.users[0].arn
  description = "The ARN for user Sourav Ganguly"
}

output "all_arns" {
  value       = aws_iam_user.users[*].arn
  description = "The ARNs for all users"
}