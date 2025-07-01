provider "aws" {
  region = var.aws_region
}

# Generates a random 4-byte hex suffix (e.g. "a3f9")
resource "random_id" "suffix" {
  byte_length = 4
}

# IAM Role for Lambda
resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role-${random_id.suffix.hex}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Effect = "Allow",
      Sid    = ""
    }]
  })

  lifecycle {
    create_before_destroy = true
  }
}

# Attach basic Lambda execution policy
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Lambda function
resource "aws_lambda_function" "node_app" {
  function_name = "node-app-${random_id.suffix.hex}"  # ✅ Unique Lambda name

  role          = aws_iam_role.lambda_exec.arn
  handler       = "app.handler"
  runtime       = "nodejs18.x"
  filename      = "lambda.zip"
  source_code_hash = filebase64sha256("lambda.zip")

  environment {
    variables = {
      NODE_ENV = "production"
    }
  }

  depends_on = [aws_iam_role_policy_attachment.lambda_basic_execution]
}
