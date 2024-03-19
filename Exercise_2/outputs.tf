# TODO: Define the output variable for the lambda function.
output "lambda_function_arn" {
  description = "The ARN of the lambda function."
  value       = aws_lambda_function.lambda.arn
}

output "lambda_function_name" {
  description = "The name of the lambda function."
  value       = aws_lambda_function.lambda.function_name
}