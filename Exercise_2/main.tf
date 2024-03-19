provider "aws" {
  region     = var.aws_region
  access_key = "AKIAQSGIY62VMMP72672"
  secret_key = "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"
}

data "archive_file" "zip_python_code" {
  type        = "zip"
  source_dir  = "${path.module}/python/"
  output_path = "${path.module}/python.zip"
}

resource "aws_iam_role" "lambda_role" {
  name               = "Spacelift_Test_Lambda_Function_Role"
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "lambda.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

#policy for logs
resource "aws_iam_policy" "iam_policy_for_lambda" {

  name        = "aws_iam_policy_for_terraform_aws_lambda_role"
  path        = "/"
  description = "AWS IAM Policy for managing aws lambda role"
  policy      = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": [
       "logs:CreateLogGroup",
       "logs:CreateLogStream",
       "logs:PutLogEvents"
     ],
     "Resource": "arn:aws:logs:*:*:*",
     "Effect": "Allow"
   }
 ]
}
EOF
}
#attach policy to role
resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  policy_arn = aws_iam_policy.iam_policy_for_lambda.arn
  role       = aws_iam_role.lambda_role.name
}

resource "aws_lambda_function" "lambda" {
  filename      = "${path.module}/python.zip"
  function_name = "Py_Test_Lambda_Function"
  role          = aws_iam_role.lambda_role.arn
  handler       = "greet_lambda.lambda_handler"
  runtime       = "python3.12"
  depends_on    = [aws_iam_role_policy_attachment.role_policy_attachment]
  environment {
    variables = {
      "greeting" = "Hello there!"
    }
  }
}