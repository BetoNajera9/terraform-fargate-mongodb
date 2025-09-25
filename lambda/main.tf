data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "./lambda-functions/${var.function_name}.py"
  output_path = "./${var.function_name}.zip"
}

resource "aws_lambda_function" "deployment_strategy" {
  function_name = var.function_name
  description   = "Auto-redeploy ECS service on ECR image push"
  role          = var.iam_lambda_deployment_strategy_role_arn
  runtime       = "python3.11"
  handler       = var.handler
  timeout       = 60
  memory_size   = 256

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = var.environment_variables
  }

  depends_on = [aws_cloudwatch_log_group.lambda_deployment_strategy_log_group]

  tags = {
    Name = var.function_name
  }
}

resource "aws_cloudwatch_log_group" "lambda_deployment_strategy_log_group" {
  name              = "/lambda/${var.function_name}"
  retention_in_days = 14

  tags = {
    Name = "/lambda/${var.function_name}"
  }
}
